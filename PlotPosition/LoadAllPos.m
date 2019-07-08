
% load and integrate all flights position
function AllPOS = LoadAllPos(num)

% initialize data folder path (based on flight condition) and data size
DataFolderPath = DatabaseManager('DataPath', 'FigureEight', num); 
DataSize       = DatabaseManager('DataNumber', 'FigureEight', num); 

% load and integrate each flight
    for n = 1:1:DataSize
        % get current datafile name
        datafile = DatabaseManager('Datafile', n); 
            
        % load the current datafile
        DataPATH = fullfile(DataFolderPath, datafile);
        load(DataPATH)
         
        % rename the current datafile
        pos = POS(:, [2,3,4,5]);
        result = GPS2POS(pos(:,[2,3])); % transform GPS into 2D system
        AllPOS(n,1).time = pos(:,1);
        AllPOS(n,1).x    = result(:,1);
        AllPOS(n,1).y    = result(:,2);
        AllPOS(n,1).z    = pos(:,4);
    end

end

