initial_sequence = 0.03:0.001:0.06;
sequence_length = length(initial_sequence);

output_array = [];

for i = 1:sequence_length
    repeated_element = repmat(initial_sequence(i), 1, 361);
    output_array = [output_array, repeated_element];
end
