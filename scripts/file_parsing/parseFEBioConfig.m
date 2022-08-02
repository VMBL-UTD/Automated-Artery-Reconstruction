function [feb_config] = parseFEBioConfig(fname)

% Read in file
ini = ini2struct(fname);

% Create struct
feb_config = febConfigBase();

% Get paths and directories
feb_config.feb_folder           = fullfile(ini.PATHS_AND_DIRECTORIES.feb_out_dir);

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

% Check if folder directory is correctly defined
if ~isfolder(feb_config.feb_folder)
    error("FEBio output folder incorrectly defined");
end
end
