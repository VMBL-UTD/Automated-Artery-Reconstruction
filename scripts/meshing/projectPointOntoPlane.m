% Nice litte function adapted from: https://math.stackexchange.com/a/100766
function [point, sideofplane] = projectPointOntoPlane(P, uvw, xyz)
t = (uvw(1)*xyz(1) - uvw(1).*P(:,1) + uvw(2)*xyz(2) - uvw(2).*P(:,2) + uvw(3)*xyz(3) - uvw(3).*P(:,3))...
    ./ (uvw(1)^2 + uvw(2)^2 + uvw(3)^2);

point = P+t.*uvw;

sideofplane = sideOfPlane(P, uvw, xyz);
end

% output:
%   0: on plane
%   1: on positive side of plane
%   -1: on negative side of plane
function [side] = sideOfPlane(P, plane_uvw, plane_xyz)
dots = zeros(size(P,1),1);
P = P - plane_xyz;
for i=1:size(P,1)
    dots(i) = dot(P(i,:)./norm(P(i,:)),plane_uvw);
end
side = ones(size(P,1),1);
side(dots<0) = -1;
side(dots==0) = 0;
end