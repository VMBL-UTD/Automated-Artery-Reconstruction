function [mesh_config] = parseMeshConfig(fname)

% Read in file
ini = ini2struct(fname);

% Create struct
mesh_config = meshConfigBase();

% Get paths and directories
mesh_config.img_folder          = fullfile(ini.PATHS_AND_DIRECTORIES.VHIVUS_dir);
mesh_config.cline_path          = fullfile(ini.PATHS_AND_DIRECTORIES.centerline_path);

% Get VH-IVUS properties
mesh_config.ivus.min            = ini.PROPERTIES_VHIVUS.ivus_min;
mesh_config.ivus.max            = ini.PROPERTIES_VHIVUS.ivus_max;
mesh_config.ivus.pixel_scale    = ini.PROPERTIES_VHIVUS.pixel_mm_scale;
mesh_config.ivus.sleeve_thick   = ini.PROPERTIES_VHIVUS.sleeve_thick_mm;
mesh_config.ivus.artery.c       = ini.PROPERTIES_VHIVUS.artery_col;
mesh_config.ivus.calcium.c      = ini.PROPERTIES_VHIVUS.calcium_col;
mesh_config.ivus.necrotic.c     = ini.PROPERTIES_VHIVUS.necrotic_col;
mesh_config.ivus.fibrotic.c     = ini.PROPERTIES_VHIVUS.fibrotic_col;
mesh_config.ivus.fibrofatty.c   = ini.PROPERTIES_VHIVUS.fibrofatty_col;
mesh_config.ivus.sleeve.c       = ini.PROPERTIES_VHIVUS.sleeve_col;

% Get meshing properties
mesh_config.mesh.curvature      = ini.PROPERTIES_MESH.curvature;
mesh_config.mesh.resample       = ini.PROPERTIES_MESH.resample_mm;
mesh_config.mesh.branch_taper   = ini.PROPERTIES_MESH.branch_taper;
mesh_config.mesh.branch_ideal   = ini.PROPERTIES_MESH.branch_ideal;

% Set material ids for meshing
mesh_config.mats.artery.id      = 1;
mesh_config.mats.calcium.id     = 2;
mesh_config.mats.necrotic.id    = 3;
mesh_config.mats.fibrotic.id    = 4;
mesh_config.mats.fibrofatty.id  = 5;
mesh_config.mats.sleeve.id      = 6;

% Check file paths and folder directories are correctly defined
if ~isfolder(mesh_config.img_folder)
    error("VH-IVUS folder incorrectly defined");
end
if mesh_config.cline_path~="" && ~isfile(mesh_config.cline_path)
    error("Centerline file path incorrectly defined");
end

% Update VH-IVUS range
mesh_config = getIVUSRange(mesh_config);

end