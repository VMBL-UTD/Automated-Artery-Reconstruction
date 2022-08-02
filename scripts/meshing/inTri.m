function [h] = inTri(F,V,r)
h=zeros(size(r,1),1);
for i=1:size(r,1)
    h(i) = inTriangle(r,
end
end