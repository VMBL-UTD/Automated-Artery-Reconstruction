function [mesh_config, feb_config] = parseInputFile(fname)

% Read in file
ini = ini2struct(fname);

% Get paths and directories
mesh_config.img_folder          = fullfile(ini.PATHS_AND_DIRECTORIES.VHIVUS_dir);
mesh_config.cline_path          = fullfile(ini.PATHS_AND_DIRECTORIES.centerline_path);
feb_config.feb_folder           = fullfile(ini.PATHS_AND_DIRECTORIES.feb_out_dir);

% Get VH-IVUS properties
mesh_config.ivus.min            = ini.PROPERTIES_VHIVUS.ivus_min;
mesh_config.ivus.max            = ini.PROPERTIES_VHIVUS.ivus_max;
mesh_config.ivus.pixel_scale    = ini.PROPERTIES_VHIVUS.pixel_mm_scale;

% Get meshing properties
mesh_config.mesh.curvature      = ini.PROPERTIES_MESH.curvature;
mesh_config.mesh.resample       = ini.PROPERTIES_MESH.resample_mm;
mesh_config.mesh.sleeve_thick   = ini.PROPERTIES_MESH.sleeve_thick_mm;
mesh_config.mesh.branch_taper   = ini.PROPERTIES_MESH.branch_taper;
mesh_config.mesh.branch_ideal   = ini.PROPERTIES_MESH.branch_ideal;

% Get FEBio properties
feb_config.feb.filename         = ini.PROPERTIES_FEBIO.feb_filename;
feb_config.feb.step_size        = ini.PROPERTIES_FEBIO.step_size;
feb_config.feb.num_steps        = ini.PROPERTIES_FEBIO.num_steps;
feb_config.feb.max_refs         = ini.PROPERTIES_FEBIO.max_refs;
feb_config.feb.max_ups          = ini.PROPERTIES_FEBIO.max_ups;
feb_config.feb.max_retries      = ini.PROPERTIES_FEBIO.max_retries;
feb_config.feb.lumen_p          = ini.PROPERTIES_FEBIO.lumen_pressure;

% Get material properties
feb_config.mats.artery_E        = ini.PROPERTIES_MATERIALS.artery_E;
feb_config.mats.artery_v        = ini.PROPERTIES_MATERIALS.artery_v;
feb_config.mats.calcium_E       = ini.PROPERTIES_MATERIALS.calcium_E;
feb_config.mats.calcium_v       = ini.PROPERTIES_MATERIALS.calcium_v;
feb_config.mats.necrotic_E      = ini.PROPERTIES_MATERIALS.necrotic_E;
feb_config.mats.necrotic_v      = ini.PROPERTIES_MATERIALS.necrotic_v;
feb_config.mats.fibrotic_E      = ini.PROPERTIES_MATERIALS.fibrotic_E;
feb_config.mats.fibrotic_v      = ini.PROPERTIES_MATERIALS.fibrotic_v;
feb_config.mats.fibrofatty_E    = ini.PROPERTIES_MATERIALS.fibrofatty_E;
feb_config.mats.fibrofatty_v    = ini.PROPERTIES_MATERIALS.fibrofatty_v;


%% Setting variables
% VH-IVUS images
img_folder = dir([mesh_config.img_folder '/*.tif']);
if ~isnumeric(ini.INITIAL_PARAMS.ivus_min) || ~isnumeric(ini.INITIAL_PARAMS.ivus_max)
    if strcmp(ini.INITIAL_PARAMS.ivus_min,'all') || strcmp(ini.INITIAL_PARAMS.ivus_max,'all')
        mesh_config.IVUS_slices = [0 length(img_folder)-1];
    end
else
    mesh_config.IVUS_slices = [ini.INITIAL_PARAMS.ivus_min, ini.INITIAL_PARAMS.ivus_max];
end

% get number of ivus images
mesh_config.fsize_length = mesh_config.IVUS_slices(2) - mesh_config.IVUS_slices(1) + 1;

% if c_or_s is defined as 'c' do curved, 's' do straight
if mesh_config.c_or_s == 's'
    mesh_config.cline = [(0:1:size(img_folder,1))'*0.5, zeros(size(img_folder,1)+1,1), zeros(size(img_folder,1)+1,1)];
%     name = 'Straight';
else
    % get centerline from txt file
    line_p = readmatrix(fullfile(mesh_config.cline_folder));
    line_p = line_p(:,[1 2 3]);
    line_p = interparc(size(img_folder,1)+2, line_p(:,1),line_p(:,2),line_p(:,3),'spline');
    mesh_config.cline = line_p;
%     name = 'Curved';
end

% create generic febio file
% febio_name = sprintf('%s_slices(%d-%d)_%dRR_%dLR_%.3fER_%dSL',name,geom_opts.IVUS_slices(1),...
%     geom_opts.IVUS_slices(2),geom_opts.rad_res,geom_opts.layer_res,...
%     geom_opts.elem_res,geom_opts.sleeve_layers);

% use generic name of febio input file to create results files and .log and .feb
feb_config.febio_stress_path  = strcat(ini.OUTPUT_DIR.feb_filename, '_stress.csv');
feb_config.febio_strain_path  = strcat(ini.OUTPUT_DIR.feb_filename, '_strain.csv');
feb_config.febio_log_path     = fullfile(strcat(feb_config.feb_folder, '.log'));
feb_config.febio_feb_path     = fullfile(strcat(feb_config.feb_folder, '.feb'));

% VH-IVUS pixel scale factor
mesh_config.scale = 0.95/64; % [mm]
end