%{
Function to loft the geometry
%}
function [F,V] = loftGeometry(layers,mesh_config)
% set general lofting parameters
cPar.closeLoopOpt=1;
cPar.patchType='tri_slash';
caps_div = 10;

% loft first end cap
cPar.numSteps=(caps_div);
[f,v] = polyLoftLinear(layers(1).outer_pts, layers(1).inner_pts, cPar);
ind1f = 1;          % calculate start index for face array
ind2f = length(f);  % calculate end index for face array
ind1v = 1;          % calculate start index for vertex array
ind2v = length(v);  % calculate end index for vertex array
f = fliplr(f);      % invert the normals of the first end cap
F(ind1f:ind2f,:) = f;
V(ind1v:ind2v,:) = v;

% Store lofting parameters
cPar.numSteps=2;
c_start=1;
ii=1;

for i=ii:mesh_config.num_layers-1
    c_end = i+1;
    [f,v]=polyLoftLinear(layers(c_start).outer_pts, layers(c_end).outer_pts, cPar);
    c_start = c_end;
    ind1f=ind2f+1;          % calculate start index for face array
    ind1v=ind2v+1;          % calculate start index for vertex array
    ind2f=ind2f+length(f);  % calculate end index for face array
    ind2v=ind2v+length(v);  % calculate end index for vertex array
    f=f+ind1v-1;
    F(ind1f:ind2f,:) = f;
    V(ind1v:ind2v,:) = v;
end

% loft each inner layer
c_start=1;
ii=1;
for i=ii:mesh_config.num_layers-1
    c_end = i+1;
    [f,v]=polyLoftLinear(layers(c_start).inner_pts, layers(c_end).inner_pts, cPar);
    c_start = c_end;
    ind1f=ind2f+1;          % calculate start index for face array
    ind1v=ind2v+1;          % calculate start index for vertex array
    ind2f=ind2f+length(f);  % calculate end index for face array
    ind2v=ind2v+length(v);  % calculate end index for face array
    f=f+ind1v-1;
    f = fliplr(f);          % invert normals of faces on lumen surface
    F(ind1f:ind2f,:) = f;
    V(ind1v:ind2v,:) = v;
end

% loft last end cap
cPar.numSteps=caps_div;
[f,v] = polyLoftLinear(layers(mesh_config.num_layers).outer_pts, layers(mesh_config.num_layers).inner_pts, cPar);
ind1f=ind2f+1;          % calculate start index for face array
ind1v=ind2v+1;          % calculate start index for vertex array
ind2f=ind2f+length(f);  % calculate end index for face array
ind2v=ind2v+length(v);  % calculate end index for face array
f=f+ind1v-1;
F(ind1f:ind2f,:) = f;
V(ind1v:ind2v,:) = v;

% remove redundant vertices
[F,V]=mergeVertices(F,V);
end