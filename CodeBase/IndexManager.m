
% Index Manager

function output = IndexManager(request, input, input2, input3)
% <input>
% request: the way to request the index (eg: Single, OneFlight, etc)
% input:   current input parameter related to request
% input2:  additional parameter(optional)
% input3:  additional parameter(optional)
% <output>
% output:  required index from index database


    switch request
        case 'Single'
            % load one index
            % input:  FlightType (eg: 'FigureEight', 'LoiterTest') 
            % input2: index type ('AllStartEnd' or 'MorphingStartEnd')
            % input3: num(flight conditions)
            SingleIndex           = LoadIndex(input, input2, input3);
            IndexStruct           = BuildIndexStruct(input, input2, SingleIndex);
            output                = IndexStruct;  
            
        case 'OneFlight'
            % load one flights index (AllStartEnd and MorphingStartEnd)
            % input:  FlightType (eg: 'FigureEight', 'LoiterTest') 
            % input2: num(flight conditions)
            [AllIndex, MrphIndex] = LoadOneFlightIndex(input, input2);
            IndexStruct           = struct('AllIndex', AllIndex,...
                                           'MrphIndex', MrphIndex);
            output                = IndexStruct;
            
    end

end

% load one index
function result = LoadIndex(FlightType, request, num)
% integrate result path (ResultsDataFolder + SaveName)
ResultPath = DatabaseManager('ResultPath', FlightType, request, num);

% load file and file name
load(ResultPath);
ResultDataName = DatabaseManager('ResultName', FlightType, num, request);

% save the file
eval(['result', '=', ResultDataName, ';']);

end

% load one flights index
function [AllIndex, MrphIndex] = LoadOneFlightIndex(FlightType, num)
% 1. start and end; 2. morphing and recover.
AllIndex  = LoadIndex(FlightType, 'AllStartEnd', num);           % whole flight
MrphIndex = LoadIndex(FlightType, 'MorphingStartEnd', num);      % whole flight
end

% integrate index into struct type
function IndexStruct = BuildIndexStruct(FlightType, request, Index)
% struct 'All Index' or 'Morphing Index'
    switch request
        case 'AllStartEnd'
            IndexStruct = struct('AllIndex', Index);
        case 'MorphingStartEnd'
            IndexStruct = struct('MrphIndex', Index);
    end
end


