function [ray_hits] = traceRadialRays(e, v, origin, num_rays)
% Get max distance from origin
d = max(sqrt((v(:,1) - origin(1)).^2 + (v(:,2) - origin(2)).^2));

% Cartesian coordinates for points around a circle centered at origin
% to act as ray endpoints
th = linspace(-pi,pi+2*pi/num_rays,num_rays);

rho = ones(1,num_rays)*d;
[xs,ys] = pol2cart(th,rho);
xs = xs + origin(1);
ys = ys + origin(2);

% See where each ray intersects with the profile edges
ray_hits = struct();
for j=1:num_rays
    [edge_hits, hit_coords] = checkRayIntersection([origin(1) origin(2)], [xs(j) ys(j)], e, v);
    ray_hits(j).num_hits = length(edge_hits);
    ray_hits(j).edge_hits = edge_hits;
    ray_hits(j).hit_coords = hit_coords;
    ray_hits(j).ray_cart = [xs(j) ys(j)];
    ray_hits(j).ray_pol = [th(j) rho(j)];
end
end