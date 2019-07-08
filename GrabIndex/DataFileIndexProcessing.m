
% process each experiment of flight (experiment * 10)
function Results = DataFileIndexProcessing(FlightType, request, num)
% <input>
% request: the required kind of index (eg: 'AllStartEnd', 'MorphingStartEnd')
% num:     flight condtion     
% <output>
% Results: Point (Index of all experiments in a flight)

% initialize data folder path (based on flight condition) and data size
DataFolderPath = DatabaseManager('DataPath', FlightType, num);   % (eg: ..\morphing test data (normal)\
                                                                 %  v1.5_wp10_morph0_normal)
DataSize       = DatabaseManager('DataNumber', FlightType, num); % (eg: 1.mat)

% initialize result of the index
Results = zeros(DataSize, 8);

% calculate all datafile in the current datafolder
    for n = 1:1:DataSize
        % get current datafile name (eg: '1.mat')
        datafile = DatabaseManager('Datafile', n); 
        
        % (GeneralDataFolder + CurrentDataFolder + datafile)
        DataPATH = fullfile(DataFolderPath, datafile);
        
        % load current datafile and get the time point  
        Results(n,:) = GetIndexResult(request, DataPATH);  % find start and end time from yaw        
    end
end

% get index according to request and datafile
function Result = GetIndexResult(request, DataPATH)
% load flight data
load(DataPATH)  

% pick up the required function of geting start and end time (two methods)
    switch request
        case 'AllStartEnd'
           % whole autonomous flight
           Time = AllStartEndTime(ATT(:,[2,8]), POS(:,[2:4]));
        case 'MorphingStartEnd'
           % morphing flight
           Time = MorphingStartEndTime(RCOU(:, [2,11]));
    end
    
% get the index and save into 'Point' file
Result = GetIndex(Time, GPS, RCOU, POS, IMU); % get index of the current flight
      
end