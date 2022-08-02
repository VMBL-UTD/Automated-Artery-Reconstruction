%{
Function to approximate the inner and outer profiles

- create list of empty profile vertices (# rows = num_rays, 2 columns)
  - create temp variables
      - temp1 = [0 0]
      - temp2 = [0 0]
  - create counter
      - count = 0
  - Loop through distances
      - Set flag1 to true if distances(j) > 0, false otherwise
      - Set flag2 to true if distances(j+1) > 0, false otherwise
      - If flag1 is true
          - add the nearest hit coordinate to inner vertices
      - If flag1 is true && flag2 is false
          - store vertex to temp1
      - If flag1 is false && flag2 is true
          - store vertex to temp2
          - interpolate x,y coordinates between temp1 and 2
          - Save new coordinates to inner verts
%}
function [profile_points, remove_v] = getProfile(distances, coords)
% From: https://www.mathworks.com/matlabcentral/answers/44993
wrapN = @(x, n) (1 + mod(x-1, n));

% Get logical array where 1 = hit, 0 = no hit
nonempty_rays = distances == 0;
% plot(linspace(pi,-pi,num_rays),empty_rays); xlim([-pi pi]);
num_rays = size(distances,1);

% Create storage
j_incr = find(nonempty_rays==0,1);
tempv1 = [0 0];
count = 0;
profile_points = zeros(num_rays,2);
remove_v = zeros(num_rays,1);

for j=1:num_rays

    % Set flags
    flag1 = nonempty_rays(wrapN(j_incr,num_rays));
    flag2 = nonempty_rays(wrapN(j_incr + 1,num_rays));

    % Store current nearest hit coordinate if the ray was hit
    if ~flag1
        profile_points(j_incr,:) = coords(j_incr,:);
    end
    
    % increment counter for number of rays not hit every time flag == 0
    if flag1
        count = count+1;
    end
    
    % transition from non-bifurcated region into bifurcated region
    if ~flag1 && flag2
        % Store the vertex where bifurcation occurs
        tempv1 = coords(wrapN(j_incr,num_rays),:);
        count = 0;
    end
    
    % transition from bifurcated region into non-bifurcated region
    if flag1 && ~flag2
        
        % Store the vertex where bifurcation occurs
        tempv2 = coords(wrapN(j_incr+1,num_rays),:);
        
        % interpolate between x and y coordinates
        p = [linspace(tempv1(1), tempv2(1), count)' linspace(tempv1(2), tempv2(2), count)'];
        
        % store these new coordinates in inner_verts
        for i=1:count
            % Update profile points between the start and end of the bifurcation
            profile_points(wrapN(j_incr-count+i,num_rays),:) = p(i,:);
            
            % Update list of vertices to be removed
            remove_v(wrapN(j_incr-count+i,num_rays)) = 1;
        end
        
    end

    % update index
    j_incr = wrapN(j_incr + 1,num_rays);
end
end