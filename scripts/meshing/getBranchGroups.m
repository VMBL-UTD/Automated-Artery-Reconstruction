% Function to find where bifurcation is present

function [bg, num_branches] = getBranchGroups(F, V, layers, surfs, ideal)
[C] = patchConnectivity(F,V);

% Get all branch vertices from input layers
inner_bv = zeros(size(V,1),1);
outer_bv = zeros(size(V,1),1);
for i=1:length(layers)
    if layers(i).is_bifurcated > 0
        inner_bv(ismember(V,layers(i).bifurcation.remove_inner,'rows')) = 1;
        outer_bv(ismember(V,layers(i).bifurcation.remove_outer,'rows')) = 1;
    end
end

% Get the faces connected to the branch vertices
inner_f = find(any(ismember(F,find(inner_bv)),2));
outer_f = find(any(ismember(F,find(outer_bv)),2));

inner_bg_group_inds = connFacesInSet(inner_f,C.face.face);
outer_bg_group_inds = connFacesInSet(outer_f,C.face.face);

if length(unique(inner_bg_group_inds)) ~= length(unique(outer_bg_group_inds))
    fprintf('Error: Mismatching branch groups');
    return
end

num_branches = length(unique(inner_bg_group_inds));

% Match the face groups
% Get mean coordinates for each group
inner_bg_xyz = zeros(num_branches,3);
outer_bg_xyz = zeros(num_branches,3);
for i=1:num_branches
    inner_bg_xyz(i,:) = mean(V(F(inner_f(inner_bg_group_inds==i),:),:),1);
    outer_bg_xyz(i,:) = mean(V(F(outer_f(outer_bg_group_inds==i),:),:),1);
end

% Re-index the outer face group to match the inner face group
new_outer_ind = zeros(num_branches,1);
for i=1:num_branches
    v = inner_bg_xyz(i,:);
    dists = sqrt(sum((outer_bg_xyz(i:end,:)-v).^2,2));
    [~,mini] = min(dists);
    new_outer_ind(i) = mini + i - 1;
end

% Smooth the mesh to make getting branch groups easier
cPar.Method = 'HC';                     % Using Humphrey smoothing algorithm
cPar.n=8;                               % Number of iterations
cPar.LambdaSmooth = 0.8;                % Lambda value for smoothing
[Vs] = patchSmooth(F,V, [], cPar);      % Smooth geometry
Vs(surfs.caps{1,1}.V,:) = V(surfs.caps{1,1}.V,:); V = Vs;
clear cPar;

