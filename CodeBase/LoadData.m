
% load required raw data
function result = LoadData(DataKind, num, DataFileNumber)
% <input>
% DataKind      : the data kind in database (eg: 'GPS', 'POS', 'IMU')
% num           : flight conditions 
% DataFileNumber: current data file (eg: '1.mat', '2.mat', etc)
% <output>
% result        : get required data from the current flight

% get current data folder path (GeneralDataPath + FlightDataFolder)
DataFolderPath = DatabaseManager('DataPath', num);

% get current datafile name
datafile = DatabaseManager('Datafile', DataFileNumber);

% load data from data path (GeneralDataFolder + CurrentDataFolder + datafile)
DataPATH = fullfile(DataFolderPath, datafile);
load(DataPATH)

% pick data from raw data based on data kind
eval(['result', '=', DataKind, ';']);
end