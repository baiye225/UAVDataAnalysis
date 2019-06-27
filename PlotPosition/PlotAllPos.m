
% plot all flight path
function PlotAllPos(AllPOS)
% get the number of flights
DataSize = size(AllPOS,1);

% plot
figure
hold on
grid on
grid minor
    for n = 1:1:DataSize
        plot3(AllPOS(n).x, AllPOS(n).y, AllPOS(n).z)    
    end
hold off



xlabel('x m')
ylabel('y m')
title('figure eight flight path')
end




