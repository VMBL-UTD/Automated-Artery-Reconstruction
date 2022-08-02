function [vlen] = vSeqLen(P)
if size(P,2) ~= 3
    disp("Expected P to be size [n,3]");
end

vlen = zeros(size(P,1)-1,1);
for i=1:size(P,1)-1
    vlen(i) = norm(P(i+1,:) - P(i,:));
end
end