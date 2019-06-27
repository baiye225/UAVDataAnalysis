clc,clear,close all

% import the custom function from CodeBase
path(path,'..\CodeBase\'); 

%%%
% initial parameters(eg: 'AllStartEnd', 'MorphingStartEnd')
request = 'PosErr';
%%%

% process each experiment of flight (flight * 36)
for Vi = 1:1:2                   % ["1.5", "2.5"]
    for WPi = 1:1:2              % ["10", "15"]
        for MRPHi = 2:1:3        % ['0', '21', '27']
            for FPi = 1:1:3      % ["normal", "oneside", "twoside"]
                % update current num
                num   = struct('Vi', Vi, 'WPi', WPi, 'MRPHi', MRPHi, 'FPi', FPi);
                
                % calculate result (around 10 flights)
                PosError = DataFilePosProcessing(num);

                % initialize result name and save the result
                SaveResult(PosError, num, request)
            end
        end
    end
end