% this function grab index from start point (start from the center of the figure eight)
% and end point (return back to the center of figure eight)

% find start time and end time from yaw
function Time = AllStartEndTime(yaw, pos)
% <input>
% yaw = [time, yaw_attitude]
% pos = [time, latitute, longitude]
% <output>
% StartTime and EndTime

% blurry find
A             = find(yaw(:,2) > 300);
StartFindTime = yaw(A(1),1); 
EndFindTime   = yaw(A(end),1); 

% accurate find
StartIndex = FindStartIndex(StartFindTime, yaw);
EndIndex   = FindEndIndex(EndFindTime, pos);

% output time
Time.Start = yaw(StartIndex, 1);
Time.End   = yaw(EndIndex, 1);

end

% find start index by locating start heading
function StartIndex = FindStartIndex(StartFindTime, data)
B1 = find(data(:, 2) < 203 & data(:,1) < StartFindTime);
B2 = diff(B1);

StartIndex = B1(find(B2 == max(B2)) + 1);
StartIndex = CheckStartIndex(StartIndex);
end

% check start index to avoid special condition
function result = CheckStartIndex(StartIndex)
% if the hovering heading is closed to the first waypoint heading,
% it is hard to locate the index of the first waypoint.
% it is necessary to compromise it by using the end index of B2
    if size(StartIndex,1) ~= 1
        result = StartIndex(end);
    else
        result = StartIndex;
    end
end

% find end index by locating end waypoint
function EndIndex = FindEndIndex(EndFindTime, data)
% when the quad reach to the final waypoint circle
% the figure eight flight will be assumed it is completed

% GPS ---> 2D coordinate system
pos = GPS2POS(data(:,[2,3]));

% calculate distance between each position point and original point
reference = [0, 0];
Distance  = DistanceToZero(pos, reference);

B1 = find(Distance(:, 1) < 1 & data(:,1) > EndFindTime);
B1 = CheckEndHeading(B1, pos, data, EndFindTime);
EndIndex = B1(1);
end

% check end index to avoid special condition
function result = CheckEndHeading(B1, pos, data, EndFindTime)
% <input>
% B1: result index
% pos: [x, y]
% data: [time, latitude, longitude]

    % if the flight path is bad or landing heading is wrong,
    % choose the current landing position as a reference
    if isempty(B1) == 1
        % calculate landing heading appoximately based on the latest part of data
        POSGroup  = pos(end-50:end, :);                % get last 50 position points
        reference = [mean(POSGroup(:, 1)), mean(POSGroup(:, 2))]; % calculate last approximate position
        Distance  = DistanceToZero(pos, reference);     
        result    = find(Distance(:, 1) < 1 & data(:,1) > EndFindTime);
    else
        result = B1;
    end

end

% calculate distance between each position point and referece
function result = DistanceToZero(pos, reference)
result = sqrt((pos(:, 1) - reference(1)).^2 + (pos(:, 2) - reference(2)).^2);
end
