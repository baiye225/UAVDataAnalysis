
% Pick data from data index
function output = PreProsData(request, FlightType, data, DataType,...
                              IndexStruct, DataFileNumber)
% <input>
% request: the way to pre process the data (eg: AllStartEnd, MorphingStartEnd)
% input:   current input parameter related to request
% input2:  additional parameter
% <output>
% output:  data with required range of index
    switch request
        case 'AllStartEnd'
            % pre process 'AllStartEnd' data
            ProsData = PreProsAllStartEnd(FlightType, data, DataType,...
                                       IndexStruct, DataFileNumber);
            output = ProsData;
            
        case 'MorphingStartEnd'
            % pre process 'MorphingStartEnd' data
            MorphingTime = PreProsMorphingStartEnd(data, DataType,...
                                                IndexStruct, DataFileNumber);
            output = MorphingTime;
    end

end

% pre process 'AllStartEnd' data
function ProsData = PreProsAllStartEnd(FlightType, data, DataType,...
                                       IndexStruct, DataFileNumber)
% get index
% if the flight is loiter test, then use all index (1 to end)
    if strcmp(FlightType, 'FigureEight')
        [IndexStart, IndexEnd] = PickIndex('AllStartEnd', DataType,...
                                            IndexStruct, DataFileNumber);
    elseif strcmp(FlightType, 'LoiterTest')
        IndexStart = 1;
        IndexEnd   = size(data(:, 1), 1);   
    end
    
% grab and integrate data
DataTypeIndex = DataKindIndex(DataType);
ProsData      = StructData(data(IndexStart:IndexEnd,DataTypeIndex), DataType);                               
end

% pre process 'MorphingStartEnd' data
function MorphingTime = PreProsMorphingStartEnd(data, DataType,...
                                                IndexStruct, DataFileNumber)
% get index
[IndexMrph, IndexEndMrph] = PickIndex('MorphingStartEnd', DataType,...
                                       IndexStruct, DataFileNumber);
                                   
% pick morphing time
MorphingTime = GetMorphingTime(data(:,2), IndexMrph, IndexEndMrph);
end

% get index
function [IndexStart, IndexEnd] = PickIndex(IndexType, DataType,...
                                            IndexStruct, DataFileNumber)
% pick index based on Index type ('AllStartEnd' or 'MorphingStartEnd')
CurrentAllIndex = PickIndexType(IndexType, IndexStruct);
    
% pick index based on data type ('GPS', 'RCOU', 'IMU', 'POS')
CurrentIndex = PickDataType(DataType, CurrentAllIndex);

% pick start and end index based DataFileNumber ('1.mat', '2.mat', etc)
[IndexStart, IndexEnd] = PickIndexData(CurrentIndex, DataFileNumber);

end

% pick index from flight type (eg: AllIndex, MrphIndex)
function CurrentAllIndex = PickIndexType(FlightType, IndexStruct)
% choose start and end or morphing index
    switch FlightType
        case 'AllStartEnd'
            CurrentAllIndex = IndexStruct.AllIndex;
        case 'MorphingStartEnd'
            CurrentAllIndex = IndexStruct.MrphIndex;
    end

end

% pick index from data type (eg: GPS, RCOU, POS, IMU, etc)
function result = PickDataType(DataType, Index)
% choose specific index type
    switch DataType
        case 'GPS'
            result = Index(:,[1,2]);
        case 'RCOU'
            result = Index(:,[3,4]);
        case 'POS'
            result = Index(:,[5,6]);
        case 'IMU'
            result = Index(:,[7,8]);
    end

end

% pick start and end index
function [IndexStart, IndexEnd] = PickIndexData(Index, n)
IndexStart = Index(n,1);
IndexEnd   = Index(n,2);
end

% pick data based on data kind index (row1 to row2, eg: IMU[2:5])
function result = DataKindIndex(DataType)
    switch DataType
        case 'IMU'
            result = 2:5;
        case 'POS'
            result = 2:5;
    end
    
end

% split into different variables
function Data = StructData(data, DataType)
    switch DataType
        case 'IMU'
            % converse unit (rad/s to degree/s)
            data(:, 2:4) = rad2deg(data(:, 2:4));
            Data = struct('time', data(:,1), 'roll', data(:,2),...
                          'pitch', data(:,3), 'yaw', data(:,4));
        case 'POS'
            Data = struct('time', data(:,1), 'lat', data(:,2),...
                          'lon', data(:,3), 'alt', data(:,4));
    end
    
end

% get morphing start and end time
function MorphingTime = GetMorphingTime(time, IndexMrph, IndexEndMrph)
 % pick morphing time based on morphing index
 MorphingTime.Start = time(IndexMrph);                                                        
 MorphingTime.End   = time(IndexEndMrph);                                                           

end