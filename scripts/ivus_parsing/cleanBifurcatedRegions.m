function [pixels_out, remove_inner, remove_outer] = cleanBifurcatedRegions(pixels_in, profiles, bifur_regions)
pixels_out = struct();

% Get the number of bifurcations
num_bifur = length(bifur_regions);

% Create mask
pixel_mask = true(size(pixels_in.cart,1),1);
inner_mask = true(size(profiles.inner.pol,1),1);
outer_mask = true(size(profiles.inner.pol,1),1);

% For each bifurcated region, update mask for points inside the range
for i=1:num_bifur
    pixel_mask = pixel_mask & inThetaRange(pixels_in.pol(:,1), bifur_regions(i).th1, bifur_regions(i).th2, 'cw');
    inner_mask = inner_mask & ~inThetaRange(profiles.inner.pol(:,1), bifur_regions(i).th1, bifur_regions(i).th2, 'cw');
    outer_mask = outer_mask & ~inThetaRange(profiles.outer.pol(:,1), bifur_regions(i).th1, bifur_regions(i).th2, 'cw');
end

% Update output pixels
pixels_out.cart = pixels_in.cart(pixel_mask,:);
pixels_out.type = pixels_in.type(pixel_mask);
pixels_out.pol = pixels_in.pol(pixel_mask,:);

% Update output for vertices we want to remove later
remove_inner = find(inner_mask);
remove_outer = find(outer_mask);
end