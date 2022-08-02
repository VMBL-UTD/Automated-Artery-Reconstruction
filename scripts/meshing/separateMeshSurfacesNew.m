% F : geometry faces
% V : geometry vertices
function [surfs] = separateMeshSurfacesNew(F,V,xyz_vecs,uvw_vecs,offset)

% get face connectivity
C = patchConnectivity(F,V);

% create storage for output struct
surfs = struct();
surfs.caps{1,1}.V = [];
surfs.caps{1,1}.F = [];
surfs.lumen.V = []; surfs.lumen.F   = [];
surfs.outer.V = []; surfs.outer.F   = [];

% First lets see how many end caps there are
num_caps = size(xyz_vecs,1);
xyz_vecs = xyz_vecs - uvw_vecs.*offset;

% if ~isempty(branch_groups)
%     num_caps = 2 + size(branch_groups,2);
% end
% 
% % Create storage for normal vectors and center points for each branch group and 
% uvw_vecs = zeros(num_caps,3); % Normal vectors
% xyz_vecs = zeros(num_caps,3); % Center coordinates
% 
% % Store normal vectors
% uvw_vecs(1,:) = -layers(1).normal;
% uvw_vecs(2,:) = layers(end).normal;
% if num_caps > 2
%     for i=3:num_caps
%         uvw_vecs(i,:) = branch_groups(i-2).mid_uvw;
%     end
% end
% 
% % Store center coordinates
% xyz_vecs(1,:) = layers(1).trans + layers(1).normal*offset;
% xyz_vecs(2,:) = layers(end).trans - layers(end).normal*offset;
% if num_caps > 2
%     for i=3:num_caps
%         xyz_vecs(i,:) = branch_groups(i-2).mid_xyz - branch_groups(i-2).mid_uvw*offset;
%     end
% end

% Lets get those end caps!

% First lets create blank masks for the nodes and faces
ci_nodes = zeros(1,num_caps);
ec_faces = zeros(size(F,1),1);
ec_nodes = zeros(size(V,1),1);
for i=1:num_caps
    % NEAREST NODE
    % Get the mesh node indices of those on the positive side of the plane
    [~,s] = projectPointOntoPlane(V,uvw_vecs(i,:),xyz_vecs(i,:));
    ppos_v_inds = find(s==1);
    
    % Of those on the positive side, get the index of the mesh nodes nearest to the end cap center
    [~,min_ind] = min(sqrt(sum((V(ppos_v_inds,:) - xyz_vecs(i,:)).^2,2)));
    ci_nodes(i) = ppos_v_inds(min_ind);
    
    % END CAP FACES
    % Now lets get all faces that have all 3 nodes on the positive side of the plane
    ppos_f_inds = find(all(ismember(F,ppos_v_inds),2));
    
    % Group the faces based on connectivity
    [fgroups] = connFacesInSet(ppos_f_inds,C.face.face);
    
    % Check if there are multiple groups
    if length(unique(fgroups)) > 1
        % If so, see which face on the positive side of the plane are connected to the nearest node
        ppos_f = ppos_f_inds(find(any(F(ppos_f_inds,:)==ci_nodes(i),2),1));
        
        % Use this index to get the corresponding group of faces
        nearest_fgroup = fgroups(ppos_f_inds==ppos_f);
        
        % Get those faces
        ppos_f_inds = ppos_f_inds(fgroups==nearest_fgroup);
    end
    
    % Update the faces mask
    ec_faces(ppos_f_inds) = 1;
    
    % Update the nodes mask
    ec_nodes(unique(F(ppos_f_inds,:))) = 1;
end

% Store the end caps nodes, faces, and edges
capsv = find(ec_nodes==1);
capsf = find(ec_faces==1);
capse = patchBoundary(F(capsf,:));

% Get the remaining faces that are not in the end caps
f_remain = find(ec_faces==0);
[fgroups] = connFacesInSet(f_remain,C.face.face);

% Store lumen and outer surface faces and edges (Outer surface will ALWAYS have a larger surface area)
fg1_sa = sum(patchArea(F(f_remain(fgroups==1),:),V));
fg2_sa = sum(patchArea(F(f_remain(fgroups==2),:),V));
if fg1_sa == 0 || fg2_sa == 0
    % Faces
    outerf = [];
    lumenf = f_remain(fgroups==find([fg1_sa fg2_sa]));
    
    % Edge boundaries
    outere = [];
    lumene = patchBoundary(F(lumenf,:));
    
elseif fg1_sa > fg2_sa
    % Faces
    outerf = f_remain(fgroups==1);
    lumenf = f_remain(fgroups==2);
    
    % Edge boundaries
    outere = patchBoundary(F(outerf,:));
    lumene = patchBoundary(F(lumenf,:));
    
else
    % Faces
    outerf = f_remain(fgroups==2);
    lumenf = f_remain(fgroups==1);
    
    % Edge boundaries
    outere = patchBoundary(F(outerf,:));
    lumene = patchBoundary(F(lumenf,:));
    
end

% Store faces
surfs.outer.F = outerf;
surfs.lumen.F = lumenf;
surfs.caps{1,1}.F = capsf;
surfs.caps{1,1}.Fg = connFacesInSet(capsf,C.face.face);

% Store vertices
surfs.outer.V = unique(reshape(F(outerf,:),1,[]));
surfs.lumen.V = unique(reshape(F(lumenf,:),1,[]));
surfs.caps{1,1}.V = capsv;

% Store edge nodes
surfs.outer.E = [];
if ~isempty(outere); surfs.outer.E = outere(:,1); end
surfs.lumen.E = lumene(:,1);
surfs.caps{1,1}.E = capse(:,1);

% Store edge node groups
optionStruct.outputType='label';
surfs.outer.Eg = tesgroup(outere,optionStruct);
surfs.lumen.Eg = tesgroup(lumene,optionStruct);
surfs.caps{1,1}.Eg = tesgroup(capse,optionStruct);

end