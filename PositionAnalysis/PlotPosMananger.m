% plot flight path with splitter

function PlotPosMananger(request, input, input2, input3)
% <input>
% request: the way to request the data (eg: normal, dynamic)
% input: current input parameter related to request
% input2: additional parameter

    switch request
        case 'FirgureSetup'
            % set up plot parameters of position
            % input: plot dimention (eg: '2D', '3D')
            FigureSetupPos(input)
            
        case 'FigureEight'
            % plot figure eight
            % input: dimention (eg: '2D', '3D')
            % input2: figure eight data           
            PlotFigureEight(input, input2)
            
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
            % input: dimention (eg: '2D', '3D')
            % input2: Position
            % input3: plot type
            PlotPath(input, input2, input3)

    end

end

% 'FirgureSetup'
function FigureSetupPos(Dimention)
% set up plot parameters
figure
grid on
grid minor
xlabel('X (m)', 'FontSize', 14,'FontName',...
       'Palatino Linotype','FontWeight','Bold')
ylabel('Y (m)', 'FontSize', 14,'FontName',...
       'Palatino Linotype','FontWeight','Bold')
% title('Splitting method of flight path ')
    switch Dimention
        case '2D' 
            axis([-15 15 -8 8])
        case '3D'
            axis([-15 15 -8 8 -2 11])
            % add label of z axis
            zlabel('Z (m)', 'FontSize', 14,'FontName',...
                   'Palatino Linotype','FontWeight','Bold')      
    end


end

% 'FigureEight'
function PlotFigureEight(Dimension, S)
% plot figure eight
hold on

% choice of 2D plot or 3D plot
    switch Dimension
        case '2D'
            plot(S(:,1), S(:,2), 'rx-')
        case '3D'
            plot3(S(:,1), S(:,2), S(:,3), 'rx-')
    end
    
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
function PlotPath(Dimension, Position, type)
% plot flight path
hold on
x = Position(:, 1);
y = Position(:, 2);

% choice of 2D plot or 3D plot
    switch Dimension
        case '2D'
            plot(x, y, type, 'LineWidth', 2)
        case '3D'
            z = Position(:, 3); % pick up z coordinate
            plot3(x, y, z, type, 'LineWidth', 2)
    end

hold off
end




