% plot dynamic pos and spliiter or normal pos

function PlotPosAnalysis(request, S, SPi, CircleCenter, Position, Index)
% <input>
% request:      the way to request the data (eg: normal, dynamic)
% S:            figure eight path
% SPi:          slice pi
% CircleCenter: centers of two figure eight circles
% Position:     flight path data (m)
% Index:        splitted index


% choose normal plot or dynamic plot
    switch request
        case 'Normal'
            % plot dynamic pos and spliiter
            PlotNormalPos(S, SPi, CircleCenter, Position)
        case 'Dynamic'
            % plot normal pos and splitter
            PlotDynamicPos(S, SPi, CircleCenter, Position, Index)
    end

end

% plot dynamic pos and spliiter
function PlotDynamicPos(S, SPi, CircleCenter, Position, Index)

% set up plot parameters of position
PlotPosMananger('FirgureSetup', '2D')

% plot figure eight
PlotPosMananger('FigureEight', '2D', S)      

% plot slice pi and flight path of the 1st circle
PlotPosMananger('SlicePi', SPi.SPi1, CircleCenter.Center1, 'k--')
PlotPosMananger('Animation', Position, Index.Index1, 'b-')

% delete slice pi of the 1st circle (use white line to cover)
PlotPosMananger('SlicePi', SPi.SPi1, CircleCenter.Center1, 'w--')

% plot slice pi and flight path of the 2nd circle
PlotPosMananger('SlicePi', SPi.SPi2, CircleCenter.Center2, 'k--') 
PlotPosMananger('Animation', Position, Index.Index2, 'b-')

% finally re-display slice pi of the 1st circle
PlotPosMananger('SlicePi', SPi.SPi1, CircleCenter.Center1, 'k--') 

end

% plot normal pos and splitter
function PlotNormalPos(S, SPi, CircleCenter, Position)

% set up plot parameters of position
PlotPosMananger('FirgureSetup', '2D')

% plot flight path
PlotPosMananger('Path', '2D', Position, 'b-')

% plot figure eight and slice pi of two circles
PlotPosMananger('FigureEight', '2D', S)
PlotPosMananger('SlicePi', SPi.SPi1, CircleCenter.Center1, 'k--')
PlotPosMananger('SlicePi', SPi.SPi2, CircleCenter.Center2, 'k--') 

legend('Flight path', 'Desired path', 'Path splitter')
end