% plot flight path with splitter

function PlotPosMananger(request, input, input2, input3)
% <input>
% request: the way to request the data (eg: normal, dynamic)
% input: current input parameter related to request
% input2: additional parameter

    switch request
        case 'FirgureSetup'
            % set up plot parameters of position
            FigureSetupPos()
            
        case 'FigureEight'
            % plot figure eight
            % input: S
            PlotFigureEight(input)
            
        case 'WaypointsCircle'
            % plot waypoints circle
            % input: AllWPCircles
            PlotWPCircles(input)
            
        case 'SlicePi'
            % plot slice pi of the current circle
            % input:  SPi
            % input2: CircleCenter
            % input3: plot type
            PlotSlicePi(input, input2, input3)
            
        case 'Animation'
            % animate flight path of the 1st circle
            % input:  Position
            % input2: Index
            % input3: plot type
            AnimationFlightPath(input, input2, input3)
            
        case 'Path'
            % plot whole flight path
            % input:  Position
            % input2: plot type
            PlotPath(input, input2)
    end

end

% 'FirgureSetup'
function FigureSetupPos()
% set up plot parameters
figure
grid on
grid minor
% title('Splitting method of flight path ')
xlabel('X m')
ylabel('Y m')
axis([-15 15 -8 8])
end

% 'FigureEight'
function PlotFigureEight(S)
% plot figure eight
hold on
plot(S(:,1), S(:,2), 'rx-')
hold off
end

% 'WaypointsCircle'
function PlotWPCircles(AllWPCircles)
% plot waypoints circles
hold on
n = size(AllWPCircles, 1);
    for i = 1:1:n
        plot(AllWPCircles(i).x, AllWPCircles(i).y, '--')
    end
end

% 'SlicePi'
function PlotSlicePi(SPi, CircleCenter, type)
% plot figure eight path and slice pi (display only)
hold on

% center of the slice pi
x0 = CircleCenter(1,1);
y0 = CircleCenter(1,2);

% plot pi arc
plot(SPi(:,1), SPi(:,2), type)

% plot pi edge
n = size(SPi, 1);
    for i = 2:1:n
        plot([x0 SPi(i,1)], [y0 SPi(i,2)], type)
    end
hold off
end

% 'Animation'
function AnimationFlightPath(Position, Index, type)
% animation splitted flight path 
hold on
n = size(Index, 1);
Index(1, 1) = 2;
    for i = 1:1:n
        IndexStart = Index(i, 1) - 1;
        IndexEnd   = Index(i, 2);
        x = Position(IndexStart : IndexEnd, 1);
        y = Position(IndexStart : IndexEnd, 2);
        plot(x, y, type, 'LineWidth', 2)
        pause(0.5)
    end
hold off
end

% 'Path'
function PlotPath(Position, type)
% plot flight path
hold on
x = Position(:, 1);
y = Position(:, 2);
plot(x, y, type, 'LineWidth', 2)
hold off
end



