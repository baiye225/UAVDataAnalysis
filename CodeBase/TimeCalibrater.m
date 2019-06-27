% time calibrater

function output = TimeCalibrater(request, input)
% <input>
% request: the way to calibrate time (eg: datapath, datafile, etc)
% input: current input parameter related to request
% input2: additional parameter
    switch request
        case 'TimeDisplacement'
            % generally process the time
            % input: time
            FinalTime = TimeDisplacement(input);
            output    = FinalTime;
            
        case 'UnitConversion'
            % time in display (change unit)
            % input: time
            NewTime = TimeDisplay(input);
            output  = NewTime;
            
        case 'Zerolize'
            % set first time as the start time point (0 second)
            % input: time
            NewTime = TimeZerolize(input);
            output  = NewTime;
    end
end

% 'TimeDisplacement'
function FinalTime = TimeDisplacement(time)
% generally process the time
% 1. change unit from us to s
% 2. setup first time point as zero
NewTime = TimeDisplay(time);
FinalTime = TimeZerolize(NewTime);

end

% 'UnitConversion'
function NewTime = TimeDisplay(time)
% time in display (change unit)
% transform us into s
NewTime = time ./10^6;

end

% 'Zerolize'
function NewTime = TimeZerolize(time)
% mark initial time as zero
NewTime = time - time(1,1);

end
