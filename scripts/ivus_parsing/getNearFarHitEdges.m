function [distances, near_coords, far_coords, near_edges, far_edges] = getNearFarHitEdges(origin, ray_hits)

num_rays = length(ray_hits);

% Get the distance between the nearest and furthest intersections for each ray
distances = zeros(num_rays,1);
near_coords = zeros(num_rays,2);
far_coords = zeros(num_rays,2);
near_edges = zeros(num_rays,1);
far_edges = zeros(num_rays,1);

for j=1:num_rays
    
    if ray_hits(j).num_hits > 0
        p = ray_hits(j).hit_coords;

        % Find intersection nearest to 'o'
        [~, minhits] = min(sqrt((p(:,1) - origin(1)).^2 + (p(:,2) - origin(2)).^2));

        % Find intersection furthest from 'o'
        [~, maxhits] = max(sqrt((p(:,1) - origin(1)).^2 + (p(:,2) - origin(2)).^2));

        % Get the distance between the two
        distances(j) = sqrt((p(maxhits,1) - p(minhits,1)).^2 + (p(maxhits,2) - p(minhits,2)).^2);

        % Get the nearest and furthest hit coordinates
        near_coords(j,:) = ray_hits(j).hit_coords(minhits,:);
        far_coords(j,:) = ray_hits(j).hit_coords(maxhits,:);
        
        % Get the nearest and furthest edges
        near_edges(j) = ray_hits(j).edge_hits(minhits);
        far_edges(j) = ray_hits(j).edge_hits(maxhits);
    end
end
      
end