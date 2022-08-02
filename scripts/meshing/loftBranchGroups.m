function [Fout, Vout] = loftBranchGroups(Fin, Vin, bg, taper)
% Remove the branch faces from initial mesh
[Fout,Vout,bg,~] = removeBranchFaces(Fin,Vin,bg);

% Force branch edges to have the same number of vertices
[Fout,Vout,bg] = forceEqualNumVerts2(Fout,Vout,bg);

for i=1:length(bg)
    % Reorder lofting profile to be oriented with profile vertices
    [bg(i).inner.loft_profile,bg(i).inner.profile] = reorder_v2(Vout, bg(i).inner.loft_profile,bg(i).inner.profile,0);
    [bg(i).outer.loft_profile,bg(i).outer.profile] = reorder_v2(Vout, bg(i).outer.loft_profile,bg(i).outer.profile,0);

    % Define control vectors for bezier curves from branch vertices to branch lofting profile (inner)
    base_inner = bg(i).inner.loft_profile - Vout(bg(i).inner.profile,:); base_inner = base_inner./(sqrt(sum(base_inner.^2,2)));
    branch_inner = repmat(bg(i).mid_uvw,size(bg(i).inner.loft_profile,1),1);
    [Fi,Vi,~,~,~] = bezierLoft(Vout(bg(i).inner.profile,:),bg(i).inner.loft_profile,base_inner,branch_inner,0.4,0.5);

    % Define control vectors for bezier curves from branch vertices to branch lofting profile (outer)
    base_outer = bg(i).outer.loft_profile - Vout(bg(i).outer.profile,:); base_outer = base_outer./(sqrt(sum(base_outer.^2,2)));
    branch_outer = repmat(bg(i).mid_uvw,size(bg(i).outer.loft_profile,1),1);
    [Fo,Vo,~,~,~] = bezierLoft(Vout(bg(i).outer.profile,:),bg(i).outer.loft_profile,base_outer,branch_outer,0.4,0.5);
    
    % Create branch lofting path
    qp = [bg(i).mid_xyz; bg(i).mid_xyz + bg(i).mid_uvw.*0.05];

    % Loft the branch interior along path
    [Fii,Vii,v1] = loftBranch(bg(i).inner.loft_profile, qp, taper, bg(i).mid_uvw,0);

    % Loft the branch exterior along path
    [Foo,Voo,v2] = loftBranch(bg(i).outer.loft_profile, qp, taper, bg(i).mid_uvw,1);

    % Close end cap
    [Fc, Vc] = closeCap(v1,v2,qp(end,:), bg(i).mid_uvw);
    
    % Stitch meshes together
    [Fout,Vout] = stitch(Fout,Vout,{Fi,Fo,Fc,Fii,Foo},{Vi,Vo,Vc,Vii,Voo});

end
[Fout,Vout] = mergeVertices(Fout,Vout);
Fout = patchRemoveCollapsed(Fout);

end


function [Fout,Vout] = closeCap(v1,v2,qpend,layerend)
% Get rotational matrix from last layer normal to [0 0 1]
% (This allows us to rotate v1 and v2 to the 2D xy plane, basically removing the z dimension.)
R = getRot(layerend,[0 0 1]);

% Translate v1 and v2 to origin and then rotate using rotational matrix.
pv1 = (v1 - qpend)*R;
pv2 = (v2 - qpend)*R;

% Remove z dimension (pv1 and pv2 have all zeros in the z column after applyign rotation)
pv1t = pv1(:,[1 2]);
pv2t = pv2(:,[1 2]);

% Create a polyshape using MATLAB's polyshape method
poly = polyshape({pv1t(:,1) pv2t(:,1)},{pv1t(:,2) pv2t(:,2)},'Simplify',false,'KeepCollinearPoints',true);

% Triangulate the polyshape
T = triangulation(poly);

% Calculate new rotational matrix to rotate back to the layerend normal
R = getRot([0 0 1], layerend);

% Get face connectivity and apply rotationa and translation to vertices
Fout = T.ConnectivityList;
Vout = [T.Points zeros(size(T.Points,1),1)]*R + qpend;
end


% Function to stitch multiple meshes together
function [Fout,Vout] = stitch(Fin,Vin,Fcell,Vcell)
n=length(Fcell);

fsi = 1;
vsi = 1;
for i=1:n
    [Ft,Vt] = patchCleanUnused(Fcell{i},Vcell{i});
    
    fse = size(Ft,1) + fsi - 1;
    vse = size(Vt,1) + vsi - 1;
    
    F(fsi:fse,:) = Ft + vsi - 1;
    V(vsi:vse,:) = Vt;
    
    fsi = size(F,1) + 1;
    vsi = size(V,1) + 1;
end

[F,V] = patchCleanUnused(F,V);
F = F+size(Vin,1);
Fout = [Fin;F];
Vout = [Vin;V];
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
end


function [loft_profile_new,vprofile_new] = reorder_v2(V,loft_profile,vprofile,flipornot)
% From: https://www.mathworks.com/matlabcentral/answers/44993
wrapN = @(x, n) (1 + mod(x-1, n));
sv = length(vprofile);

mean_dists = zeros(sv,1);

for i=1:sv
    % circular shift lofting profile coordinates
    loft_profile_temp = loft_profile(wrapN(i:sv+i-1,sv),:);

    % get average distance between temp reordered indices and vprofile
    mean_dists(i) = mean(sqrt(sum((V(vprofile,:) - loft_profile_temp).^2,2)));
end
[~,mini] = min(mean_dists);
loft_profile_new = loft_profile(wrapN(mini:sv+mini-1,sv),:);

