% Function that creates a generic mesh_config struct
function [mesh_config] = meshConfigBase()
mesh_config = struct();

% Fill in generic values
mesh_config.img_folder          = "";
mesh_config.cline_path          = "";
mesh_config.img_folder_size     = 0;
mesh_config.num_layers          = 0;

mesh_config.ivus.min            = 0;
mesh_config.ivus.max            = 1;
mesh_config.ivus.pixel_scale    = 0.0148;
mesh_config.ivus.artery.c       = [135 135 135];
mesh_config.ivus.calcium.c      = [255 255 255];
mesh_config.ivus.necrotic.c     = [255 0   0  ];
mesh_config.ivus.fibrotic.c     = [0   170 0  ];
mesh_config.ivus.fibrofatty.c   = [186 255 0  ];
mesh_config.ivus.sleeve.c       = [0   0   255];
mesh_config.ivus.sleeve_thick   = 0.2;

mesh_config.mesh.curvature      = "straight";
mesh_config.mesh.resample       = 0.2;
mesh_config.mesh.branch_taper   = 1;
mesh_config.mesh.branch_ideal   = 1;
mesh_config.mesh.smooth_lambda  = 0.8;
mesh_config.mesh.smooth_n       = 8;
mesh_config.mesh.element_type   = "tet4";

mesh_config.mats.artery.id      = 1;
mesh_config.mats.calcium.id     = 2;
mesh_config.mats.necrotic.id    = 3;
mesh_config.mats.fibrotic.id    = 4;
mesh_config.mats.fibrofatty.id  = 5;
mesh_config.mats.sleeve.id      = 6;

end