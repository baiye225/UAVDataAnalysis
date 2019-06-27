clc,clear,close all

%%%
% initial parameters
request = 'AllStartEnd'; % (eg: 'AllStartEnd', 'MorphingStartEnd')

num               = struct('Vi', 1, 'WPi', 1, 'MRPHi', 2, 'FPi', 2);
                    % Vi    ["1.5", "2.5"]
                    % WPi   ["10", "15"]
                    % FPi   ['0', '21', '27']
                    % MRPHi ["normal", "oneside", "twoside"]
%%%
                    
% get all index
Point             = DataFileIndexProcessing(request, num);

