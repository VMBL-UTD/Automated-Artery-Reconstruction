function [mesh_config, feb_config] = parseSingleConfig(fname)

% Read in file
ini = ini2struct(fname);

% Get generic mesh_config object;
mesh_config = meshConfigBase();
feb_config = febConfigBase();

% Get paths and directories
mesh_config.img_folder          = fullfile(ini.PATHS_AND_DIRECTORIES.VHIVUS_dir);
mesh_config.cline_path          = fullfile(ini.PATHS_AND_DIRECTORIES.centerline_path);
feb_config.feb_folder           = fullfile(ini.PATHS_AND_DIRECTORIES.feb_out_dir);

% Get VH-IVUS properties
mesh_config.ivus.min            = ini.PROPERTIES_VHIVUS.ivus_min;
mesh_config.ivus.max            = ini.PROPERTIES_VHIVUS.ivus_max;
mesh_config.ivus.pixel_scale    = ini.PROPERTIES_VHIVUS.pixel_mm_scale;
mesh_config.ivus.artery.c       = ini.PROPERTIES_VHIVUS.artery_col;
mesh_config.ivus.calcium.c      = ini.PROPERTIES_VHIVUS.calcium_col;
mesh_config.ivus.necrotic.c     = ini.PROPERTIES_VHIVUS.necrotic_col;
mesh_config.ivus.fibrotic.c     = ini.PROPERTIES_VHIVUS.fibrotic_col;
mesh_config.ivus.fibrofatty.c   = ini.PROPERTIES_VHIVUS.fibrofatty_col;
mesh_config.ivus.sleeve.c       = ini.PROPERTIES_VHIVUS.sleeve_col;
mesh_config.ivus.sleeve_thick   = ini.PROPERTIES_VHIVUS.sleeve_thick_mm;

% Get meshing properties
mesh_config.mesh.curvature      = ini.PROPERTIES_MESH.curvature;
mesh_config.mesh.resample       = ini.PROPERTIES_MESH.resample_mm;
mesh_config.mesh.branch_taper   = ini.PROPERTIES_MESH.branch_taper;
mesh_config.mesh.branch_ideal   = ini.PROPERTIES_MESH.branch_ideal;
mesh_config.mesh.smooth_lambda  = ini.PROPERTIES_MESH.smooth_lambda;
mesh_config.mesh.smooth_n       = ini.PROPERTIES_MESH.smooth_n;

% Get FEBio properties
feb_config.feb.filename         = ini.PROPERTIES_FEBIO.feb_filename;
feb_config.feb.step_size        = ini.PROPERTIES_FEBIO.step_size;
feb_config.feb.num_steps        = ini.PROPERTIES_FEBIO.num_steps;
feb_config.feb.max_refs         = ini.PROPERTIES_FEBIO.max_refs;
feb_config.feb.max_ups          = ini.PROPERTIES_FEBIO.max_ups;
feb_config.feb.max_retries      = ini.PROPERTIES_FEBIO.max_retries;
feb_config.feb.opt_iter         = ini.PROPERTIES_FEBIO.opt_iter;
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
feb_config.mats.sleeve_E        = ini.PROPERTIES_MATERIALS.sleeve_v;
feb_config.mats.sleeve_v        = ini.PROPERTIES_MATERIALS.sleeve_v;

% Check if file paths and folder directories are correctly defined
if ~isfolder(mesh_config.img_folder)
    error("VH-IVUS folder incorrectly defined");
end
if mesh_config.cline_path~="" && ~isfile(mesh_config.cline_path)
    error("Centerline file path incorrectly defined");
end
if ~isfolder(feb_config.feb_folder)
    error("FEBio output folder incorrectly defined");
end

% Update VH-IVUS range
mesh_config = getIVUSRange(mesh_config);

end