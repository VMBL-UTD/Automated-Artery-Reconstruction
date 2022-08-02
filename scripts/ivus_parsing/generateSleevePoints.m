%{
Function that generates the sleeve points for the sleeve around the artery geometry
Input Arguments:
    pixels_in -> struct containing data for pixels of current IVUS slice
    profiles_in -> struct containing data for inner and outer profiles of current IVUS slice
    opts -> struct containing options and parameters for geometry specified at beginning
        of IVUS_to_FEA2
Output:
    pixels_out -> new pixel struct containing 'pixels_in' as well as the newly created sleeve points
    profiles_out -> new profile struct containing new outer profile after generating sleeve points
%}
function [pixels_out, profiles_out] = generateSleevePoints(pixels_in, profiles_in, mesh_config)
profiles_out = profiles_in;
pixels_out = pixels_in;

% check if user wants sleeve layers or not
if mesh_config.mesh.sleeve_thick > 0
    % create new outer profile
    profiles_out.outer.pol = [profiles_in.outer.pol(:,1), profiles_in.outer.pol(:,2)+mesh_config.mesh.sleeve_thick];
    profiles_out.outer.cart = zeros(length(profiles_out.outer.pol),2);
    [profiles_out.outer.cart(:,1), profiles_out.outer.cart(:,2)] = pol2cart(profiles_out.outer.pol(:,1),profiles_out.outer.pol(:,2));

    % create sleeve pixels
    [x,y] = meshgrid(linspace(-250, 250, 500)*mesh_config.ivus.pixel_scale, linspace(-250, 250, 500)*mesh_config.ivus.pixel_scale);
    mask = [x(:), y(:)]; clear x y;
    sleeve_pix = mask(inpolygon(mask(:,1), mask(:,2), profiles_out.outer.cart(:,1), profiles_out.outer.cart(:,2)) & ...
        ~inpolygon(mask(:,1), mask(:,2), profiles_in.outer.cart(:,1), profiles_in.outer.cart(:,2)), :);
    [th,r] = cart2pol(sleeve_pix(:,1), sleeve_pix(:,2));
    
    % save new pixel list
    pixels_out.cart = [pixels_in.cart;sleeve_pix];
    pixels_out.pol = [pixels_in.pol;[th,r]];
    pixels_out.type = [pixels_in.type;ones(size(sleeve_pix,1),1)*mesh_config.mats.sleeve.id];
end

end