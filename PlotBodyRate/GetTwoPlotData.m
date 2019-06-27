% get two plot data
function [BodyRate, MorphingTime] = GetTwoPlotData(data1, data2,...
                                                   DataFileNumber1, DataFileNumber2,...
                                                   IndexStruct)
% get plot data
[BodyRate1, MorphingTime1] = PreProsTwoData(data1, 'IMU', IndexStruct(1), DataFileNumber1);
[BodyRate2, MorphingTime2] = PreProsTwoData(data2, 'IMU', IndexStruct(2), DataFileNumber2);

% time adjustment
[BodyRate1.time, BodyRate2.time, MorphingTime1, MorphingTime2] = ...
    TwoTimeAdjustment(BodyRate1.time, BodyRate2.time, MorphingTime1, MorphingTime2);

% wrap the results
BodyRate.BodyRate1 = BodyRate1;
BodyRate.BodyRate2 = BodyRate2;
MorphingTime.MorphingTime1 = MorphingTime1;
MorphingTime.MorphingTime2 = MorphingTime2;
                                            
end

% Pre process two data (body rate and morphing time)
function [BodyRate, MorphingTime] = PreProsTwoData(data, DataType, IndexStruct, DataFileNumber)
BodyRate     = PreProsData('AllStartEnd', data, DataType, IndexStruct, DataFileNumber);
MorphingTime = PreProsData('MorphingStartEnd', data, DataType, IndexStruct, DataFileNumber);
end


% time adjustment
function [Time1, Time2, time1, time2] = TwoTimeAdjustment(Time1, Time2, time1, time2)
% <input>
% Time: BodyRate.time
% time: MorphingTime (MorphingTime.Start, MorphingTime.End)

% adjust time of data 2 (use data 1 morphing time as a reference)
% to make morphing start time of two flights are the same
[Time2, time2] = CalibrateTime(Time2, time1, time2);

% calibrate all time (setup zero point and change unit)
[Time1, Time2, time1, time2] = AllTimeDisplacement(Time1, Time2, time1, time2);
end

% calibrate time of data 2 (use data 1 as a reference)
function [Time2, time2] = CalibrateTime(Time2, time1, time2)
% calculate time difference between two morphing start time                                                     
TimeDifference     = time2.Start - time1.Start;

% shift time
Time2       = Time2       - TimeDifference;
time2.Start = time2.Start - TimeDifference;
time2.End   = time2.End   - TimeDifference;
 
end

% calibrate all time (two body rate time and two morphing time)
function [Time1, Time2, time1, time2] = AllTimeDisplacement(Time1, Time2, time1, time2)
% setup time reference at the original time  point
Reference = min(Time1(1), Time2(1));

% change unit and setup zero point as the reference of body rate time
Time1       = TimeCalibrater('UnitConversion', Time1       - Reference);
Time2       = TimeCalibrater('UnitConversion', Time2       - Reference);
time1.Start = TimeCalibrater('UnitConversion', time1.Start - Reference);
time1.End   = TimeCalibrater('UnitConversion', time1.End   - Reference);
time2.Start = TimeCalibrater('UnitConversion', time2.Start - Reference);
time2.End   = TimeCalibrater('UnitConversion', time2.End   - Reference);
end
