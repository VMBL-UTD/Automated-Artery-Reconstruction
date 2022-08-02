function [hit] = lineIntersectTri(q1,q2,p1,p2,p3)
s1=[sv(q1,p1,p2,p3) sv(q2,p1,p2,p3)];
s2=[sv(q1,q2,p1,p2) sv(q1,q2,p2,p3) sv(q1,q2,p3,p1)];

t1 = sum(sign(s1))== 0;
t2 = ~any(diff(sign(s2(s2~=0)))) == 1;

hit=0;
if t1 && t2
    hit=1;
end
end

function [val] = sv(a,b,c,d)
val=(1/6)*dot(cross(b-a,c-a),d-a);
end
