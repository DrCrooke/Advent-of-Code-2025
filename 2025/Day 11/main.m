clc; clear all; close all; 

% borrowed this from reddit user as I have never worked with graphs before.

lines = readlines("./input.txt");

edges_from = {};
edges_to = {};

for i = 1:length(lines)
    line = lines{i};
    parts = split(line, ': ');
    source = parts{1};
    targets = split(parts{2}, ' ');
    
    for j = 1:length(targets)
        edges_from{end+1} = source;
        edges_to{end+1} = targets{j};
    end
end

G = digraph(edges_from, edges_to);

paths = allpaths(G, 'you', 'out');

num_paths = length(paths);
fprintf('Part 1: Number of paths %d\n', num_paths)

a = length(allpaths(G, 'svr', 'fft'));
b = length(allpaths(G, 'fft', 'dac'));
c = length(allpaths(G, 'dac', 'out'));
total_long_paths = prod([a,b,c]);

fprintf('Part 2: Number of paths %d\n', total_long_paths)