function [bifur_groups] = getBifurRanges(distances, ray_hits)
num_rays = length(ray_hits);

% Get logical array where 1 = hit, 0 = no hit
empty_rays = distances ~= 0;

% Starting with the first index where a ray was hit, circle around
% to get ranges where bifurcation is not present
bifur_groups = struct();
num_bifur = 0;
j_incr = find(empty_rays~=0,1);
for j=1:num_rays

    flag1 = empty_rays(wrapN(j_incr,num_rays));
    flag2 = empty_rays(wrapN(j_incr + 1,num_rays));

    if flag1 && ~flag2
        jj = wrapN(j_incr-2,num_rays);
        bifur_groups(num_bifur+1).ray_hit_ind1 = jj;
        bifur_groups(num_bifur+1).th1 = ray_hits(jj).ray_pol(1);
    elseif ~flag1 && flag2
        jj = wrapN(j_incr+3,num_rays);
        bifur_groups(num_bifur+1).ray_hit_ind2 = jj;
        bifur_groups(num_bifur+1).th2 = ray_hits(jj).ray_pol(1);
        num_bifur = num_bifur + 1;
    end
    j_incr = wrapN(j_incr + 1,num_rays);

end
end


