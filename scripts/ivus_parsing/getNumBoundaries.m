function [e, v, edge_sets, numboundaries, shp] = getNumBoundaries(pixelcart,a)
% Compute alpha shape
shp = alphaShape(pixelcart(:,1), pixelcart(:,2),a);
[e,v] = boundaryFacets(shp);

% create storage
edge_sets = struct();
rv = ones(size(v,1),1); % array to store remaining vertices
numboundaries = 0;

% Loop until we've used all vertices
while sum(rv) > 0
    % Start with a remaining vertex
    rv_ = find(rv==1); iv = rv_(1); [i,~]=find(e==iv);

    % Store the current vertex (cv) and the current edge(ce)
    cv = e(i(1),2);
    ce = e(i(1),:);
    
    % Set the value for the curent vertex in list of remaining vertices to 0
    rv(cv) = 0;
    
    % Create storage
    edge_list = zeros(size(e));
    edge_list(1,:) = e(iv,:);

    j=1;
    while iv~=cv
        j=j+1;
        
        % find the indices of e for the current vertex
        [r,c] = find(e==cv); re=e(r,c);

        % remove the current edge from re
        rem = ~ismember(re,ce,'rows'); ne = re(rem,:);
        
        % save the new edge and current vertex to be found on next loop
        ce = ne;
        cv = ce(ce~=cv);

        % updates edges array and increase index count
        edge_list(j,:) = ne;
        
        % Update the value for the curent vertex in list of remaining vertices to 0
        rv(cv) = 0;
    end
    
    % Find which edges in edge_list are nonzero and store those in struct
    edge_sets(numboundaries+1).edge_list = edge_list(all(edge_list,2),:);
    edge_sets(numboundaries+1).seq_edges = reshape(edge_sets(numboundaries+1).edge_list.',[],1);
    numboundaries = numboundaries + 1;
end
end