% For each branch, calculate average normal vector for inner and outer faces
bg = struct();
for i=1:num_branches
    % Get inner and outer faces for current branch group
    inner_bfaces = inner_f(inner_bg_group_inds==i);
    outer_bfaces = outer_f(outer_bg_group_inds==(new_outer_ind(i)));
    
    % Get indices of vertices that make up the faces
    vi = unique(reshape(F(inner_bfaces,:).',[],1));
    vo = unique(reshape(F(outer_bfaces,:).',[],1));
    
    % Create temp copies of F1 and remove branch faces
    Fitemp = F; Fitemp(inner_bfaces,:) = [];
    Fotemp = F; Fotemp(outer_bfaces,:) = [];
    
    % Get edge vertex indices
    inner_profile = vi(ismember(vi,unique(reshape(Fitemp.',[],1))));
    outer_profile = vo(ismember(vo,unique(reshape(Fotemp.',[],1))));
    [~, inner_bfaces] = cleanProfile(F,C,inner_bfaces,inner_profile);
    [~, outer_bfaces] = cleanProfile(F,C,outer_bfaces,outer_profile);
    
    % Create edge sequence around the branch faces
    inner_profile = edgeListToCurve(patchBoundary(F(inner_bfaces,:)))';
    outer_profile = edgeListToCurve(patchBoundary(F(outer_bfaces,:)))';
    
    % Get center of mass for inner/outer profiles and mid plane
    inner_xyz = mean(V(F(inner_bfaces,:),:),1);
    outer_xyz = mean(V(F(outer_bfaces,:),:),1);
    mid_xyz = mean([inner_xyz;outer_xyz],1);
    
    % Get unit normal vector for inner/outer profiles and mid plane
    inner_uvw = -mean(patchNormal(F(inner_bfaces,:),V),1); inner_uvw = inner_uvw./norm(inner_uvw);
    outer_uvw = mean(patchNormal(F(outer_bfaces,:),V),1); outer_uvw = outer_uvw./norm(outer_uvw);
    mid_uvw = mean([outer_uvw;inner_uvw],1); mid_uvw = mid_uvw./norm(mid_uvw);
    
    % Apply rotation towards outlet using quaternions
    theta = deg2rad(0);
    c = cross(layers(end).normal,mid_uvw);
    p=[0 mid_uvw(1) mid_uvw(2) mid_uvw(3)];
    r=[cos(theta/2) c(1)*sin(theta/2) c(2)*sin(theta/2) c(3)*sin(theta/2)];
    r_=r.*[1 -1 -1 -1];
    mid_uvw=hproduct(hproduct(r,p),r_); mid_uvw=mid_uvw(2:end);

    % Idealize the branch profile to a circle rather than using the mesh faces
    if ideal
        % Calculate approximate area of the branch on the inner and outer surface
        inner_area = sum(patchArea(F(inner_bfaces,:),V));
        outer_area = sum(patchArea(F(outer_bfaces,:),V));
        
        % Calculate radius using area
        inner_r = sqrt(inner_area/pi);
        outer_r = sqrt(outer_area/pi);
        fprintf("Diameter: %0.3f\n",inner_r*2);
        
        % Calculate dtheta for inner and outer branch profiles
        i_dth = 2*pi/length(inner_profile);
        o_dth = 2*pi/length(outer_profile);
        
        % Get cartesian coordinates from polar representation of profile vertices
        [ix,iy] = pol2cart(linspace(pi,(-pi+i_dth),length(inner_profile)),inner_r);
        [ox,oy] = pol2cart(linspace(-pi,(pi-o_dth),length(outer_profile)),outer_r);
        
        % Calculate rotational matrix from 2D plane (xy) to the branch normal
        [R] = getRot([0 0 1], mid_uvw);
        
        % Apply rotation and translation to coordinates
        proj_inner = [ix',iy',zeros(length(inner_profile),1)]*R + mid_xyz;
        proj_outer = [ox',oy',zeros(length(outer_profile),1)]*R + mid_xyz;
        
    else
        % Smooth the edge profile
        proj_inner = smoothProfile(V(inner_profile,:),3);
        proj_outer = smoothProfile(V(outer_profile,:),3);

        % Project inner and outer vertices onto mid plane
        [proj_inner, ~] = projectPointOntoPlane(proj_inner, mid_uvw, mid_xyz);
        [proj_outer, ~] = projectPointOntoPlane(proj_outer, mid_uvw, mid_xyz);
    end
    
    % Widen outer opening for outer profile
    dist = norm(outer_xyz - inner_xyz);
    [proj_outer] = widenOpening(proj_outer,dist);

    % Get faces of inner surface to cut
    [Finner,Vinner] = patchCleanUnused(F(surfs.lumen.F,:),V);
    [Fcut_inner] = getBranchProfile2(Finner,Vinner,proj_inner,mid_uvw,mid_xyz);
    
    % Get faces of outer surface to cut
    [Fouter,Vouter] = patchCleanUnused(F(surfs.outer.F,:),V);
    [Fcut_outer] = getBranchProfile2(Fouter,Vouter,proj_outer,mid_uvw,mid_xyz);

    % Revert back to face indices from original F inputs
    [Fcut_inner] = getMatchingF(F,V,Finner,Vinner,Fcut_inner);
    [Fcut_outer] = getMatchingF(F,V,Fouter,Vouter,Fcut_outer);
    
    % Create edge sequence for first pass at getting cut faces
    inner_profile = edgeListToCurve(patchBoundary(F(Fcut_inner,:)))'; 
    outer_profile = edgeListToCurve(patchBoundary(F(Fcut_outer,:)))';

    % Get distance between inner and outer profiles and modify projected loft profiles
    inoutdist = norm(outer_xyz-inner_xyz)*8;
    proj_inner = proj_inner + inoutdist*mid_uvw;
    proj_outer = proj_outer + inoutdist*mid_uvw;

    % Prepare output struct
    bg(i).inner.profile = inner_profile;
    bg(i).outer.profile = outer_profile;

    pii = [proj_inner;proj_inner(1,:)];
    poo = [proj_outer;proj_outer(1,:)];
    bg(i).inner.loft_profile = interparc(size(pii,1),pii(:,1),pii(:,2),pii(:,3),'linear');
    bg(i).outer.loft_profile = interparc(size(poo,1),poo(:,1),poo(:,2),poo(:,3),'linear');

    bg(i).inner.f_ind = Fcut_inner;
    bg(i).outer.f_ind = Fcut_outer;
    
    bg(i).inner.xyz = inner_xyz;
    bg(i).inner.uvw = inner_uvw;    

    bg(i).outer.xyz = outer_xyz;
    bg(i).outer.uvw = outer_uvw;
   
    bg(i).mid_uvw = mid_uvw;
    bg(i).mid_xyz = mid_xyz + inoutdist*mid_uvw;
end
%     for i=1:size(branch_groups,1)
%     gpatch(F(branch_groups(i).inner.f_ind,:),V,'r');
%     gpatch(F(branch_groups(i).outer.f_ind,:),V,'b');
%     
%     plot3(branch_groups(i).inner.loft_profile(:,1), branch_groups(i).inner.loft_profile(:,2), branch_groups(i).inner.loft_profile(:,3),'b','LineWidth',2);
%     plot3(branch_groups(i).outer.loft_profile(:,1), branch_groups(i).outer.loft_profile(:,2), branch_groups(i).outer.loft_profile(:,3),'bo');
%     
%     plot3(branch_groups(i).proj_inner(:,1),branch_groups(i).proj_inner(:,2),branch_groups(i).proj_inner(:,3),'r','LineWidth',2);
%     plot3(V(branch_groups(i).inner_profile,1), V(branch_groups(i).inner_profile,2), V(branch_groups(i).inner_profile,3),'ro');
%     daspect([1 1 1]); xlabel('X'); ylabel('Y'); zlabel('Z');
%     end
end


% From: https://en.wikipedia.org/wiki/Quaternion#Hamilton_product
function [H] = hproduct(q1, q2)
H = [q1(1)*q2(1) - q1(2)*q2(2) - q1(3)*q2(3) - q1(4)*q2(4),...
     q1(1)*q2(2) + q1(2)*q2(1) + q1(3)*q2(4) - q1(4)*q2(3),...
     q1(1)*q2(3) - q1(2)*q2(4) + q1(3)*q2(1) + q1(4)*q2(2),...
     q1(1)*q2(4) + q1(2)*q2(3) - q1(3)*q2(2) + q1(4)*q2(1)];
end


function [Fnew] = getMatchingF(Foriginal,Voriginal,Fmod,Vmod,Fseq)
Fnew = zeros(length(Fseq),1);
for i=1:length(Fnew)
    vq = Vmod(Fmod(Fseq(i),:),:);
    Fnew(i) = find(all(ismember(Foriginal,find(ismember(Voriginal,vq,'rows'))),2));
end
end


% Function to widen opening
function [pout] = widenOpening(pin, dist)
    % Calciulate center of mass
    pc = mean(pin,1);
    
    % Get vectors from center of mass to pin
    pvec = pin - pc;
    pdist = (sqrt(sum(pvec.^2,2)));
    pnorm = pvec./pdist;
    
    % Widen pin using vectors to com
    pout = pin + pnorm.*dist;
    
%     hold on; plot3(pout(:,1), pout(:,2), pout(:,3), 'r');
%     hold on; plot3(pc(1), pc(2), pc(3), 'c')
end


% **NOTE** Use modified ray tracing instead: (basically cast a shadow on the mesh and 
%          see what faces it covers
%   - project all mesh nodes onto plane described by [xyz], [uvw]
%   - create dense meshgrid inside vproj profile
%   - for each point in the meshgrid, get the face it first intersects with
%   - get unique list of faces first intersected
%   - end
function [Fcut] = getBranchProfile2(F,V,P,uvw,xyz)
    [C] = patchConnectivity(F,V);
    
    % Project mesh vertices onto plane
    [vproj] = projectPointOntoPlane(V,uvw, xyz);
    
    % Make 2D
    qp = twodify(vproj,uvw,xyz);
    vp = twodify(P,uvw,xyz);
    
    % Get the faces that have any vertices residing inside the profile
    % This shortens the number of faces to check for ray intersection
    [in, on] = inpolygon(qp(:,1),qp(:,2),vp(:,1),vp(:,2));
    vin = 1:size(V,1); vin=(vin(in|on));
    fin = find(any(ismember(F,vin),2));
    [Vm] = patchCentre(F(fin,:),V);
    midxyz = mean(V(vin,:),1);
    
    % Get the side of the plane the faces are on
    [~,ps] = projectPointOntoPlane(Vm,uvw,midxyz);
    nf = fin(ps==1);
    
    % Clean up faces
    [Fcut] = find(cleanConnectedFaces(F,C.face.face,nf,2));
end

% Function to clean up faces using connectivity
%   - remove any lone faces
%   - add any faces that are adjacent to at least two faces in nf
function [ft] = cleanConnectedFaces(F,Cface,f,n)
ff = connFacesInSet(f,Cface);
if length(unique(ff)) > 1
    [gc,gr] = groupcounts(ff);
    
    % Get largest group of faces
    [~,maxi] = max(gc);
    
    f = f(ff==gr(maxi));
end

for nn=1:n
    ft = zeros(size(F,1),1);
    
    % Clean up faces included in f
    for i=1:size(f,1)
        % Get faces adjacent to current face
        cf = nonzeros(Cface(f(i),:));

        % See how many of the adjacent faces are in f
        cfi = ismember(cf,f);

        switch(sum(cfi))
            case 0
                ft(f(i)) = 0;
            case 1
                ft(f(i)) = 0;
            case 2
                ft(f(i)) = 1;
            case 3
                ft(f(i)) = 1;
        end
    end

    f = find(ft);
end

ft1 = zeros(size(F,1),1);
% Clean up other faces
for i=1:size(F,1)
    cf = nonzeros(Cface(i,:));
    cfi = ismember(cf,f);
    if sum(cfi) == 3; ft1(i) = 1; end
end

ft = logical(ft | ft1);
end


function [face_groups] = connFacesInSet(fin,Cface)
parsed_faces = zeros(length(fin),1);
face_groups = zeros(length(fin),1);
group_count=1;
while sum(parsed_faces)~=length(parsed_faces)
    f = fin(find(parsed_faces==0,1));
    conn_f=f;
    len_conn=0;
    while(len_conn<length(conn_f))
        len_conn=length(conn_f);
        flist = unique([reshape(Cface(conn_f,:).',[],1); f]);   % get unique list of faces connected to faces in conn
        conn_f = flist(ismember(flist,fin));               % get the members of f in fin
    end
    fi = ismember(fin,conn_f);
    parsed_faces(fi) = 1;
    face_groups(fi) = group_count;
    group_count = group_count+1;
end
end


% Function to smooth a given sequence of points that create a profile
function [Vout] = smoothProfile(Vin,numiter)
Vout = Vin;
Vtemp = Vin;
nump = size(Vin,1);

% From: https://www.mathworks.com/matlabcentral/answers/44993
wrapN = @(x, n) (1 + mod(x-1, n));
for i=1:numiter
    for j=1:nump
        jj = wrapN(j+[-1 0 1], nump);
        Vtemp(j,:) = mean(Vout(jj,:),1);
    end
    Vout = Vtemp;
end
% plot3(Vin(profile,1),Vin(profile,2),Vin(profile,3),'r-');
% hold on; plot3(Vtemp(profile,1),Vtemp(profile,2),Vtemp(profile,3),'b-');
end


function [profileout,fi] = cleanProfile(F,C,fi,profilein)
% Make copies
profileout = profilein;

% Check for faces in F with all 3 vertices in the brim
rf = find(sum(ismember(F,profilein),2)==3);
fi = [fi;rf];
for i=1:length(rf)
    % Check which vertices of the faces in rf only have 2 connections in the profile
    rv = F(rf(i),sum(ismember(C.vertex.vertex(F(rf(i),:),:), profilein),2)==2);
    
    profileout(ismember(profileout,rv)) = [];
end
end