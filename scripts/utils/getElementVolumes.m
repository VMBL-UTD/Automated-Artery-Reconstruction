%{
Calculate volumes of elements
Parameters
----------
N : Nodes
E : Elements
Returns
-------
Volumes of each element.
%}
function [vols] = getElementVolumes(E, N)
% create storage for element volumes
vols = zeros(length(E),1);

% compute each element's volume
for i=1:length(E)
    vols(i)=(1/6)*abs(det([[1 N(E(i,1),:)]; [1 N(E(i,2),:)]; [1 N(E(i,3),:)]; [1 N(E(i,4),:)]]));
end
end