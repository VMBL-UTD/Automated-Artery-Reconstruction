%{
Function that cleans and fills holes in the IVUS image
Input Arguments:
    pixels_in -> pixels input from the IVUS image
    profiles -> struct containing the outer and inner profiles for the current IVUS slice
Output:
    pixels_out -> new pixels struct
%}
function pixels_out = cleanPixels(pixels_in, profiles)
% create grid mask (basically 2D linspace)
[x,y] = meshgrid(sort(unique(pixels_in.cart(:,1))),sort(unique(pixels_in.cart(:,2))));
grid = [x(:),y(:)];

% get grid coordinates that are between outer and inner profiles
[in1,on1] = inpolygon(grid(:,1),grid(:,2),profiles.outer.cart(:,1),profiles.outer.cart(:,2));
[in2,~]   = inpolygon(grid(:,1),grid(:,2),profiles.inner.cart(:,1),profiles.inner.cart(:,2));
keep = (in1 | on1) & ~in2;
grid_in = grid(keep==1,:);

% get indices of coordinates in grid_mask that are not in pixels_in.cart coordinates
ind = ismember(grid_in,pixels_in.cart,'rows');
grid_missing = grid_in(ind==0,:);
grid_missing_type = zeros(length(grid_missing),1);

% loop through the missing grid points
for i=1:length(grid_missing)
    % get index of nearest pixel
    [~,ind] = min(sqrt((grid_missing(i,1)-pixels_in.cart(:,1)).^2 + (grid_missing(i,2)-pixels_in.cart(:,2)).^2));
    
    % assign the pixel type of the neaarest pixel to the point
    grid_missing_type(i) = pixels_in.type(ind);
end

% get pixels that are between outer and inner profiles
[in1,on1] = inpolygon(pixels_in.cart(:,1),pixels_in.cart(:,2),profiles.outer.cart(:,1),profiles.outer.cart(:,2));
[in2,~]   = inpolygon(pixels_in.cart(:,1),pixels_in.cart(:,2),profiles.inner.cart(:,1),profiles.inner.cart(:,2));
keep = (in1 | on1) & ~in2;

% add the missing pixels and their types to pixels_out
pixels_out.cart = [pixels_in.cart(keep,:);grid_missing];
pixels_out.type = [pixels_in.type(keep);grid_missing_type];

% compute polar coordinates again
pixels_out.pol = zeros(length(pixels_out.cart),2);
[pixels_out.pol(:,1),pixels_out.pol(:,2)] = cart2pol(pixels_out.cart(:,1),pixels_out.cart(:,2));
end
