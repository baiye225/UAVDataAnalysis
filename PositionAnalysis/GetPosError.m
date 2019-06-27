% calculate position error of all segments

function PosError = GetPosError(Position, S, Index)
% <input>
% Position: flight path data
% S:        figure eight data (provide two points straight line)
% Index:    index of each segment

% <output>
% PosError: position error (mean square error) of all segments

Index  = [Index.Index1; Index.Index2];
n      = size(Index, 1);
PosError = zeros(n, 1);
    for i = 1:1:n
        % get position of current segment
        Pos = Position(Index(i, 1):Index(i, 2), :); 

        % get straight line based on the two point2
        x1 = S(i, 1);
        y1 = S(i, 2);
        point1 = struct('x', x1, 'y', y1);
        
        x2 = S(i + 1, 1);
        y2 = S(i + 1, 2);       
        point2 = struct('x', x2, 'y', y2);
        
        Line   = CalStraightLine(point1, point2);
        
        % calculate position error of the current segment
        PosError(i, 1) = CalPosError(Line, Pos);     
    end


end


% calculate position error of single segment
function result = CalPosError(Line, Pos)
% <input>
% Line: current straight line
% Pos:  current position

% the shortest distance from current position
% to the straight line (point1 and point2)
% is the position error

% <output>
% result: mean square error of the position error


% get coefficients of the straight line
A = Line.A;
B = Line.B;
C = Line.C;

% get size of position of the current segment
n = size(Pos, 1);

% initialize distance error data
D = zeros(n, 1);

% calculate position error one by one
    for i = 1:1:n
        x = Pos(i, 1);
        y = Pos(i, 2);
        D(i, 1) = abs(A*x + B*y + C)/sqrt(A^2 + B^2);
    end
    
% mean error
result = sum(D.^2)/n;

end


% get stright line based on two points
function Line = CalStraightLine(point1, point2)
% <input>
% point1: [point1.x, point1.y]
% point2: [point2.x, point2.y]

% <output>
% Line: coefficients of the Line (A, B, C)
% Line.A, Line.B, Line.C

% point1
x1 = point1.x;
y1 = point1.y;

% point2
x2 = point2.x;
y2 = point2.y;

% generate straight line: Ax + By + C = 0
A    = y2 - y1;
B    = x1 - x2;
C    = x2*y1 - x1*y2;
Line = struct('A', A, 'B', B, 'C', C);
end