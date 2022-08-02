function [feb_config] = febConfigBase()

% Create struct
feb_config = struct();

% Fill in generic values
feb_config.feb_folder           = "";
feb_config.feb.filename         = "";
feb_config.feb.step_size        = 0.1;
feb_config.feb.num_steps        = 10;
feb_config.feb.max_refs         = 15;
feb_config.feb.max_ups          = 15;
feb_config.feb.max_retries      = 10;
feb_config.feb.opt_iter         = 10;
feb_config.feb.lumen_p          = 0.016;
feb_config.mats.artery_E        = 0;
feb_config.mats.artery_v        = 0;
feb_config.mats.calcium_E       = 0;
feb_config.mats.calcium_v       = 0;
feb_config.mats.necrotic_E      = 0;
feb_config.mats.necrotic_v      = 0;
feb_config.mats.fibrotic_E      = 0;
feb_config.mats.fibrotic_v      = 0;
feb_config.mats.fibrofatty_E    = 0;
feb_config.mats.fibrofatty_v    = 0;
feb_config.mats.sleeve_E        = 0;
feb_config.mats.sleeve_v        = 0;
end