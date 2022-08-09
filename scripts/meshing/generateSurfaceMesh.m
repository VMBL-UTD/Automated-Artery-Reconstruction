function [F,V,tets,outlet_vecs] = generateSurfaceMesh(layers,mesh_config,isbranched)
% Create first pass mesh
[F,V] = loftGeometry(layers,mesh_config);

% Gather outlet vectors
outlet_vecs = struct();
outlet_vecs.uvw = [-layers(1).normal;layers(end).normal];
outlet_vecs.xyz = [layers(1).trans;layers(end).trans];

% Create daughter branches if necessary
if isbranched
    [surfs] = separateMeshSurfacesNew(F,V,outlet_vecs.xyz,outlet_vecs.uvw,0.1);
    [branch_groups] = getBranchGroups(F, V, layers, surfs, mesh_config.mesh.branch_ideal);
    [F,V] = loftBranchGroups(F, V, branch_groups, mesh_config.mesh.branch_taper);

    % Update outlet vectors
    for i=1:size(branch_groups,2)
        outlet_vecs.uvw(i+2,:) = branch_groups(i).mid_uvw;
        outlet_vecs.xyz(i+2,:) = branch_groups(i).mid_xyz;
    end
end

% Separate surfaces again
[surfs] = separateMeshSurfacesNew(F,V,outlet_vecs.xyz,outlet_vecs.uvw,0.1);

% Smooth Geometry and Flatten End Caps
fprintf('\nSmoothing Initial Geometry\n');
cPar.Method = 'HC';                                 % Using Humphrey smoothing algorithm
cPar.n=mesh_config.mesh.smooth_n;                   % Number of iterations
cPar.LambdaSmooth = mesh_config.mesh.smooth_lambda; % Lambda value for smoothing
[Vt] = patchSmooth(F,V, [], cPar);                  % Smooth geometry
Vt(surfs.caps{1,1}.V,:) = V(surfs.caps{1,1}.V,:);
Ft = F;
clear cPar

% Resample mesh
fprintf('\nResampling Mesh\n')
optstruct.pointSpacing = mesh_config.mesh.resample;
[F,V] = ggremesh(Ft,Vt,optstruct);

% Tetrahedralize mesh
fprintf("\nRunning TetGen\n");
minedgelen = mean(patchEdgeLengths(F,V));
[tets] = customTETGEN(F,V,minedgelen);
tets.surfs = separateMeshSurfacesNew(F,V,outlet_vecs.xyz,outlet_vecs.uvw,mesh_config.mesh.resample/2);
end
