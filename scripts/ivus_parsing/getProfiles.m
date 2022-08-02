%{
Function to get the outer and inner profiles of the current IVUS image
Input Arguments:
    pixels -> pixels of current IVUS slice
    opts -> options and parameters for geometry creation
    smooth -> smooth the curve or not (DEBUGGING)
%}
function [profiles] = getProfiles(distances, near_coords, far_coords)
% Get inner and outer profiles
[inner_profile, ~] = getProfile(distances, near_coords);
[outer_profile, ~] = getProfile(distances, far_coords);

% Linear interpolation around inner and outer profile to adjust number of vertices
inner_cart = interparc(61, inner_profile(:,1), inner_profile(:,2), 'linear');
outer_cart = interparc(61, outer_profile(:,1), outer_profile(:,2), 'linear');

% Save new profile
profiles.inner.cart = inner_cart(1:end-1,:);
profiles.outer.cart = outer_cart(1:end-1,:);
[profiles.inner.pol(:,1),profiles.inner.pol(:,2)] = cart2pol(profiles.inner.cart(:,1),profiles.inner.cart(:,2));
[profiles.outer.pol(:,1),profiles.outer.pol(:,2)] = cart2pol(profiles.outer.cart(:,1),profiles.outer.cart(:,2));

end