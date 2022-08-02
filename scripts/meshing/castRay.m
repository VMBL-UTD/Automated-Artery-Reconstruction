function [hits] = castRay(rp1,rp2,F,V)
% From: https://stackoverflow.com/a/42752998
svol = @(a,b,c,d) sign(dot(cross(b-a,c-a),d-a)/6.0);

hits = zeros(size(F,1),1);

for i=1:size(F,1)
    hits(i) = (svol(rp1, V(F(i,1),:), V(F(i,2),:), V(F(i,3),:)) ~= svol(rp2, V(F(i,1),:), V(F(i,2),:), V(F(i,3),:)))...
        && (svol(rp1, rp2, V(F(i,1),:), V(F(i,2),:)) == svol(rp1, rp2, V(F(i,2),:), V(F(i,3),:)))...
        && (svol(rp1, rp2, V(F(i,1),:), V(F(i,2),:)) == svol(rp1, rp2, V(F(i,3),:), V(F(i,1),:)));
end
hits = logical(hits);
end