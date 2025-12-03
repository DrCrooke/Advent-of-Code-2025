%% part 1

clc; clear all; close all; 

txt = fileread('input.txt');     % reads the full line as one string
ranges = strsplit(strtrim(txt), ',');   % cell array of 'A-B' strings

sumInvalidIds = 0;

h = waitbar(0, " % finished");

for i = 1:length(ranges)
    range = strsplit(ranges{i}, '-');
    start = str2double(range{1}); stop = str2double(range{2});

    if start >= stop
        disp("start is set after stop");
    end
    
    steps = stop - start + 1;
    currentId = start;
    for k = 1:steps
        if startsWith(num2str(currentId), "0")
            disp("starts with zero!")
        end

        currentId = num2str(currentId);
        if mod(strlength(currentId), 2) == 0
            currentId = char(currentId);
            firstHalf = currentId(1:length(currentId)/2);
            secondHalf = currentId(length(currentId)/2+1:end);

            if strcmp(firstHalf, secondHalf)
                sumInvalidIds = sumInvalidIds + str2double(currentId);
            end

            
        end
        currentId = str2double(currentId) + 1;
    end
    waitbar( i / length(ranges), h, num2str(i / length(ranges) * 100) + " % finished");
end

close(h);

disp("Sum of invalid IDs is " + num2str(sumInvalidIds))



%% part 2

clc; clear all; close all; 

txt = fileread('input.txt');     % reads the full line as one string
ranges = strsplit(strtrim(txt), ',');   % cell array of 'A-B' strings

sumInvalidIds = 0;

h = waitbar(0, " % finished");

for i = 1:length(ranges)
    range = strsplit(ranges{i}, '-');
    start = str2double(range{1}); stop = str2double(range{2});

    if start >= stop
        disp("start is set after stop");
    end


    for k = start:stop
        currentIdString = num2str(k);
        for p = 1:length(currentIdString) / 2
            if mod(length(currentIdString), p) == 0
                nRepeats = length(currentIdString) / p;
                firstSeq = currentIdString(1:p);
                repeatedSeq = repmat(firstSeq, 1, nRepeats);

                if strcmp(repeatedSeq, currentIdString)
                    sumInvalidIds = sumInvalidIds + k;
                    break;
                end
            end
        end
    end
    waitbar( i / length(ranges), h, num2str(i / length(ranges) * 100) + " % finished");
end

close(h);

disp("Sum of invalid IDs is " + num2str(sumInvalidIds))