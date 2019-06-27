
% process the result and save it
function SaveResult(result, num, request)
% get name of the result file
% processing kind(eg: 'AllStartEnd', 'MorphingStartEnd', 'PosErr')
% + current flight condition
ResultName = DatabaseManager('ResultName',num, request);
eval([ResultName, '=', 'result;']);

% integrate save path and save
ResultFile = strcat(ResultName, '.mat'); % 
SavePath   = fullfile('.', 'results', ResultFile);
save(SavePath, ResultName)
end