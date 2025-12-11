clc; clear; close all;

%% --- Load points ---
lines = string(fileread("input.txt")).splitlines();
lines(lines=="") = [];   % remove empty
pts = sscanf(strjoin(lines), "%f,%f,%f", [3 Inf])';
N = size(pts,1);

%% --- Build all pairwise distances (upper triangular only) ---
% Number of pairs = N*(N-1)/2. For N ≈ few thousand, this is fine.
pairs_i = [];
pairs_j = [];
dists   = [];

for i = 1:N-1
    jvec = (i+1):N;
    diff  = pts(jvec,:) - pts(repmat(i, size(jvec)), :);
    dij   = sqrt(sum(diff.^2,2));

    pairs_i = [pairs_i, repmat(i,1,length(jvec))];
    pairs_j = [pairs_j, jvec];
    dists   = [dists; dij];
end

%% --- Sort edges by distance ---
[~, order] = sort(dists);
pairs_i = pairs_i(order);
pairs_j = pairs_j(order);

%% --- Union-Find setup ---
parent = 1:N;
sz     = ones(1, N);

findSet = @(x) findRoot(x, parent);   % see function below

%% --- Perform the first 1000 connections ---
K = 1000;

for k = 1:K
    a = pairs_i(k);
    b = pairs_j(k);

    ra = findRoot(a, parent);
    rb = findRoot(b, parent);

    if ra ~= rb
        % union by size
        if sz(ra) < sz(rb)
            [ra, rb] = deal(rb, ra);
        end
        parent(rb) = ra;
        sz(ra) = sz(ra) + sz(rb);
    end
end

%% --- Compute final circuit sizes ---
roots = (1:N) == parent;      % only true for initial roots, incorrect after union
% So instead recompute all current roots:
finalRoots = arrayfun(@(x) findRoot(x, parent), 1:N);
uniqueRoots = unique(finalRoots);

circuitSizes = zeros(size(uniqueRoots));
for k = 1:length(uniqueRoots)
    circuitSizes(k) = sz(uniqueRoots(k));
end

circuitSizes = sort(circuitSizes, 'descend');

answ = prod(circuitSizes(1:3));
fprintf("Part 1 result = %d\n", answ);


%% ---- Helper: union-find find() with path compression ----
function r = findRoot(x, parent)
    while parent(x) ~= x
        parent(x) = parent(parent(x)); % path compression
        x = parent(x);
    end
    r = x;
end


%%
%% --- Part 2: continue until fully connected ---

parent = 1:N;
sz     = ones(1,N);

last_i = 0;
last_j = 0;

components = N;

for k = 1:length(pairs_i)
    a = pairs_i(k);
    b = pairs_j(k);

    ra = findRoot(a, parent);
    rb = findRoot(b, parent);

    if ra ~= rb
        % union by size
        if sz(ra) < sz(rb)
            [ra, rb] = deal(rb, ra);
        end
        parent(rb) = ra;
        sz(ra) = sz(ra) + sz(rb);

        components = components - 1;
        last_i = a;
        last_j = b;

        if components == 1
            break
        end
    end
end

x1 = pts(last_i,1);
x2 = pts(last_j,1);

result_part2 = x1 * x2;
fprintf("Part 2 result = %d\n", result_part2);
