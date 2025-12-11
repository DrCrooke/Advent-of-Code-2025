clc; clear all; close all;

lines = string(fileread("input.txt")).splitlines();

positions = zeros(2, length(lines));

for i = 1:length(positions)
    coords = str2double(strsplit(lines(i), ","));
    positions(:, i) = coords.';
end

% find largest
largest = 0; 
for i = 1:length(positions(1, :))
    for j = (i+1):length(positions(1, :))
        cornerOne = positions(:, i);
        cornerTwo = positions(:, j);
        sideOne = abs(cornerOne(1) - cornerTwo(1)) + 1;
        sideTwo = abs(cornerOne(2) - cornerTwo(2)) + 1;

        area = sideOne*sideTwo;
        if area > largest
            largest = area;
        end
    end
end
fprintf('Largest area to find is %d\n', largest)
%%
clc; clear all; close all;

%% --- Read input ---
lines = string(fileread("input.txt")).splitlines();
N = length(lines);
positions = zeros(N,2);
for i = 1:N
    coords = str2double(strsplit(lines(i), ","));
    positions(i,:) = coords;
end

% Polygon vertices (red tiles, ordered, closed)
polyX = positions(:,1);
polyY = positions(:,2);

%% --- Loop over all pairs of red points ---
best_area = 0;
best_rect = [];

for i = 1:N
    x1 = positions(i,1); y1 = positions(i,2);
    for j = i+1:N
        x2 = positions(j,1); y2 = positions(j,2);

        % Must form a rectangle with opposite corners
        if x1 == x2 || y1 == y2
            continue
        end

        % Rectangle corners
        lx = min(x1,x2); rx = max(x1,x2);
        by = min(y1,y2); ty = max(y1,y2);
        rectX = [lx rx rx lx];
        rectY = [by by ty ty];

        % Check if all rectangle corners are inside polygon
        in = inpolygon(rectX, rectY, polyX, polyY);

        if all(in)
            area = (rx - lx + 1)*(ty - by + 1);
            if area > best_area
                best_area = area;
                best_rect = [lx by rx ty];
            end
        end
    end
end

%% --- Output ---
fprintf('Largest rectangle area (Part Two) = %d\n', best_area);
if ~isempty(best_rect)
    fprintf('Rectangle corners: (%d,%d) and (%d,%d)\n', best_rect(1), best_rect(2), best_rect(3), best_rect(4));
end
