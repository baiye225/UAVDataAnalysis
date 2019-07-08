
% get the parameter of splitting method  based on num.WPi (["10", "15"])
function Results = DataFilePosProcessing(FlightType, num)

% initialize paramaters of spillter based on the flight conditions(num)
Name       = DatabaseManager('FlightParameters');
WP         = str2double(Name.wp(num.WPi));
Flightpath = (Name.fp(num.FPi));

IndexStruct  = IndexManager('Single', FlightType, 'AllStartEnd', num);
CircleCenter = struct('Center1', [-5.2115, 0],...          
                      'Center2', [5.2115, 0]);
S            = FigureEight(Flightpath, WP, CircleCenter);
SPi          = FigureEightSplitter(WP, CircleCenter);

                
% initialize result of the index
DataSize = DatabaseManager('DataNumber', FlightType, num); 
Results  = [];

% calculate all datafile in the current datafolder
    for n = 1:1:DataSize
        % calculate position error of the current flight
        PosError = ProsPosError(FlightType, num, S, SPi, CircleCenter, IndexStruct, n);
        
        % delete the wrong data (figure eight is incompleted)
        if size(PosError, 1) < WP * 2
            continue
        end
        
        % save result
        Results = [Results, PosError];  
    end
    
Results = PostProsPosError(Results, WP);
        
end

% Process position and get position error
function PosError = ProsPosError(FlightType, num, S, SPi, CircleCenter, IndexStruct, n)
% load raw position data
POS      = LoadData('POS', FlightType, num, n); 

% pre process data (grab data from index)
GPS      = PreProsData('AllStartEnd', FlightType, POS, 'POS', IndexStruct, n);

% GPS -> 2d coordinate system
Position = GPS2POS([GPS.lat, GPS.lon]);

% calculate index of splitting segments
Index    = GetSplitIndex(Position, SPi, CircleCenter);

% calculate position error
PosError = GetPosError(Position, S, Index);

end

% post process postion error (mark position error during morphing)
function Results = PostProsPosError(Results, WP)
% calculate mean value of each segment in all flights
AllSegmentsMean      = mean(Results, 2);

% grab mean value of morphing part
    switch WP
        % choose index range based on the number of waypoints
         case 10
             MorphingWPIndex = 4:7;
         case 15
             MorphingWPIndex = 5:11;
    end
MorphingSegmentsMean = mean(Results(MorphingWPIndex, :), 2);

% add three more row and put the two mean value data
Results = [Results, zeros(WP * 2, 3)];
Results(:, end - 1) = AllSegmentsMean;
Results(MorphingWPIndex, end) = MorphingSegmentsMean;

end







