% load Body rate index of two flights

% load and integrate two kinds of index (two all indexes and two morphing indexes)
function IndexStruct = LoadTwoIndex(FlightType, num1, num2)
% load one type of index of two file
IndexStruct(1)   = IndexManager('OneFlight', FlightType, num1);
IndexStruct(2)   = IndexManager('OneFlight', FlightType, num2);

end
