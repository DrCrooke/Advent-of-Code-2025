%% part 1
clc; clear all; close all;

lines = strtrim(string(fileread("input.txt")).splitlines());

sum = 0;


for i = 1:numel(lines)
    bank = char(lines(i));
    largest = 0;
    idx = 1;
    while idx < length(bank)
        first = bank(idx);
        for k = idx+1:length(bank)
            second = bank(k);

            if str2double([first second]) > largest
                largest = str2double([first second]);
            end
        end
        idx = idx + 1;
    end
    sum = sum + largest;
end

fprintf('Part 1: %d\n', sum)

%% part 2
clc; clear all; close all;

lines = strtrim(string(fileread("input.txt")).splitlines());
desiredLength = 12;
sumLargest = 0;

h = waitbar(0, "Progress...");
for i = 1:numel(lines)
    bank = char(lines(i));      
    totLength = numel(bank);
    largest = '';             
    startIdx = 1;

    for k = 1:desiredLength
        endIdx = totLength - (desiredLength - k);
        [maxDigit, maxPos] = max(bank(startIdx:endIdx));  
        largest(end+1) = maxDigit;                        
        startIdx = startIdx + maxPos;                    
    end

    largestNum = str2double(largest);  
    sumLargest = sumLargest + largestNum;

    waitbar(i / numel(lines), h, sprintf('Processing bank %d of %d', i, numel(lines)));
end
close(h);

fprintf('Part 2: %d\n', sumLargest);