% this function grab index between morphing time (start morphing and end morphing)

% find start time and end time from servo(morphing)
function Time = MorphingStartEndTime(servo)
% find morphing time from servo and intergrate into Time
Servo = ServoDataProcess(servo);
Time.Start = Servo.start_time;
Time.End   = Servo.end_time;

end

% process the servo data
function Servo = ServoDataProcess(servo)
% <input>
% rc command: data (eg:RCOU = [time, servo_command])
% time range: time_range

% <output>
% servo = 
%        servo.data
%        servo.start_index
%        servo.end_index
%        servo.start_time
%        servo.end_time

Servo.data = servo;
[Servo.start_index, Servo.end_index] = ServoStartEnd(Servo.data);
Servo.start_time                     = Servo.data(Servo.start_index, 1);
Servo.end_time                       = Servo.data(Servo.end_index, 1);

end

% find index of morphing in servo
function [StartIndex, EndIndex] = ServoStartEnd(servoData)
% find where the servo command change (morphing)
n = 1;
% find start index
% morphing happened when the servo command is changed from 1816 to 958
    while servoData(n + 1,2) - servoData(n,2) ~= -858
        n = n + 1;
    end
StartIndex = n;

% find end index
% morphing back happened when the servo command is changed from 958 to 1816
    while servoData(n + 1,2) - servoData(n,2) ~= 858
        n = n + 1;
    end
EndIndex = n;    
end

