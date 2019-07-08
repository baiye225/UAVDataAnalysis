% load Body rate of two flights

% get two IMU
function [IMU1, IMU2] = LoadTwoIMU(DataKind, FlightType, num1, num2, DataFileNumber1, DataFileNumber2)
IMU1 = LoadData(DataKind, FlightType, num1, DataFileNumber1);
IMU2 = LoadData(DataKind, FlightType, num2, DataFileNumber2);
end






