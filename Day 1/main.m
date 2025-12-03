clc; clear all; close all;

input = importdata("input.txt");

paused_pos = 50; 
counter = 0;       
counter_2 = 0; 

for i = 1:length(input)
    temp = char(input{i});
    direction = temp(1);
    steps = str2double(temp(2:end));
    
    for s = 1:steps
        if direction == 'L'
            paused_pos = paused_pos - 1;
        else
            paused_pos = paused_pos + 1;
        end
        
        paused_pos = mod(paused_pos, 100);
        
        if paused_pos == 0
            counter_2 = counter_2 + 1;
        end
    end
    

    if paused_pos == 0
        counter = counter + 1;
    end
    
    fprintf('Rotation %s: paused at %d | Part1: %d | Part2: %d\n', ...
        temp, paused_pos, counter, counter_2);
end

fprintf('\nFinal passwords:\n');
fprintf('Part 1 (ends at 0): %d\n', counter);
fprintf('Part 2 (passes 0): %d\n', counter_2);
