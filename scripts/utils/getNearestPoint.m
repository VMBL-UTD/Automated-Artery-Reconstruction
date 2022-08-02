function ind = getNearestPoint(pt_q,pts_p)
[~,ind] = min(sqrt((pt_q(1)-pts_p(:,1)).^2 + (pt_q(2)-pts_p(:,2)).^2));
end