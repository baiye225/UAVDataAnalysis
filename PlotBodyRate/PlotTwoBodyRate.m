
% plot two body rate
function PlotTwoBodyRate(BodyRate, MorphingTime, DataType, FigureSetup, num1, num2)

% expand plot data
BodyRate1 = BodyRate.BodyRate1;
BodyRate2 = BodyRate.BodyRate2;

MorphingTime1 = MorphingTime.MorphingTime1;
MorphingTime2 = MorphingTime.MorphingTime2;

figure
% plot body rate
BodyRateAxisSetup()
PlotSingleBodyRate(BodyRate1, DataType, 'b-');
PlotSingleBodyRate(BodyRate2, DataType, 'r-');

% plot morphing servo
ServoAxisSetup()
Servo1 = PlotServo(BodyRate1.time, MorphingTime1, 'k-');
Servo2 = PlotServo(BodyRate2.time, MorphingTime2, 'k--');

% add morphing marker
% AddMorphingText(Servo1, FigureSetup)


% setup figure paramters
    switch FigureSetup
        case 'Normal'
            FigureNormalSetup(DataType, num1, num2)
        case 'Zoom'
            FigureZoomSetup(DataType)
    end
end

% add morphing marker
function AddMorphingText(Servo, FigureSetup)
% setup figure paramters
    switch FigureSetup
        case 'Normal'
            x1 = Servo(21,1);
            x2 = Servo(21,1);
        case 'Zoom'
            x1 = Servo(18,1);
            x2 = Servo(18,1);
    end
    
% mark the morphing on the servo
text(x1, 1.05,'Morphing', 'Color','red','FontSize',14) % point the morphing
text(x2, 0.05,'Normal', 'Color','red','FontSize',14) % point the normal

end

% plot body rate
function PlotSingleBodyRate(BodyRate, DataType, PlotType)
hold on
x = BodyRate.time;
y = GetOneBodyRate(BodyRate, DataType);
plot(x, y, PlotType, 'LineWidth', 1.5)
hold off
end

% pick one body rate
function OneBodyRate = GetOneBodyRate(BodyRate, DataType)
    switch DataType
        case 'Roll'
            OneBodyRate = BodyRate.roll;
        case 'Pitch'
            OneBodyRate = BodyRate.pitch;
        case 'Yaw'
            OneBodyRate = BodyRate.yaw;
    end
end

% plot morphing servo
function Servo = PlotServo(time, MorphingTime, PlotType)
hold on
Servo = GetServo(time, MorphingTime);
x = Servo(:,1);
y = Servo(:,2);
plot(x, y, PlotType, 'LineWidth', 1.5)
hold off
end

% initialize morphing servo
function Servo = GetServo(time, MorphingTime)
FirstPart  = linspace(time(1),MorphingTime.Start, 10);           % normal geometry
SecondPart = linspace(MorphingTime.Start, MorphingTime.End, 10); % morphed geometry
ThirdPart  = linspace(MorphingTime.End, time(end), 10);          % normal geometry
TimePart   = [FirstPart'; SecondPart'; ThirdPart'];
ServoPart = zeros(30, 1);
ServoPart(11:20, 1) = 1;
Servo = [TimePart, ServoPart];

end

% setup parameters in figure
function BodyRateAxisSetup()
xlabel('Time (s)','FontSize',14,'FontName',...
    'Palatino Linotype','FontWeight','Bold')
yyaxis left % left y axis is used for body rate
ylabel('Body Rate (degree/s)','FontSize',14,'FontName',...
    'Palatino Linotype','FontWeight','Bold')
end

% setup y axis range and label to make the servo more clear
function ServoAxisSetup()
yyaxis right % right y axis is used for servo
axis([-inf inf -0.1 1.1]);                                 % range
set(gca,'ytick',[0 1],'yticklabel',{'', ''},'FontSize',14,...
    'FontWeight','Bold') % label
end

% setup other parameters
function FigureNormalSetup(DataType, num1, num2)
% get the morphing angle
Name  = DatabaseManager('FlightParameters');
mrph1 = Name.mrph(num1.MRPHi);
mrph2 = Name.mrph(num2.MRPHi);
Degree1 = strcat(mrph1, '^{\circ}');
Degree2 = strcat(mrph2, '^{\circ}');
DegreeSwitch1 = strcat(mrph1, '^{\circ} Switch');
DegreeSwitch2 = strcat(mrph2, '^{\circ} Switch');

grid on; 
grid minor;
legend(Degree1, Degree2, DegreeSwitch1, DegreeSwitch2)
TitleName = strcat('Comparison of ', " ", DataType, " ", 'rate');
title(TitleName,'FontSize',16,'FontName',...
    'Palatino Linotype','FontWeight','Bold');
% Titile = strcat('comparison of ', DataType, 'between 21 and 27 morphing degree');
% title(Titile)
end

% setup other parameters
function FigureZoomSetup(DataType)
grid on; 
grid minor;
TitleName = strcat('Comparison of', " ", DataType, " ", 'rate');
title(TitleName,'FontSize',16,'FontName',...
    'Palatino Linotype','FontWeight','Bold');
% Titile = strcat('comparison of ', DataType, 'between 21 and 27 morphing degree');
% title(Titile)
end
