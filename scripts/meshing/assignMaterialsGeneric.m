%{
Function to assign materials using slice indexing and alpha shape approaches together
Input Arguments:
    tets -> struct containing all elements and materials
    coords -> list of coordinates derived from pixels of VH-IVUS images that represent 
        (x,y,z) coordinates for each pixel type
    tissue -> list of tissue types for each coordinate
    opts -> struct containing options and parameters for geometry specified at beginning
        of IVUS_to_FEA2
Output:
    tets -> the same as input 'tets' struct but with the newly assigned materials
%}
function tets = assignMaterialsGeneric(tets,layers)
coords = vertcat(layers.coords);
tissue = vertcat(layers.types);

% Compute element centroids
ec = getCentroids(tets.nodes, tets.elements);

% Set up waitbar
num_elems = size(tets.elements,1);
wb = waitbar(1/num_elems,' Assigning Materials...');
wb_update_interval = round(num_elems/100);

% Assign materials
for i=1:num_elems
    if ~mod(i,wb_update_interval)
        waitbar(i/num_elems,wb,['Assigning Materials...', num2str(round(i/num_elems*100)),'%']);
    end
        
    % get the distance between the current element centroid and the tissue coordinates
    norm = ec(i,:) - coords;
    dists = sqrt(norm(:,1).^2 + norm(:,2).^2 + norm(:,3).^2);

    % get the minimum distance of the distances
    [~,min_ind] = min(dists);
    tets.elementMaterialID(i) = tissue(min_ind);

end
close(wb);
end