if flipornot
    vprofile_new = flip(vprofile,1);
else
    vprofile_new = vprofile;
end
end


% Function to force profiles to have the same number of vertices. Edges are split when necessary
function [Fout,Vout,bg] = forceEqualNumVerts2(Fin,Vin,bg)
% From: https://www.mathworks.com/matlabcentral/answers/44993
wrapN = @(x, n) (1 + mod(x-1, n));
Fout = Fin;
Vout = Vin;
for j=1:length(bg)
    count=0;
    inner_profile = bg(j).inner.profile;
    outer_profile = bg(j).outer.profile;
    numdif = abs(size(inner_profile,1) - size(outer_profile,1));

    if numdif ~= 0
        if length(inner_profile) > length(outer_profile)
            modvi = outer_profile(1:end-1);
        else
            modvi = inner_profile(1:end-1);
        end

        while count<=numdif
            % Calculate edge lengths
            e = [modvi modvi(wrapN(2:length(modvi)+1,length(modvi)))];
            elen = sqrt(sum((Vout(e(:,1),:)-Vout(e(:,2),:)).^2,2));

            % Get the edge associated with the largest edge length
            [~,maxi] = max(elen);

            % split edge
            [Fout,Vout,~] = triEdgeSplit(Fout,Vout,[e(maxi,1) e(maxi,2)]);

            % shift mod_profile
            modvi = [modvi(1:maxi);length(Vout);modvi(maxi+1:end)];

            % increase count
            count = count+1;
        end

        if length(inner_profile) > length(outer_profile)
            bg(j).outer.profile = modvi;
        else
            bg(j).inner.profile = modvi;
        end
        
        bg(j).outer.loft_profile = interparc(length(modvi),bg(j).outer.loft_profile(:,1),bg(j).outer.loft_profile(:,2),bg(j).outer.loft_profile(:,3),'linear');
        bg(j).inner.loft_profile = interparc(length(modvi),bg(j).inner.loft_profile(:,1),bg(j).inner.loft_profile(:,2),bg(j).inner.loft_profile(:,3),'linear');
    else
        % Make sure lofting profiles have the same number of points
        bg(j).outer.loft_profile = interparc(length(bg(j).outer.profile),bg(j).outer.loft_profile(:,1),bg(j).outer.loft_profile(:,2),bg(j).outer.loft_profile(:,3),'linear');
        bg(j).inner.loft_profile = interparc(length(bg(j).inner.profile),bg(j).inner.loft_profile(:,1),bg(j).inner.loft_profile(:,2),bg(j).inner.loft_profile(:,3),'linear');
    end
    Vout(bg(j).outer.profile,:) = smoothProfile(Vout(bg(j).outer.profile,:),2);
    Vout(bg(j).inner.profile,:) = smoothProfile(Vout(bg(j).inner.profile,:),2);
end
end


function [Fout, Vout, final_profile] = loftBranch(profile, loft_path, taper, nf, flipnorm)
    cPar.closeLoopOpt=1;
    cPar.patchType='tri_slash';
    cPar.numSteps = 1;

    numnew = (size(loft_path,1)-1)*(cPar.numSteps+1)*size(profile,1);
    Fout = zeros(numnew,3);
    Vout = zeros(numnew,3);
    count = 1;

    p = profile - loft_path(1,:);
    
    if taper
        tapersteps = linspace(1,1.5,size(loft_path,1));
    else
        tapersteps = ones(size(loft_path,1),1);
    end

    for j=2:size(loft_path,1)
        if j<=size(loft_path,1)-1
            % Calculate normals from current plane to next loft plane
            n1 = loft_path(j,:) - loft_path(j-1,:); n1 = n1/norm(n1);
            n2 = loft_path(j+1,:) - loft_path(j,:); n2 = n2/norm(n2);
    
            % Calculate rotation matrix using normals
            [rot,~] = getRot(n1, n2);
    
            % Update p and end loft profile
            profile_end = p*rot + loft_path(j,:);
            p = (profile_end - loft_path(j,:))*(1-(tapersteps(j) - tapersteps(j-1)));
        else
            [profile_end,~]= projectPointOntoPlane(profile,nf,loft_path(j,:));
        end
        
        % Do the damn thang
        [f_i,v_i] = polyLoftLinear(profile, profile_end, cPar);

        if flipnorm
            f_i = fliplr(f_i);
        end

        cend = (count+size(f_i,1)-1);
        Fout(count:cend,:) = f_i+sum(any(Vout,2));
        Vout(count:cend,:) = v_i;
        count = count+size(f_i,1);

        % Update profile 1
        profile = profile_end;
    end
    final_profile = profile;
end


function [Fout,Vout,bg,C] = removeBranchFaces(F,V,bg)
% Remove branch faces from F
for i=1:length(bg)
    remf = [bg(i).inner.f_ind;bg(i).outer.f_ind];
    F(remf,:) = zeros(length(remf),3); 
end
F(~all(F,2),:) = [];
[Fout,Vout] = patchCleanUnused(F,V);
[C] = patchConnectivity(Fout,Vout);

% Fix bg now that vertices have been removed
for i=1:length(bg)
    for j=1:length(bg(i).inner.profile)
        bg(i).inner.profile(j) = find(ismember(Vout,V(bg(i).inner.profile(j),:),'rows'));
    end
    for j=1:length(bg(i).outer.profile)
        bg(i).outer.profile(j) = find(ismember(Vout,V(bg(i).outer.profile(j),:),'rows'));
    end
end
end

