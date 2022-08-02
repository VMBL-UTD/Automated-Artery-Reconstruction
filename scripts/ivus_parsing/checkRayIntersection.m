% Adapted and modified from:
% https://stackoverflow.com/a/1968345

% Function to check where a line intersects a list of lines

% Parameters:
%   - rayp1: coordinates of the first point of the ray
%   - rayp2: coordinates of the second point of the ray
%   - e: set of edges where each element cooresponds to an index in v
%   - v: set of vertices that make up the edges
% Return variables:
%   - out: 1 if intersection detected, 0 otherwise
%   - ix: x coordinate for point of intersection if intersection detected
%   - iy: y coordinate for point of intersection if intersection detected
function [hits, hit_coords] = checkRayIntersection(rayp1, rayp2, e, v)
    ep1 = v(e(:,1),:);
    ep2 = v(e(:,2),:);
    
    s1x = rayp2(1) - rayp1(1);
    s1y = rayp2(2) - rayp1(2);
    
    s2x = ep2(:,1) - ep1(:,1);
    s2y = ep2(:,2) - ep1(:,2);
    
    s = (-s1y .* (rayp1(1) - ep1(:,1)) + s1x .* (rayp1(2) - ep1(:,2))) ./ (-s2x .* s1y + s1x .* s2y);
    t = ( s2x .* (rayp1(2) - ep1(:,2)) - s2y .* (rayp1(1) - ep1(:,1))) ./ (-s2x .* s1y + s1x .* s2y);
    
    % Edge intersection detected
    intersects = zeros(1,length(s));
    ix = zeros(1,length(s));
    iy = zeros(1,length(s));
    for i=1:length(s)
        if (s(i) >= 0 && s(i) <= 1 && t(i) >= 0 && t(i) <= 1)
            intersects(i) = 1;
            ix(i) = rayp1(1) + t(i)*s1x;
            iy(i) = rayp1(2) + t(i)*s1y;
        end
    end
    
    % Only return the hits and coordinates where the ray hit
    hits = find(intersects==1);
    hit_coords = [ix(intersects==1)', iy(intersects==1)'];
end