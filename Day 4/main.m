%% part 1
clc; clear all; close all;

lines = strtrim(string(fileread("input.txt")).splitlines());
grid = char(lines);
gridCopy = grid;

[y, x] = size(grid);


for xPos = 1:x
    for yPos = 1:y
        if strcmp(grid(yPos, xPos), "@")
            evalGrid = zeros(y, x);
            % special cases
            if xPos == 1 && yPos == 1 || xPos == 1 && yPos == y || xPos == x && yPos == 1 || xPos == x && yPos == y
                gridCopy(yPos, xPos) = 'x';
                continue;
            end
            if xPos == 1 % if along left edge
                evalGrid(yPos-1:yPos+1, xPos:xPos+1) = 1;
                sample = grid(logical(evalGrid));
                if (sum(strcmp(sample, "@")) - 1) < 4
                    gridCopy(yPos, xPos) = 'x';
                end
                continue;
            end
            if xPos == x % if along right edge
                evalGrid(yPos-1:yPos+1, xPos-1:xPos) = 1;
                sample = grid(logical(evalGrid));
                if (sum(strcmp(sample, "@")) - 1) < 4
                    gridCopy(yPos, xPos) = 'x';
                end
                continue;
            end
            if yPos == 1 % if along top row
                evalGrid(yPos:yPos+1, xPos-1:xPos+1) = 1;
                sample = grid(logical(evalGrid));
                if (sum(strcmp(sample, "@")) - 1) < 4
                    gridCopy(yPos, xPos) = 'x';
                end
                continue;
            end
            if yPos == y % if along bottom row
                evalGrid(yPos-1:yPos, xPos-1:xPos+1) = 1;
                sample = grid(logical(evalGrid));
                if (sum(strcmp(sample, "@")) - 1) < 4
                    gridCopy(yPos, xPos) = 'x';
                end
                continue;
            end

            % Check for adjacent cells and update grid accordingly
            evalGrid(yPos-1:yPos+1, xPos-1:xPos+1) = 1;
            sample = grid(logical(evalGrid));
            if (sum(strcmp(sample, "@")) - 1) < 4
                gridCopy(yPos, xPos) = 'x';
            end
        end
    end
end

% calc number of times x occurs in gridCopy
numX = sum(gridCopy(:) == 'x');
% Display the result
fprintf('The number of occurrences of "x" in the grid is: %d\n', numX);

%% part 2
clc; clear all; close all;

lines = strtrim(string(fileread("input.txt")).splitlines());
grid = char(lines);
gridCopy = grid;

[y, x] = size(grid);
numX = 1000;
numberRemoved = 0;
while numX > 0

    for xPos = 1:x
        for yPos = 1:y
            if strcmp(grid(yPos, xPos), "@")
                evalGrid = zeros(y, x);
                % special cases
                if xPos == 1 && yPos == 1 || xPos == 1 && yPos == y || xPos == x && yPos == 1 || xPos == x && yPos == y
                    gridCopy(yPos, xPos) = 'x';
                    continue;
                end
                if xPos == 1 % if along left edge
                    evalGrid(yPos-1:yPos+1, xPos:xPos+1) = 1;
                    sample = grid(logical(evalGrid));
                    if (sum(strcmp(sample, "@")) - 1) < 4
                        gridCopy(yPos, xPos) = 'x';
                    end
                    continue;
                end
                if xPos == x % if along right edge
                    evalGrid(yPos-1:yPos+1, xPos-1:xPos) = 1;
                    sample = grid(logical(evalGrid));
                    if (sum(strcmp(sample, "@")) - 1) < 4
                        gridCopy(yPos, xPos) = 'x';
                    end
                    continue;
                end
                if yPos == 1 % if along top row
                    evalGrid(yPos:yPos+1, xPos-1:xPos+1) = 1;
                    sample = grid(logical(evalGrid));
                    if (sum(strcmp(sample, "@")) - 1) < 4
                        gridCopy(yPos, xPos) = 'x';
                    end
                    continue;
                end
                if yPos == y % if along bottom row
                    evalGrid(yPos-1:yPos, xPos-1:xPos+1) = 1;
                    sample = grid(logical(evalGrid));
                    if (sum(strcmp(sample, "@")) - 1) < 4
                        gridCopy(yPos, xPos) = 'x';
                    end
                    continue;
                end

                % Check for adjacent cells and update grid accordingly
                evalGrid(yPos-1:yPos+1, xPos-1:xPos+1) = 1;
                sample = grid(logical(evalGrid));
                if (sum(strcmp(sample, "@")) - 1) < 4
                    gridCopy(yPos, xPos) = 'x';
                end
            end
        end
    end

    % calc number of times x occurs in gridCopy
    numX = sum(gridCopy(:) == 'x');
    % Display the result
    fprintf('The number of occurrences of "x" in the grid is: %d\n', numX);

    gridCopy(gridCopy == 'x') = '.';
    grid = gridCopy;

    numberRemoved = numberRemoved + numX;

end

% total number removed fprintf
fprintf('The number of removed rolls is %d\n', numberRemoved)