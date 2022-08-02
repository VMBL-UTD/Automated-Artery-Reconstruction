function [mesh_config] = getIVUSRange(mesh_config)

if ~isnumeric(mesh_config.ivus.min) || ~isnumeric(mesh_config.ivus.max)
    error("Values for IVUS ID min and max MUST be numeric");
end

% Get the number of .tif files in VH-IVUS directory
if isfolder(mesh_config.img_folder)
    img_folder = dir([mesh_config.img_folder '/*.tif']);
    mesh_config.img_folder_size = length(img_folder)-1;

    % Check if user wants to use all VH-IVUS images (ivus_min == -1)
    if mesh_config.ivus.min == -1
        warning("IVUS min ID = -1, using full IVUS image range");

        % Update mesh_config
        mesh_config.ivus.min = 0;
        mesh_config.ivus.max = mesh_config.img_folder_size;
        mesh_config.num_layers = mesh_config.img_folder_size;

    else
        % Make sure IVUS min is greater than 0
        if mesh_config.ivus.min < 0
            warning("IVUS min ID %d, is out of range. Setting min to 0",mesh_config.ivus.min);
            mesh_config.ivus.min = 0;
        end

        % Make sure IVUS max is greater than zero and less than the number of images in the folder
        if mesh_config.ivus.max < 0 || mesh_config.ivus.max > mesh_config.img_folder_size
            warning("IVUS max ID %d, is out of range. Setting max to %d",mesh_config.ivus.max,mesh_config.img_folder_size);
            mesh_config.ivus.max = mesh_config.img_folder_size;
        end

        mesh_config.num_layers = mesh_config.ivus.max - mesh_config.ivus.min + 1;
    end

end
end

