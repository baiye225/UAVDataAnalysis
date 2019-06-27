
% Database and data path manager
function output = DatabaseManager(request, input, input2)
% <input>
% request: the way to request the data (eg: datapath, datafile, etc)
% input: current input parameter related to request
% input2: additional parameter 
% output: (see each case below)
    switch request                    
        case 'DataPath'
            % get the path of the current data file folder
            % input:  num(flight conditions)
            % output: (eg: '..\morphing test data\v1.5_wp10_morph0_normal')
            PATH               = DataFolderPath(input);
            output             = PATH;    
            
        case 'DataNumber'
            % the number of data in the current data folder
            % input:  num(flight conditions)
            % output: (eg: 10)
            DataFolderPATH     = DataFolderPath(input);
            DataSize           = DataNumber(DataFolderPATH);
            output             = DataSize;
            
        case 'Datafile'
            % get current data file name
            % input: current number of the datafile (eg: 1)
            % output: (eg: '1.mat')
            Datafile           = DataFileInitializer(input);
            output             = Datafile;
            
        case 'DataGeneralName'
            % get current data general name
            % DataGeneralName = datafolder + datafile
            % input: num(flight conditions)
            % input2: current number of the datafile (eg: 1)
            DataName           = GenerateName(input, input2);
            output             = DataName;
            
        case 'ResultName'
            % get the mat file name need to be saved
            % input: num(flight conditions)
            % input2: saved file type(head name)
            % output: (eg: 'AllStartEnd_v15_wp10_morph0_normal')   
            SavedDataFile      = ResultName(input, input2);
            output             = SavedDataFile;
            
        case 'ResultPath'
            % integrate the path of result data file
            % input: results data folder name
            % input2: num(flight conditions)
            PATH               = ResultFilePATH(input, input2);
            output             = PATH;
        case 'FlightParameters' 
            % get flight parameters database
            Name               = FlightParameters();
            output             = Name;
    end
end

% 'DataPath'
function PATH = DataFolderPath(num)
% get database folder and datafile folder
GeneralDataFolder  = DataBaseFolder();
Name               = FlightParameters();
CurrentDataFolder  = DataFolderInitializer(num, Name);   

% integrate data path (GeneralDataFolder + CurrentDataFolder)
PATH = fullfile('..', GeneralDataFolder, CurrentDataFolder);
        
end

% 'DataNumber'
function DataSize = DataNumber(DataFolderPATH)
% the number of data in the current data folder
FolderPATH     = fullfile(DataFolderPATH, '*.mat'); 
FolderList     = dir(FolderPATH);      % list all .mat file
DataSize       = size(FolderList, 1);  % count the number of .mat file
end

% 'Datafile'
function Datafile = DataFileInitializer(input)
% integrate current data file name
% build data file name based on current number (eg: '1.mat', '2.mat', etc)
Datafile = strcat(num2str(input), '.mat');
end

% 'DataGeneralName'
function DataName = GenerateName(num, n)
% flight condition (data folder name)
Name               = FlightParameters();
CurrentDataFolder  = DataFolderInitializer(num, Name);   

% data number ('1.mat', '2.mat')
datafile = DatabaseManager('Datafile', n);

% integrate name
DataName = strcat(CurrentDataFolder, " ", datafile);
end

% 'ResultName'
function SavedDataFile = ResultName(num, TypeName)
% initialize save data file name (eg: Point_Point_v15_wp10_morph0_normal) 
Name          = FlightParameters();
SavedDataFile = strcat(TypeName, '_',...
                       'v', Name.v_name(num.Vi), '_',...
                       'wp', Name.wp(num.WPi), '_',...
                       'morph', Name.mrph(num.MRPHi), '_',...
                        Name.fp(num.FPi));
% string to char                   
SavedDataFile = char(SavedDataFile); % eg: "Point_Point_v15_wp10_morph0_normal" >
                                     %     'Point_Point_v15_wp10_morph0_normal'
end

% 'ResultPath'
function PATH = ResultFilePATH(request, num)
% integrate data path (GeneralDataFolder + CurrentDataFolder)
% integrate result path (ResultsDataFolder)
ResultsDataFolder = ResultsFolder(request);

% integrate result file
ResultDataName    = DatabaseManager('ResultName',num, request);
ResultDataFile    = strcat(ResultDataName, '.mat');

% generate paths of two results file
PATH              = fullfile('..', ResultsDataFolder, ResultDataFile); 
end

% initialize flight parameters
function Name = FlightParameters()
Velocity      = ["1.5", "2.5"];                    % 1, 2
Velocity_name = ["15", "25"];                      % variable cannot use 1.5, 2.5
WayPoints     = ["10", "15"];                      % 1, 2
Morphing      = ["0", "21", "27"];                 % 1, 2, 3
FlightPath    = ["normal", "oneside", "twoside"];  % 1, 2, 3

% integrate name
Name          = struct('v', Velocity, 'wp', WayPoints, 'fp', FlightPath,...
                       'mrph', Morphing, 'v_name', Velocity_name);
end

% Data Base Folder Name
function DataBaseFolderName = DataBaseFolder()
% initialize database folder name
DataBaseFolderName = 'morphing test data';
end

% Data Folder Name
function CurrentDataFolder = DataFolderInitializer(num, Name)
% initialize current data folder name
CurrentDataFolder = strcat('v', Name.v(num.Vi), '_',...
                           'wp', Name.wp(num.WPi), '_',...
                           'morph', Name.mrph(num.MRPHi), '_',...
                            Name.fp(num.FPi));                      
end

% Results folder name
function ResultsFolderName = ResultsFolder(FolderName)
% initialize folder name of results
    switch FolderName
        case 'AllStartEnd'
            ResultsDataFolder = 'all start and end point';
        case 'MorphingStartEnd'
            ResultsDataFolder = 'morphing index';
    end
ResultsGeneralName = 'Results';
ResultsFolderName  = fullfile(ResultsGeneralName, ResultsDataFolder);
end