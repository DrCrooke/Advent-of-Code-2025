clc; clear all; close all;

lines = char(string(fileread("input.txt")).splitlines());

state = logical(false(1, 141));
state(lines(1, :) == 'S') = 1;

hit = 0;

for i = 2:length(lines)
    splitters = lines(i, :) == '^';
    hits = splitters & state;
    leftSource = circshift(hits, -1);
    rightSource = circshift(hits, 1);
    newSources = leftSource | rightSource;

    state(hits) = 0;
    state = state | newSources;
    disp(state);
    hit = hit + sum(hits);
end

fprintf('Number of splits: %d \n', hit)

%%
clc; clear all; close all;

lines = char(string(fileread("input.txt")).splitlines());
nCols = size(lines,2);

state = zeros(1, nCols);     % timeline counts
state(lines(1,:)=='S') = 1;  % the single particle

for i = 2:size(lines,1)

    splitters = (lines(i,:)=='^');

    newState = zeros(1, nCols);

    % 1. Straight propagation where NOT a splitter
    newState(~splitters) = state(~splitters);

    % 2. Splits
    splitAmt = state(splitters);    % timeline counts hitting splitters

    idx = find(splitters);

    % left contributions
    leftIdx = idx - 1;
    valid = (leftIdx >= 1);
    newState(leftIdx(valid)) = newState(leftIdx(valid)) + splitAmt(valid);

    % right contributions
    rightIdx = idx + 1;
    valid = (rightIdx <= nCols);
    newState(rightIdx(valid)) = newState(rightIdx(valid)) + splitAmt(valid);

    state = newState;
end

answer = sum(state);
fprintf('Part 2 timelines: %d\n', answer);