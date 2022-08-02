function [pflat] = twodify(P,uvw,xyz)
[R] = getRot(uvw,[0 0 1]);
temp = (P-xyz)*R;
pflat = temp(:,[1 2]);
end


% % Modified and adapted from: https://stackoverflow.com/a/23822086
% function [pflat] = twodify(P, uy, uvw, xyz)
% nz = (xyz + uvw)./norm(xyz + uvw);
% x = (uy - dot(uy,nz)*nz); x=x./norm(x);
% y = cross(nz,x);
% pflat = zeros(size(P,1),2);
% for i=1:length(P)
%     pflat(i,:) = [dot(P(i,:),x) dot(P(i,:),y)];
% end
% end