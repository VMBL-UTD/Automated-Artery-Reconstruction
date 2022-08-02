%{
Custom function to write a new FEBio .feb file
Input Arguments:
    F -> faces of geometry
    surfs -> struct containing all separated surfaces of the geometry
    tets -> struct containing all element data
    opts -> struct containing all options and parameters for geometry
    feb_opts -> struct containing all options and parameters for feb file creation
%}
function feb_file_handle = generateFEbioInputFile(F, surfs, tets, mesh_config, feb_config)
% Create new febio template object
[febio_spec]                                = febioStructTemplate; % Get a template with default settings 
febio_spec.ATTR.version                     = '3.0';   % febio_spec version
febio_spec.Module.ATTR.type                 = 'solid'; % Module section

% Set febio control params
febio_spec.Control.analysis                 = 'STATIC';
febio_spec.Control.time_steps               = feb_config.feb.num_steps;
febio_spec.Control.step_size                = feb_config.feb.step_size;
febio_spec.Control.time_stepper.dtmin       = (1/feb_config.feb.num_steps)/100;
febio_spec.Control.time_stepper.dtmax       = 1/feb_config.feb.num_steps;
febio_spec.Control.time_stepper.max_retries = feb_config.feb.max_retries;
febio_spec.Control.time_stepper.opt_iter    = feb_config.feb.opt_iter;
febio_spec.Control.solver.max_refs          = feb_config.feb.max_refs;
febio_spec.Control.solver.max_ups           = feb_config.feb.max_ups;

% Create a Node set with all nodes in tet4 geometry
febio_spec.Mesh.Nodes{1}.ATTR.name          = 'allNodes'; %The node set name
febio_spec.Mesh.Nodes{1}.node.ATTR.id       = (1:1:size(tets.nodes,1))'; %The node id's
febio_spec.Mesh.Nodes{1}.node.VAL           = tets.nodes; %The nodal coordinates

% Set material sections
fields = fieldnames(mesh_config.mats(1));
u = unique(tets.elementMaterialID);

for i=1:length(u)
    febio_spec.Material.material{i}.ATTR.name   = fields{u(i)};
    febio_spec.Material.material{i}.ATTR.type   = 'neo-Hookean';
    febio_spec.Material.material{i}.ATTR.id     = i;
    febio_spec.Material.material{i}.E           = feb_config.mats.(strcat(fields{u(i)},'_E'));
    febio_spec.Material.material{i}.v           = feb_config.mats.(strcat(fields{u(i)},'_v'));

    febio_spec.Mesh.Elements{i}.ATTR.type       = 'tet4'; %Element type of this set
    febio_spec.Mesh.Elements{i}.ATTR.mat        = i; %material index for this set
    febio_spec.Mesh.Elements{i}.ATTR.name       = fields{u(i)}; % Must match material.ATTER
    febio_spec.Mesh.Elements{i}.elem.ATTR.id    = find(tets.elementMaterialID == mesh_config.mats.(fields{u(i)}).id);
    febio_spec.Mesh.Elements{i}.elem.VAL        = tets.elements(tets.elementMaterialID == mesh_config.mats.(fields{u(i)}).id,:);

    febio_spec.MeshDomains.SolidDomain{i}.ATTR.name = fields{u(i)};
    febio_spec.MeshDomains.SolidDomain{i}.ATTR.mat = fields{u(i)};
end

% Define the node set that is fixed (end caps)
febio_spec.Mesh.NodeSet{1}.ATTR.name                    = 'Fixed_Nodes';
febio_spec.Mesh.NodeSet{1}.node.ATTR.id                 = [surfs.caps{1,1}.V];

% Define Fixed Boundary Conditions
febio_spec.Boundary.bc{1}.ATTR.type                     = 'fix';
febio_spec.Boundary.bc{1}.ATTR.node_set                 = febio_spec.Mesh.NodeSet{1}.ATTR.name;
febio_spec.Boundary.bc{1}.dofs                          = 'x,y,z';

% Define surfaces that are under the blood pressure load, i.e 'BP'
febio_spec.Mesh.Surface{1}.ATTR.name                    = 'BP';
febio_spec.Mesh.Surface{1}.tri3.VAL                     = F(surfs.lumen.F,:);
febio_spec.Mesh.Surface{1}.tri3.ATTR.id                 = (1:1:length(surfs.lumen.F))';

% Set the Pressure Conditions
febio_spec.Loads.surface_load{1}.ATTR.surface           = febio_spec.Mesh.Surface{1}.ATTR.name;
febio_spec.Loads.surface_load{1}.ATTR.type              = 'pressure';
febio_spec.Loads.surface_load{1}.pressure.VAL           = feb_config.feb.lumen_p;
febio_spec.Loads.surface_load{1}.pressure.ATTR.lc       = 1;
febio_spec.Loads.surface_load{1}.symmetric_stiffness    = 1;

febio_spec.LoadData.load_controller{1}.ATTR.id          = 1;
febio_spec.LoadData.load_controller{1}.ATTR.type        = 'loadcurve';
febio_spec.LoadData.load_controller{1}.interpolate      = 'LINEAR';
febio_spec.LoadData.load_controller{1}.points.point.VAL = [0 0; 1 1];

% Set the location of the log file
febio_spec.Output.logfile.ATTR.file                     = strcat(feb_config.feb.filename, '.log');%fullfile(feb_config.feb_folder, strcat(feb_config.feb.filename, '.log'));

febio_spec.Output.logfile.element_data{1}.ATTR.file     = strcat(feb_config.feb.filename, '_stress.csv');
febio_spec.Output.logfile.element_data{1}.ATTR.data     = 'sx;sy;sz;sxy;syz;sxz;s1;s2;s3';
febio_spec.Output.logfile.element_data{1}.ATTR.delim    = ',';

febio_spec.Output.logfile.element_data{2}.ATTR.file     = strcat(feb_config.feb.filename, '_strain.csv');
febio_spec.Output.logfile.element_data{2}.ATTR.data     = 'Ex;Ey;Ez;Exy;Eyz;Exz;E1;E2;E3';
febio_spec.Output.logfile.element_data{2}.ATTR.delim    = ',';

% Generate new .feb file 
feb_file_handle = febioStruct2xml(febio_spec,fullfile(feb_config.feb_folder, strcat(feb_config.feb.filename, '.feb')));
end