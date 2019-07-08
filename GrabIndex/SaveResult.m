% save the name as *.mat
% eg: 'AllStartEnd_v15_wp10_morph0_normal'

% process the result and save it
function SaveResult(result, FlightType, num, request)
ResultName = DatabaseManager('ResultName', FlightType, num, request);
eval([ResultName, '=', 'result;']);

% integrate save path and save
ResultFile = strcat(ResultName, '.mat'); % 
SavePath   = fullfile('.', 'results', ResultFile);
save(SavePath, ResultName)
end