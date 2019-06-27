
% split position into segments index
function Index = GetSplitIndex(Position, SPi, CircleCenter)
% <input>
% Position:     flight path (m)
% SPi:          slice pi
% CircleCenter: centers of two figure eight circles
% <output>
% index:        splitted index(Index.Index1, Index.Index2)

% calculate index of splitting segments
Index1 = SplitPath(Position, SPi.SPi1, CircleCenter.Center1, 1);
Index2 = SplitPath(Position, SPi.SPi2, CircleCenter.Center2, Index1(end, 2) + 1);
Index  = struct('Index1', Index1, 'Index2', Index2);

end


% split each circle flight path
function Index = SplitPath(Position, SPi, CircleCenter, StartIndex)

% initialize triangle points
Triangle = struct('point0', CircleCenter,...
                  'point1', SPi(1, [1,2]), 'point2', SPi(2, [1,2]));

% initialize for loop parameters 
n = size(Position, 1); % size of the flight path data
m = size(SPi, 1) - 1;  % size of the split segments
j = 1;                 % initialize index of split segments

% first start index starts from the first position point 
Index(1, 1)   = StartIndex; 

% split flight path points one by one
    for i = StartIndex:1:n  
        if IsInTriangle(Triangle, Position(i, :)) == 1
            % current point is in the current tri-angle
            continue
        else
            % current point is not in the current tri-angle
            % save end index 
            % (the index of the last point is the current end index)
            Index(j, 2) = i - 1; % end index of the current slice pi
            
            if j == m
                break
            end
            
            % save start index 
            % (the index of the current point is the next start index)
            Index(j + 1, 1) = i; % start index of the next slice pi  

            
            % update tri-angle
            Triangle.point1 = SPi(j + 1, [1,2]);
            Triangle.point2 = SPi(j + 2, [1,2]);
            
            % update index of the segment   
            j = j + 1;            
        end       
    end
    
% last end index starts from the first position point     
Index(j, 2) = i - 1;
    
end

function result = IsInTriangle(Triangle, point)

% get tri-angle points (2d to 3d, z = 0)
O = [Triangle.point0, 0]; % 'O': center point of the current circle 
A = [Triangle.point1, 0]; % 'A': slice pi point of the prev waypoint
B = [Triangle.point2, 0]; % 'B': slice pi point of the next waypoint

% get current position (2d to 3d, z = 0)
P = [point, 0]; % 'P'

% get three triangle vectors and three vector from P to A, B, and O
OA = A - O; PA = A - P;
AB = B - A; PB = B - P;
BO = O - B; PO = O - P;

% cross product
n1 = cross(OA, PA);
n2 = cross(AB, PB);
n3 = cross(BO, PO);

% check if P is in triangle OAB
% (z of all cross product result should be the same sign)
    if n1(3) >= 0 && n2(3) >= 0 && n3(3) >= 0
        result = 1;
    elseif n1(3) <= 0 && n2(3) <= 0 && n3(3) <= 0
        result = 1;
    else
        result = 0;
    end
end