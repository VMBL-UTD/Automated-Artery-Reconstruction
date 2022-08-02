function [inds] = inThetaRange(check_theta, th1, th2, thdir)

% if thdir=="ccw"
%     inds = check_theta > th1 | check_theta < th2;
% elseif thdir=="cw"
%     inds = check_theta < th1 & check_theta > th2;
% end

% Check clockwise from th1->th2
if thdir=="cw"
    if th1 < th2
        inds = check_theta < th1 | check_theta > th2;
    else
        inds = check_theta < th1 & check_theta > th2;
    end
elseif thdir=="ccw"
    if th1 < th2
        inds = check_theta < th1 & check_theta > th2;
    else
        inds = check_theta < th1 | check_theta > th2;
    end
else
    inds = false(size(check_theta));
end
end