clc; clear all; close all;

lines = strtrim(string(fileread("input.txt")).splitlines());

% Separate ranges and IDs
blankRow = find(lines == "", 1);
Ranges = lines(1:blankRow-1);
IDs    = lines(blankRow+1:end);

% Part 1: Count fresh IDs
fresh = 0;

starts = zeros(length(Ranges),1);
stops  = zeros(length(Ranges),1);

for k = 1:length(Ranges)
    parts = double(split(Ranges(k), "-"));
    starts(k) = parts(1);
    stops(k)  = parts(2);
end

for idx = 1:length(IDs)
    ID = str2double(IDs(idx));
    if any(ID >= starts & ID <= stops)
        fresh = fresh + 1;
    end
end

fprintf('Part 1: number of fresh ingredients = %d\n', fresh)

% Part 2: Merge overlapping intervals
[starts, order] = sort(starts);
stops = stops(order);

mergedStarts = starts(1);
mergedStops  = stops(1);

for k = 2:length(starts)
    if starts(k) <= mergedStops(end) + 1
        % Overlapping → extend
        mergedStops(end) = max(mergedStops(end), stops(k));
    else
        % New interval
        mergedStarts(end+1) = starts(k);
        mergedStops(end+1)  = stops(k);
    end
end

% Total fresh IDs
countFreshPart2 = sum(mergedStops - mergedStarts + 1);
fprintf('Part 2: total fresh ID count = %d\n', countFreshPart2)
