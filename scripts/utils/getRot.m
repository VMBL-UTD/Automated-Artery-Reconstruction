% Function to get rotational matrix
function [rot, normal] = getRot(n1, n2)
    v = cross(n2,n1);
    vx = [0 -v(3) v(2); v(3) 0 -v(1); -v(2) v(1) 0];
    c = dot(n1,n2);
    rot = eye(3) + vx + vx^2*(1/(1+c));
    
    vv = (n2-n1);
    normal = vv ./ norm(vv);
end