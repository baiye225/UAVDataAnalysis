% grab data for zoom in morphing in the figure
% TimeShift earlier before morphing and TimeShift later after morphing 

function BodyRate = GetTwoPlotDataZoom(BodyRate, MorphingTime, TimeShift)

% get time of the figure eight flight
Time1 = BodyRate.BodyRate1.time;
Time2 = BodyRate.BodyRate2.time;

% get time of the morphing
time1 = MorphingTime.MorphingTime1;
time2 = MorphingTime.MorphingTime2;

% pick up zoom in start and end time 
% (use TimeShift to pick up earlier before MorphingTime.Start,
%  and later after MorphingTime.End)
TimeStart = time1.Start - TimeShift;
TimeEnd   = max(time1.End, time2.End) + TimeShift;

% pick up index according to zoom in time
Index1.Start = FindIndex(TimeStart, Time1);
Index1.End   = FindIndex(TimeEnd, Time1);

Index2.Start = FindIndex(TimeStart, Time2);
Index2.End   = FindIndex(TimeEnd, Time2);

BodyRate.BodyRate1 = ZoomInBodyRateData(BodyRate.BodyRate1, Index1);
BodyRate.BodyRate2 = ZoomInBodyRateData(BodyRate.BodyRate2, Index2);

end


% pick up data from index
function BodyRate = ZoomInBodyRateData(BodyRate, Index)
% grab zoom in body rate data from index
BodyRate.time  = BodyRate.time(Index.Start:Index.End);
BodyRate.roll  = BodyRate.roll(Index.Start:Index.End);
BodyRate.pitch = BodyRate.pitch(Index.Start:Index.End);
BodyRate.yaw   = BodyRate.yaw(Index.Start:Index.End);
end