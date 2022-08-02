% get centroids
% N - Nodes
% E - Elements
function [C] = getCentroids(N, E)
    C = zeros(length(E), 3);
    for e = 1:length(E) % lendth of Elements
        C(e,1) = (N(E(e,1),1) + N(E(e,2),1) + N(E(e,3),1) + N(E(e,4),1))/4;
        C(e,2) = (N(E(e,1),2) + N(E(e,2),2) + N(E(e,3),2) + N(E(e,4),2))/4;
        C(e,3) = (N(E(e,1),3) + N(E(e,2),3) + N(E(e,3),3) + N(E(e,4),3))/4;
    end
end