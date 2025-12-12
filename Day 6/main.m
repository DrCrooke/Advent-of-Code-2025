clc; clear all; close all;

lines = strtrim(string(fileread("input.txt")).splitlines()).';
vals = [];
for i = 1:length(lines)
    if i <= 4
        vals = [vals; str2double(strsplit(lines(i), " "))];
    else
        operators = strsplit(lines(i), " ");
        sums = operators == "+";
        prods = operators == "*";

        a = sum(vals(:, sums));
        b = prod(vals(:, prods));
    end
end

fprintf('Part 1: %d\n', sum(a) + sum(b))


%%
clc; clear; close all;

% Read raw text as fixed-width character matrix
raw = fileread("input.txt");
lines = splitlines(raw);
lines = lines(~cellfun('isempty', lines));   % drop empty trailing line
H = length(lines);
W = max(cellfun(@strlength, lines));

% Pad all rows to equal width
M = char(zeros(H,W));
for i = 1:H
    row = char(lines{i});
    M(i,1:length(row)) = row;
end

% Identify where columns are all spaces (= separators)
col_is_space = all(M == ' ', 1);

% Find column ranges that form problems
problem_edges = diff([true, col_is_space, true]);
starts = find(problem_edges == -1);
ends   = find(problem_edges ==  1) - 1;

results = [];

for p = 1:length(starts)
    c1 = starts(p);
    c2 = ends(p);

    block = M(:, c1:c2);
    op_char = block(end, block(end,:) ~= ' ');
    op = op_char(1);                 % '+' or '*'

    % Extract numbers from right to left
    cols = c2:-1:c1;
    nums = [];

    for c = cols
        col = M(1:end-1, c);         % exclude operator row
        digits = col(col ~= ' ');    % remove spaces
        if isempty(digits)
            continue
        end
        num = str2double(char(digits.'));
        nums(end+1) = num;           %#ok<AGROW>
    end

    if op == '+'
        results(end+1) = sum(nums);
    else
        results(end+1) = prod(nums);
    end
end

fprintf("Part 2: %d\n", sum(results));