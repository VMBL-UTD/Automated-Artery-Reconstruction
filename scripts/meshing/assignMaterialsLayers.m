%{
Function to assign materials using slice indexing:
    tets    -> Struct containing all elements and materials
    layers  -> Struct containing all layer properties
    show_wb -> Show the waitbar or not

Output:
    tets    -> the same as input 'tets' struct but with the newly assigned materials
%}
function [tets] = assignMaterialsLayers(tets, layers)
% Create new centerlines using the midpoint between each layer
cline_layers_xyz = vertcat(layers.trans);
cline_mid_uvw = (cline_layers_xyz(2:end,:) - cline_layers_xyz(1:end-1,:))/2;
cline_mid_xyz = cline_layers_xyz(1:end-1,:) + cline_mid_uvw;

% Now create new arrays for the centerline that append the first layer, midpoints, and last layer
cline_xyz = [layers(1).trans;cline_mid_xyz;layers(end).trans];
cline_uvw = [layers(1).normal;cline_mid_uvw;layers(end).normal];

% Create arrays for origin and normals of each layer's plane
num_layers = length(layers);
num_elems = size(tets.elements,1);

% Get element centroids
ec = tets.element_centers;

% Set up waitbar
wb = waitbar(1/num_elems,' Assigning Materials...');
wb_update_interval = round(num_elems/100);

% Loop through centerline and group elements between each plane
for i=1:num_layers
    %% PREPROCESSING
    % Project element centroids onto first plane
    [~,s1] = projectPointOntoPlane(ec,cline_uvw(i,:),cline_xyz(i,:));
    
    % Project element centroids onto second plane
    [~,s2] = projectPointOntoPlane(ec,-cline_uvw(i+1,:),cline_xyz(i+1,:));
    
    % Get elements on positive side of both planes that havent been assigned a material
    ppelems = find(s1+s2==2 & tets.elementMaterialID==-1);
    
    % Of the elements between the planes, find the index of the one nearest the centerline
    [~,near_ind] = min(sqrt(sum((ec(ppelems,:) - cline_xyz(i)).^2,2)));
    
    % Get set of elements connected to nearest element
    ppelems = getConnElemwSeed(tets.elements, ppelems, near_ind);
    num_ppelems = size(ppelems,1);
    
    %% MATERIAL ASSIGNMENT
    % For each element in the set, find the nearest IVUS pixel coordinate and assign its corresponding material to it
    for j=1:num_ppelems
        % MATLAB's waitbar takes forever to update so we only update it every 1%
        num_assigned = sum(tets.elementMaterialID~=-1);
        if ~mod(num_assigned,wb_update_interval)
            waitbar(num_assigned/num_elems,wb,['Assigning Materials...', num2str(round(num_assigned/num_elems*100)),'%']);
        end
        
        % Calculate from element centroid to each coordinate
        [~,near_ind] = min(sqrt(sum((ec(ppelems(j),:) - layers(i).coords).^2,2)));
        
        % Set the value
        tets.elementMaterialID(ppelems(j)) = layers(i).types(near_ind);
    end
end

% Any remaining elements that have not been assigned a material type are considered sleeve materials
tets.elementMaterialID(tets.elementMaterialID==0) = 3;

% Close waitbar
close(wb);

end


function [connelements] = getConnElemwSeed(elementsin, ppelems, seed_ind)
elementsin = elementsin(ppelems,:);

% Store number of elements
num_elements = size(elementsin,1);
num_assigned = 0;

% Create output array
connelements = false(num_elements,1);
connelements(seed_ind) = true;

% Get connected until no more and the size of those connected hasnt changed
while (sum(connelements) ~= num_elements) && (sum(connelements) ~= num_assigned)
    % Get the number of assigned elements at the beginning
    num_assigned = sum(connelements);
    
    connelements(any(ismember(elementsin,reshape(elementsin(connelements,:),[],1)),2)) = true;
end
connelements = ppelems(connelements);
end
