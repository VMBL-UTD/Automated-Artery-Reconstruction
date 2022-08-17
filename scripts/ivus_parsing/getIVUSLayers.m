%{
Function to get extract data from the VH-IVUS images
%}
function [layers, isbranched] = getIVUSLayers(mesh_config, cline)
% Default branched state is false
isbranched = false;

% Set origin
origin = [0,0];

% loop through IVUS images and get data
layers = struct();
layer_ind = 1;

% Setup waitbar
wb = waitbar(1/mesh_config.num_layers,'Reading Images...');

% Load all file information within the directory
fnames_in_dir = string({dir([mesh_config.img_folder]).name});

for img_i=mesh_config.ivus.min:mesh_config.ivus.max
    % update wait bar
    waitbar(layer_ind/mesh_config.num_layers,wb,['Reading Images...',num2str(layer_ind),'/',num2str(mesh_config.num_layers)]);
    
    % read image
    [fname,ext] = getMatchingFileName(fnames_in_dir,img_i);
    if strcmp(ext,'.gif')
        % .gif files do weird things when read with imread...
        % https://www.mathworks.com/matlabcentral/answers/36160-displaying-gif-image-matlab
        [img_temp,cmap] = imread(fullfile(mesh_config.img_folder,fname));
        img = zeros(size(img_temp,1),size(img_temp,2),3);
        for i=1:size(img_temp,1)
            for j=1:size(img_temp,2)
                img(i,j,:) = cmap(img_temp(i,j)+1,:)*255;
            end
        end
    else
        img = imread(fullfile(mesh_config.img_folder,fname));
        img = img(:,:,1:3);
    end
    
    % get pixels of interest from image
    pixels = filterAndScaleImg(img,mesh_config);
    
    % Get the number of boundaries and sets of edges
    [e, v, edge_sets, numbounds, ~] = getNumBoundaries(pixels.cart,0.08);

    % Trace radial rays from origin to see where they hit
    [ray_hits] = traceRadialRays(e,v,origin,2160);

    % Get nearest and furthest coordinates where rays hit
    [distances, near_coords, far_coords, ~, ~] = getNearFarHitEdges(origin, ray_hits);
    
    % Get inner and outer profiles
    [profiles] = getProfiles(distances, near_coords, far_coords);

    % split arterial pixels into medial and adventitial layers
%     pixels = splitArterial(pixels,profiles,opts);
    
    % create sleeve points and adjust outer_profile accordingly
    [pixels, profiles] = generateSleevePoints(pixels, profiles, mesh_config);
    
    % Check if boundaries represent bifurcation
    [is_bifurcated] = isBifurcated(numbounds, edge_sets, origin, v);
    
    % clean up points if bifurcation present
    if is_bifurcated
        % Get radial theta range where bifurcations are present
        [bifur_regions] = getBifurRanges(distances, ray_hits);
        
        % clean out the pixels between bifurcated regions and generate new profiles
        [pixels, remove_inner, remove_outer] = cleanBifurcatedRegions(pixels, profiles, bifur_regions);
        
        isbranched = true;
    end
    
    % calculate rotation and translation using centerline
    if img_i == mesh_config.ivus.max
        n2 = cline(end,:) - cline(end-1,:); n2 = n2./norm(n2);
    else
        n2 = cline(layer_ind+1,:) - cline(layer_ind,:); n2 = n2./norm(n2);
    end
    trans = cline(layer_ind,:);
    [rot] = getRot([1 0 0], n2);
    normal = n2;
    
    % apply rotation and translation and store corresponding tissue types
    layers(layer_ind).coords     = [zeros(length(pixels.cart),1), pixels.cart(:,1), pixels.cart(:,2)]*rot + trans;
    layers(layer_ind).outer_pts  = [zeros(length(profiles.outer.cart),1), profiles.outer.cart(:,1), profiles.outer.cart(:,2)]*rot + trans;
    layers(layer_ind).inner_pts  = [zeros(length(profiles.inner.cart),1), profiles.inner.cart(:,1), profiles.inner.cart(:,2)]*rot + trans;
    
    layers(layer_ind).types      = pixels.type;
    layers(layer_ind).rot        = rot;
    layers(layer_ind).trans      = trans;
    layers(layer_ind).normal     = normal;
    
    layers(layer_ind).is_bifurcated = is_bifurcated;
    layers(layer_ind).bifurcation.remove_inner = [];
    layers(layer_ind).bifurcation.remove_outer = [];
    if is_bifurcated
        layers(layer_ind).bifurcation.remove_inner = layers(layer_ind).inner_pts(remove_inner,:);
        layers(layer_ind).bifurcation.remove_outer = layers(layer_ind).outer_pts(remove_outer,:);   
    end
    
    % increment local counter
    layer_ind=layer_ind+1;
end

% Close the waitbar
close(wb);

end


function [fname,ext] = getMatchingFileName(fnames_in_dir, req_ind)
fname = "";
for i=1:length(fnames_in_dir)
    [~,name,ext] = fileparts(fnames_in_dir(i));
    if str2double(name) == req_ind
        fname = strcat(name,ext);
        break;
    end
end
end