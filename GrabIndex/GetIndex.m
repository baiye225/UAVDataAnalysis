
% grab index (start and end) of required data
% GPS:  GPS
% RCOU: servo output
% POS:  Position
% IMU:  body rate

% yaw 200 +/1 2

% ########### main API

function Index = GetIndex(Time, GPS, RCOU, POS, IMU)
% find point (index and time)
[GPSPoint, RCOUPoint, PosPoint, IMUPoint] = FindAllStartEndPoint(Time,GPS(:,2),...
                                                       RCOU(:,2), POS(:,2),...
                                                       IMU(:,2));
% for easily moving into excel
Index = [GPSPoint.StartIndex,  GPSPoint.EndIndex,...
         RCOUPoint.StartIndex, RCOUPoint.EndIndex,...
         PosPoint.StartIndex,  PosPoint.EndIndex,...
         IMUPoint.StartIndex,  IMUPoint.EndIndex]; 
end

% find all start and end point of designated data
function [Point1, Point2, Point3, Point4] = FindAllStartEndPoint(Time, data1,...
                                                         data2, data3,...
                                                         data4)
Point1 = FindStartEndPoint(Time.Start, Time.End, data1); % GPS
Point2 = FindStartEndPoint(Time.Start, Time.End, data2); % RC out
Point3 = FindStartEndPoint(Time.Start, Time.End, data3); % Position(lat, lon)
Point4 = FindStartEndPoint(Time.Start, Time.End, data4); % IMU(roll, pitch, yaw)
end

% find start point and end point
function Point = FindStartEndPoint(input1, input2, data)
Point.StartIndex = FindIndex(input1, data);
Point.StartTime  = data(Point.StartIndex);
Point.EndIndex   = FindIndex(input2, data);
Point.EndTime    = data(Point.EndIndex);
end



