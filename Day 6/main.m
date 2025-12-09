clc; clear all; close all;

lines = strtrim(string(fileread("test.txt")).splitlines()).';
vals = [];
for i = 1:length(lines)
    if i <= 3
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
