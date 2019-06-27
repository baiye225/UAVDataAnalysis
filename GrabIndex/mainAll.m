clc,clear,close all

% import the custom function from CodeBase
path(path,'..\CodeBase\'); 

%%%
% initial parameters(eg: 'AllStartEnd', 'MorphingStartEnd')
request = 'AllStartEnd';
%%%

% initialize range in Morphing (Morphing can only be used in 21 and 27 with servo command)
MRPHiNumber = struct('AllStartEnd', 1:1:3, 'MorphingStartEnd', 2:1:3);
MRPHNumber  = getfield(MRPHiNumber, request);
               
% process each experiment of flight (flight * 36) =>(2 * 2 * 3 * 3 = 36)
for Vi = 1:1:2                   % ["1.5", "2.5"]
    for WPi = 1:1:2              % ["10", "15"]
        for MRPHi = MRPHNumber   % ['0', '21', '27']
            for FPi = 1:1:3      % ["normal", "oneside", "twoside"]
                % update current num
                num = struct('Vi', Vi, 'WPi', WPi, 'MRPHi', MRPHi, 'FPi', FPi);
                
                % calculate result (around 10 flights)
                Point     = DataFileIndexProcessing(request, num);

                % initialize result name and save the result
                SaveResult(Point, num, request)
            end
        end
    end
end