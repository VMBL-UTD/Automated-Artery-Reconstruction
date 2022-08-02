% Function to check if the edge sets represent bifurcation or not

function [is_bifurcated] = isBifurcated(numbounds, edge_sets, origin, v)
warning('off', 'all');
if numbounds == 1
    % one boundary is guaranteed to be a bifurcation
    is_bifurcated = 1;
else
    % two boundaries can represent multiple bifurcations or
    % inner/outer profiles, lets check if the origin is inside
    % all edge boundaries
    in_shape = zeros(numbounds,1);
    for j=1:numbounds
        polyn = polyshape(v(edge_sets(j).seq_edges,1), v(edge_sets(j).seq_edges,2));
        in_shape(j) = isinterior(polyn,origin(1),origin(2));
    end
    if all(in_shape)
        is_bifurcated = 0;
    else
        is_bifurcated = 1;
    end
end
warning('on', 'all');
end