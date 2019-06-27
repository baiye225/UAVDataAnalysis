% find index of input in data
function Index = FindIndex(input, data)
% find the index of data closed to the input (eg: the closet time us)
data_compare = abs(data - input);
Index = find(data_compare == min(data_compare));
end