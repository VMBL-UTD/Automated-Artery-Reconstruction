function [egroups] = connElemsInSet(elems)
num_elems = size(elems,1);

egroups = zeros(num_elems,1);

gind = 1;
while sum(egroups==0)>0
    % First, check which elements are unassigned
    empty_inds = find(egroups==0);
    
    % Search the unassigned elements only for connectivity
    conn_elems = getConnected(elems(empty_inds,:));
    
    % Give connected elements a group index
    egroups(empty_inds(conn_elems)) = gind;
    
    % Update group count
    gind = gind+1;
end
end

function [conn_elems] = getConnected(elems)
num_elems = size(elems,1);
conn_elems = zeros(num_elems,1);
conn_elems(1) = 1;

start_size = 0;
final_size = 1;
while start_size~=final_size
    % Get starting size of connected elements set
    start_size = sum(conn_elems);
    
    % Update connected elements array
    node_inds = unique(elems(conn_elems==1,:));
    conn_elems = conn_elems | any(ismember(elems,node_inds),2);
    
    % Get final size of connected elements set
    final_size = sum(conn_elems);
end
end