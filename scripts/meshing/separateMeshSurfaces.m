% F : geometry faces
% V : geometry vertices
function [surfs] = separateMeshSurfaces(varargin)

offset = 0.1;

switch nargin
    case 3
        F = varargin{1};
        V = varargin{2};
        layers = varargin{3};
    case 4
        F = varargin{1};
        V = varargin{2};
        layers = varargin{3};
        offset = varargin{4};
    otherwise
        sprintf("Error: Expected 3 or 4 args, got %d... Try again\n",narargin);
        return;
end

% get face connectivity
C = patchConnectivity(F,V);

% create storage for output struct
surfs = struct();
surfs.caps{1,1}.V = [];
surfs.caps{1,1}.F = [];
surfs.lumen.V = []; surfs.lumen.F   = [];
surfs.outer.V = []; surfs.outer.F   = [];

% create vectors that are offset from layers(1).normal and layers(end).normal
n1off = layers(1).trans + layers(1).normal*offset;
n2off = layers(end).trans - layers(end).normal*offset;

% project mesh vertices onto each plane to get the nodes before 'n1off' and after 'n2off'
[~,s1] = projectPointOntoPlane(V,layers(1).normal,n1off);
[~,s2] = projectPointOntoPlane(V,layers(end).normal,n2off);
capsv = unique([find(s1==-1) ; find(s2==1)]);
capsf = find(all(ismember(F,capsv),2));
capse = patchBoundary(F(capsf,:));

% Get the remaining faces that are not in the end caps
f_remain = find(~ismember(1:size(F,1),capsf));
[face_groups] = connFacesInSet(f_remain,C.face.face);

% Store lumen and outer surface faces and edges (Outer surface will ALWAYS have a larger surface area)
fg1_sa = sum(patchArea(F(f_remain(face_groups==1),:),V));
fg2_sa = sum(patchArea(F(f_remain(face_groups==2),:),V));
if fg1_sa == 0 || fg2_sa == 0
    % Faces
    outerf = [];
    lumenf = f_remain(face_groups==find([fg1_sa fg2_sa]));
    
    % Edge boundaries
    outere = [];
    lumene = patchBoundary(F(lumenf,:));
    
elseif fg1_sa > fg2_sa
    % Faces
    outerf = f_remain(face_groups==1);
    lumenf = f_remain(face_groups==2);
    
    % Edge boundaries
    outere = patchBoundary(F(outerf,:));
    lumene = patchBoundary(F(lumenf,:));
    
else
    % Faces
    outerf = f_remain(face_groups==2);
    lumenf = f_remain(face_groups==1);
    
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