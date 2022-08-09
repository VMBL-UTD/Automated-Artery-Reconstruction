function [cline] = getCenterline(mesh_config)

if mesh_config.mesh.curvature == "straight"
    %% Create straight centerline

    % Check if centerline path is defined
    if isfile(mesh_config.cline_path)
        % If so, use centerline coordinates to create a straight centerline

        % Read in points and interpolate
        line_p = readmatrix(mesh_config.cline_path);
        line_p = line_p(:,[1 2 3]);
        line_p = interparc(mesh_config.img_folder_size, line_p(:,1),line_p(:,2),line_p(:,3),'spline');

        % Create straight centerline coordinates
        cline = zeros(mesh_config.num_layers,3);
        cind = 1;
        for i=mesh_config.ivus.min:mesh_config.ivus.max
            cline(cind,1) = norm(line_p(i,:)-line_p(i-1,:)) + cline(i-1,1);
            cind = cind+1;
        end

    else
        % If not, create a linearly interpolated centerline using typical VH-IVUS pullout
        cline = [(0:1:mesh_config.num_layers-1)'*0.5, zeros(mesh_config.num_layers,1), zeros(mesh_config.num_layers,1)];
    end

else
    %% Create curved centerline  

    if mesh_config.cline_path ~= ""
        % Read in all points and interpolate using the number of images in the folder
        line_p = readmatrix(mesh_config.cline_path);
        line_p = line_p(:,[1 2 3]);
        line_p = interparc(mesh_config.img_folder_size+1, line_p(:,1),line_p(:,2),line_p(:,3),'spline');

        % Set centerline points using min and max
        cline = line_p(mesh_config.ivus.min+1:mesh_config.ivus.max+1,:);
    else
        error("Curved centerline requested but centerline path is missing");
    end

end

end