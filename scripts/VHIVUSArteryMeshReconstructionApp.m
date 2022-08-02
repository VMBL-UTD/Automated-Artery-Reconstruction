classdef VHIVUSArteryMeshReconstructionApp < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        AutomatedVHIVUS3DArteryReconstructionLabel  matlab.ui.control.Label
        Image                           matlab.ui.control.Image
        Image3                          matlab.ui.control.Image
        MeshingFEBioPropertyManagerPanel  matlab.ui.container.Panel
        TabGroup                        matlab.ui.container.TabGroup
        VHIVUSMeshingTab                matlab.ui.container.Tab
        GridLayout41                    matlab.ui.container.GridLayout
        CenterlinePanel                 matlab.ui.container.Panel
        GridLayout33                    matlab.ui.container.GridLayout
        GridLayout34                    matlab.ui.container.GridLayout
        CurvatureLabel                  matlab.ui.control.Label
        ButtonGroup_3                   matlab.ui.container.ButtonGroup
        CurvedButton                    matlab.ui.control.ToggleButton
        StraightButton                  matlab.ui.control.ToggleButton
        GridLayout35                    matlab.ui.container.GridLayout
        CenterlineFilePathEditFieldLabel  matlab.ui.control.Label
        CenterlineFilePathEditField     matlab.ui.control.EditField
        GridLayout45                    matlab.ui.container.GridLayout
        LoadCenterlineButton            matlab.ui.control.Button
        ClearCenterlineDataButton       matlab.ui.control.Button
        VHIVUSPanel                     matlab.ui.container.Panel
        GridLayout3                     matlab.ui.container.GridLayout
        GridLayout28                    matlab.ui.container.GridLayout
        VHIVUSDirectoryEditFieldLabel   matlab.ui.control.Label
        VHIVUSDirectoryEditField        matlab.ui.control.EditField
        GridLayout30                    matlab.ui.container.GridLayout
        MinVHIVUSIDEditFieldLabel       matlab.ui.control.Label
        MinVHIVUSIDEditField            matlab.ui.control.NumericEditField
        GridLayout31                    matlab.ui.container.GridLayout
        MaxVHIVUSIDEditFieldLabel       matlab.ui.control.Label
        MaxVHIVUSIDEditField            matlab.ui.control.NumericEditField
        GridLayout32                    matlab.ui.container.GridLayout
        PixelmmScaleFactorEditFieldLabel  matlab.ui.control.Label
        PixelmmScaleFactorEditField     matlab.ui.control.NumericEditField
        GridLayout46                    matlab.ui.container.GridLayout
        ParseImagesButton               matlab.ui.control.Button
        ClearImageDataButton            matlab.ui.control.Button
        GridLayout50                    matlab.ui.container.GridLayout
        SleeveThicknessmmEditFieldLabel  matlab.ui.control.Label
        SleeveThicknessmmEditField      matlab.ui.control.NumericEditField
        MeshingPanel                    matlab.ui.container.Panel
        GridLayout2                     matlab.ui.container.GridLayout
        GridLayout4                     matlab.ui.container.GridLayout
        MeshResolutionmmEditFieldLabel  matlab.ui.control.Label
        MeshResolutionmmEditField       matlab.ui.control.NumericEditField
        GridLayout7                     matlab.ui.container.GridLayout
        BranchOutletShapeLabel          matlab.ui.control.Label
        ButtonGroup_4                   matlab.ui.container.ButtonGroup
        CircularButton                  matlab.ui.control.ToggleButton
        NaturalButton                   matlab.ui.control.ToggleButton
        GridLayout8                     matlab.ui.container.GridLayout
        TaperBranchOutletLabel          matlab.ui.control.Label
        ButtonGroup_5                   matlab.ui.container.ButtonGroup
        YesButton                       matlab.ui.control.ToggleButton
        NoButton                        matlab.ui.control.ToggleButton
        GridLayout47                    matlab.ui.container.GridLayout
        GenerateMeshButton              matlab.ui.control.Button
        ClearMeshDataButton             matlab.ui.control.Button
        MaterialsTab                    matlab.ui.container.Tab
        GridLayout42                    matlab.ui.container.GridLayout
        CalciumPanel                    matlab.ui.container.Panel
        GridLayout11                    matlab.ui.container.GridLayout
        YoungsModulusEditFieldLabel     matlab.ui.control.Label
        YoungsModulusEditField          matlab.ui.control.NumericEditField
        PoissonsRatioEditFieldLabel     matlab.ui.control.Label
        PoissonsRatioEditField          matlab.ui.control.NumericEditField
        PlotColorLampLabel              matlab.ui.control.Label
        PlotColorLamp                   matlab.ui.control.Lamp
        FibroticPanel                   matlab.ui.container.Panel
        GridLayout16                    matlab.ui.container.GridLayout
        YoungsModulusEditField_4Label   matlab.ui.control.Label
        YoungsModulusEditField_4        matlab.ui.control.NumericEditField
        PoissonsRatioEditField_4Label   matlab.ui.control.Label
        PoissonsRatioEditField_4        matlab.ui.control.NumericEditField
        PlotColorLamp_4Label            matlab.ui.control.Label
        PlotColorLamp_4                 matlab.ui.control.Lamp
        FibrofattyPanel                 matlab.ui.container.Panel
        GridLayout15                    matlab.ui.container.GridLayout
        YoungsModulusEditField_3Label   matlab.ui.control.Label
        YoungsModulusEditField_3        matlab.ui.control.NumericEditField
        PoissonsRatioEditField_3Label   matlab.ui.control.Label
        PoissonsRatioEditField_3        matlab.ui.control.NumericEditField
        PlotColorLamp_3Label            matlab.ui.control.Label
        PlotColorLamp_3                 matlab.ui.control.Lamp
        NecroticCorePanel               matlab.ui.container.Panel
        GridLayout14                    matlab.ui.container.GridLayout
        YoungsModulusEditField_2Label   matlab.ui.control.Label
        YoungsModulusEditField_2        matlab.ui.control.NumericEditField
        PoissonsRatioEditField_2Label   matlab.ui.control.Label
        PoissonsRatioEditField_2        matlab.ui.control.NumericEditField
        PlotColorLamp_2Label            matlab.ui.control.Label
        PlotColorLamp_2                 matlab.ui.control.Lamp
        ArteryWallPanel                 matlab.ui.container.Panel
        GridLayout17                    matlab.ui.container.GridLayout
        YoungsModulusEditField_5Label   matlab.ui.control.Label
        YoungsModulusEditField_5        matlab.ui.control.NumericEditField
        PoissonsRatioEditField_5Label   matlab.ui.control.Label
        PoissonsRatioEditField_5        matlab.ui.control.NumericEditField
        PlotColorLamp_5Label            matlab.ui.control.Label
        PlotColorLamp_5                 matlab.ui.control.Lamp
        FEBioTab                        matlab.ui.container.Tab
        GridLayout43                    matlab.ui.container.GridLayout
        FEBioControlParametersPanel     matlab.ui.container.Panel
        GridLayout13                    matlab.ui.container.GridLayout
        StepSizeEditFieldLabel          matlab.ui.control.Label
        StepSizeEditField               matlab.ui.control.NumericEditField
        NumberofStepsEditFieldLabel     matlab.ui.control.Label
        NumberofStepsEditField          matlab.ui.control.NumericEditField
        MaxReformationsEditFieldLabel   matlab.ui.control.Label
        MaxReformationsEditField        matlab.ui.control.NumericEditField
        MaxUpdatesEditFieldLabel        matlab.ui.control.Label
        MaxUpdatesEditField             matlab.ui.control.NumericEditField
        MaxRetriesEditFieldLabel        matlab.ui.control.Label
        MaxRetriesEditField             matlab.ui.control.NumericEditField
        LoadsPanel                      matlab.ui.container.Panel
        GridLayout27                    matlab.ui.container.GridLayout
        LumenPressureEditFieldLabel     matlab.ui.control.Label
        LumenPressureEditField          matlab.ui.control.NumericEditField
        OutputPanel                     matlab.ui.container.Panel
        GridLayout12                    matlab.ui.container.GridLayout
        GridLayout36                    matlab.ui.container.GridLayout
        FEBiofebSavePathEditFieldLabel  matlab.ui.control.Label
        FEBiofebSavePathEditField       matlab.ui.control.EditField
        GridLayout37                    matlab.ui.container.GridLayout
        FEBiofebFileNameEditFieldLabel  matlab.ui.control.Label
        FEBiofebFileNameEditField       matlab.ui.control.EditField
        SaveFEBioFileButton             matlab.ui.control.Button
        ConfigurationFileManagerPanel   matlab.ui.container.Panel
        LoadSingleConfigurationFilePanel  matlab.ui.container.Panel
        GridLayout25                    matlab.ui.container.GridLayout
        SelectFromFileExplorerButton_3  matlab.ui.control.Button
        GridLayout26                    matlab.ui.container.GridLayout
        EnterPathEditField_3Label       matlab.ui.control.Label
        EnterPathEditField_3            matlab.ui.control.EditField
        LoadButton_4                    matlab.ui.control.Button
        Lamp                            matlab.ui.control.Lamp
        LoadIVUSMeshingConfigurationFilePanel  matlab.ui.container.Panel
        GridLayout20                    matlab.ui.container.GridLayout
        GridLayout22                    matlab.ui.container.GridLayout
        EnterPathEditFieldLabel         matlab.ui.control.Label
        EnterPathEditField              matlab.ui.control.EditField
        LoadButton_3                    matlab.ui.control.Button
        SelectFromFileExplorerButton    matlab.ui.control.Button
        Lamp_2                          matlab.ui.control.Lamp
        LoadFEBioConfigurationFilePanel  matlab.ui.container.Panel
        GridLayout21                    matlab.ui.container.GridLayout
        GridLayout23                    matlab.ui.container.GridLayout
        EnterPathEditField_2Label       matlab.ui.control.Label
        EnterPathEditField_2            matlab.ui.control.EditField
        LoadButton_2                    matlab.ui.control.Button
        SelectFromFileExplorerButton_2  matlab.ui.control.Button
        Lamp_3                          matlab.ui.control.Lamp
        PlotManagerPanel                matlab.ui.container.Panel
        GridLayout52                    matlab.ui.container.GridLayout
        GridLayout53                    matlab.ui.container.GridLayout
        GridLayout54                    matlab.ui.container.GridLayout
        CenterlineButton                matlab.ui.control.StateButton
        VHIVUSDataButton                matlab.ui.control.StateButton
        SurfaceMeshButton               matlab.ui.control.StateButton
        VolumetricMeshButton            matlab.ui.control.StateButton
        ObjectsInPlotLabel              matlab.ui.control.Label
        GridLayout55                    matlab.ui.container.GridLayout
        GridLayout56                    matlab.ui.container.GridLayout
        DaspectButton                   matlab.ui.control.StateButton
        AxisButton_2                    matlab.ui.control.StateButton
        GridLayout57                    matlab.ui.container.GridLayout
        TitleEditFieldLabel             matlab.ui.control.Label
        TitleEditField                  matlab.ui.control.EditField
        GridButton                      matlab.ui.control.StateButton
        SettingsLabel                   matlab.ui.control.Label
        UpdateFigureButton              matlab.ui.control.Button
        ClearFigureButton               matlab.ui.control.Button
        UniversityofTexasatDallasVascularMechanobiologyLabLabel  matlab.ui.control.Label
        Label                           matlab.ui.control.Label
        ERRORPanel                      matlab.ui.container.Panel
        GridLayout48                    matlab.ui.container.GridLayout
        ERRORMESSAGELabel               matlab.ui.control.Label
        GridLayout49                    matlab.ui.container.GridLayout
        ReturnButton                    matlab.ui.control.Button
    end

    
    properties (Access = private)
        % Mesh Components
        tets;
        layers;
        F;
        V;
        outlet_vecs;
        cline;
        is_branched;
        
        % Config Structs
        mesh_config = meshConfigBase();
        feb_config = febConfigBase();
        
        % Plotting
        cline_loaded = false;
        ivus_parsed = false;
        fig;

    end
    
    methods (Access = private)
        
        function updateAllLabelsFromSimgleInputFile(app)
            app.updateVHIVUSMeshingLabels();
            app.updateMaterialsFEBioLabels();
        end
        
        function updateVHIVUSMeshingLabels(app)
            % Update VH-IVUS/Meshing tab - Cenerline pane
            app.CenterlineFilePathEditField.Value = app.mesh_config.cline_path;
            if app.mesh_config.mesh.curvature == "curved"
                app.CurvedButton.Value = 1;
                app.StraightButton.Value = 0;
            else
                app.CurvedButton.Value = 0;
                app.StraightButton.Value = 1;
            end
            app.LoadCenterlineButton.Enable = 1;
            
            % Update VH-IVUS/Meshing tab - VH-IVUS Properties pane
            app.VHIVUSDirectoryEditField.Value = app.mesh_config.img_folder;
            app.MinVHIVUSIDEditField.Value = app.mesh_config.ivus.min;
            app.MaxVHIVUSIDEditField.Value = app.mesh_config.ivus.max;
            app.PixelmmScaleFactorEditField.Value = app.mesh_config.ivus.pixel_scale;
            app.ParseImagesButton.Enable = 1;
            
            % Update VH-IVUS/Meshing tab - Meshing Properties pane
            app.MeshResolutionmmEditField.Value = app.mesh_config.mesh.resample;
            app.SleeveThicknessmmEditField.Value = app.mesh_config.mesh.sleeve_thick;
            if app.mesh_config.mesh.branch_ideal == 1
                app.CircularButton.Value = 1;
                app.NaturalButton.Value = 0;
            else
                app.CircularButton.Value = 0;
                app.NaturalButton.Value = 1;
            end
            if app.mesh_config.mesh.branch_ideal == 1
                app.YesButton.Value = 1;
                app.NoButton.Value = 0;
            else
                app.YesButton.Value = 0;
                app.NoButton.Value = 1;
            end
        end
        
        function updateMaterialsFEBioLabels(app)
            % Update Materials tab - Calcium pane
            app.YoungsModulusEditField.Value = app.feb_config.mats.calcium_E;
            app.PoissonsRatioEditField.Value = app.feb_config.mats.calcium_v;
            
            % Update Materials tab - Necrotic Core pane
            app.YoungsModulusEditField_2.Value = app.feb_config.mats.necrotic_E;
            app.PoissonsRatioEditField_2.Value = app.feb_config.mats.necrotic_v;
            
            % Update Materials tab - Fibrofatty pane
            app.YoungsModulusEditField_3.Value = app.feb_config.mats.fibrofatty_E;
            app.PoissonsRatioEditField_3.Value = app.feb_config.mats.fibrofatty_v;
            
            % Update Materials tab - Fibrotic pane
            app.YoungsModulusEditField_4.Value = app.feb_config.mats.fibrotic_E;
            app.PoissonsRatioEditField_4.Value = app.feb_config.mats.fibrotic_v;
            
            % Update Materials tab - Artery wall pane
            app.YoungsModulusEditField_5.Value = app.feb_config.mats.artery_E;
            app.PoissonsRatioEditField_5.Value = app.feb_config.mats.artery_v;
            
            % Update FEBio tab - FEBio Control Parameters pane
            app.StepSizeEditField.Value = app.feb_config.feb.step_size;
            app.NumberofStepsEditField.Value = app.feb_config.feb.num_steps;
            app.MaxReformationsEditField.Value = app.feb_config.feb.max_refs;
            app.MaxUpdatesEditField.Value = app.feb_config.feb.max_ups;
            app.MaxRetriesEditField.Value = app.feb_config.feb.max_refs;
            
            % Update FEBio tab - Loads pane
            app.LumenPressureEditField.Value = app.feb_config.feb.lumen_p;
            
            % Update FEBio tab - Output pane
            app.FEBiofebSavePathEditField.Value = app.feb_config.feb_folder;
            app.FEBiofebFileNameEditField.Value = app.feb_config.feb.filename;
        end
        
        function updateVHIVUSMeshingButtons(app)
            % Update "Load Centerline" Button
            if app.mesh_config.mesh.curvature == "curved" && isfile(app.mesh_config.cline_path)
                app.LoadCenterlineButton.Enable = true;
                app.ClearCenterlineDataButton.Enable = true;
            else
                app.LoadCenterlineButton.Enable = false;
                app.ClearCenterlineDataButton.Enable = false;
            end
            
            % Update "Parse VH-IVUS Images" Button
            if isfolder(app.mesh_config.img_folder)
                app.mesh_config = getIVUSRange(app.mesh_config);
                app.ParseImagesButton.Enable = true;
                app.ClearImageDataButton.Enable = true;
            else
                app.ParseImagesButton.Enable = false;
                app.ClearImageDataButton.Enable = false;
            end
            
            % Update "Generate Mesh" Button
            if length(app.layers) > 1
                app.GenerateMeshButton.Enable = true;
            else
                app.GenerateMeshButton.Enable = false;
            end
        end
        
        function disableAppActions(app)
            app.Label.Visible = true;
        end
        
        function enableAppActions(app)
            app.Label.Visible = false;
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            close all;
            clc;
            
            app.fig = figure;

        end

        % Button pushed function: SelectFromFileExplorerButton_3
        function SelectSingleConfigFileExplorer(app, event)
            try
                % Open file browser
                [filename,path] = uigetfile('*.ini'); 
                filepath = fullfile(path,filename);
                
                % Check if file path is valid
                if isfile(filepath)
                    % If so, attempt to read file
                    [app.mesh_config, app.feb_config] = parseSingleConfig(filepath);
                    if ~isempty(app.mesh_config) && ~isempty(app.feb_config)
                        app.Lamp.Color = [0,1,0];
                        app.EnterPathEditField_3.Value = filepath;
                        app.updateAllLabelsFromSimgleInputFile();
                    end
                else
                    % If not, update lamp and label text
                    app.Lamp.Color = [1,0,0];
                end
            catch e
                app.disableAppActions();
                app.ERRORPanel.Visible = true;
                app.ERRORMESSAGELabel.Text = e.message;
            end
        end

        % Button pushed function: GenerateMeshButton
        function GenerateMeshButtonPushed(app, event)
            % Disable input fields
            app.MeshResolutionmmEditField.Enable = false;
            app.SleeveThicknessmmEditField.Enable = false;
            app.CircularButton.Enable = false;
            app.NaturalButton.Enable = false;
            app.YesButton.Enable = false;
            app.NoButton.Enable = false;
            
            % Generate mesh
            [app.F,app.V,app.tets,app.outlet_vecs] = generateSurfaceMesh(app.layers,app.mesh_config,app.is_branched);
            app.SurfaceMeshButton.Enable = true;
            
            % Assign Materials
            [app.tets] = assignMaterialsLayers(app.tets,app.layers);
            app.VolumetricMeshButton.Enable = true;
            
            % Enable Clear button
            app.ClearMeshDataButton.Enable = true;
            app.GenerateMeshButton.Enable = false;
            
            if isfolder(app.FEBiofebSavePathEditField.Value)
                app.SaveFEBioFileButton.Enable = true;
            end
        end

        % Button pushed function: SelectFromFileExplorerButton
        function SelectVHIVUSMeshConfigFileExplorer(app, event)
            try
                % Open file browser
                [filename,path] = uigetfile('*.ini'); 
                filepath = fullfile(path,filename);
                
                % Check if file path is valid
                if isfile(filepath)
                    % If so, attempt to read file
                    [app.mesh_config] = parseMeshConfig(filepath);
                    if ~isempty(app.mesh_config)
                        app.Lamp_2.Color = [0,1,0];
                        app.EnterPathEditField.Value = filepath;
                        app.updateVHIVUSMeshingLabels();
                    end
                else
                    % If not, update lamp and label text
                    app.Lamp_2.Color = [1,0,0];
                end
            catch e
                app.ERRORPanel.Visible = true;
                app.ERRORMESSAGELabel.Text = e.message;
            end
        end

        % Button pushed function: SelectFromFileExplorerButton_2
        function SelectMaterialFEBioConfigFileExplorer(app, event)
            try
                % Open file browser
                [filename,path] = uigetfile('*.ini'); 
                filepath = fullfile(path,filename);
                
                % Check if file path is valid
                if isfile(filepath)
                    % If so, attempt to read file
                    [app.feb_config] = parseFEBioConfig(filepath);
                    if ~isempty(app.feb_config)
                        app.Lamp_3.Color = [0,1,0];
                        app.EnterPathEditField_2.Value = filepath;
                        app.updateMaterialsFEBioLabels();
                    end
                else
                    % If not, update lamp and label text
                    app.Lamp_3.Color = [1,0,0];
                end
            catch e
                app.ERRORPanel.Visible = true;
                app.ERRORMESSAGELabel.Text = e.message;
            end
        end

        % Button pushed function: LoadCenterlineButton
        function LoadCenterlineButtonPushed(app, event)
            try
                app.cline = getCenterline(app.mesh_config);
                if ~isempty(app.cline)
                    % Enable Clear and Plot buttons
                    app.CenterlineButton.Enable = true;
                    app.ClearCenterlineDataButton.Enable = true;
                    
                    % Disable Centerline input fields
                    app.CurvedButton.Enable = false;
                    app.StraightButton.Enable = false;
                    app.CenterlineFilePathEditField.Enable = false;
                    app.LoadCenterlineButton.Enable = false;
                else
                    % Disable Clear and Plot Buttons if file load fails
                    app.CenterlineButton.Enable = false;
                    app.ClearCenterlineDataButton.Enable = false;
                    app.LoadCenterlineButton.Enable = true;
                end
                app.cline_loaded = true;
            catch e
                app.cline_loaded = false;
                app.disableAppActions();
                app.ERRORPanel.Visible = true;
                app.ERRORMESSAGELabel.Text = e.message;
            end
        end

        % Button pushed function: ParseImagesButton
        function ParseImagesButtonPushed(app, event)
            % Check if we have a valid centerline
            if ~isempty(app.cline)
                
                % Disable input fields
                app.SleeveThicknessmmEditField.Enable = false;
                app.VHIVUSDirectoryEditField.Enable = false;
                app.MinVHIVUSIDEditField.Enable = false;
                app.MaxVHIVUSIDEditField.Enable = false;
                app.PixelmmScaleFactorEditField.Enable = false;
                
                try
                    % Parse IVUS images
                    [app.layers, app.is_branched] = getIVUSLayers(app.mesh_config, app.cline);
                
                catch e
                    % Re-enable input fields
                    app.SleeveThicknessmmEditField.Enable = true;
                    app.VHIVUSDirectoryEditField.Enable = true;
                    app.MinVHIVUSIDEditField.Enable = true;
                    app.MaxVHIVUSIDEditField.Enable = true;
                    app.PixelmmScaleFactorEditField.Enable = true;
                    return;
                end
                
                % Enable plotting and clear buttons
                app.VHIVUSDataButton.Enable = true;
                app.ClearImageDataButton.Enable = true;
                app.ParseImagesButton.Enable = false;
                
                % Enable mesh creation button
                app.GenerateMeshButton.Enable = true;
                
            else
                % If cline is not valid, disable plotting and clear buttons
                app.VHIVUSDataButton.Enable = false;
                app.ClearImageDataButton.Enable = false;
                
                % Re-enable input fields
                app.SleeveThicknessmmEditField.Enable = true;
                app.VHIVUSDirectoryEditField.Enable = true;
                app.MinVHIVUSIDEditField.Enable = true;
                app.MaxVHIVUSIDEditField.Enable = true;
                app.PixelmmScaleFactorEditField.Enable = true;
            end
        end

        % Button pushed function: UpdateFigureButton
        function UpdateFigureButtonPushed(app, event)

            legend_names = {};
            num_names = 1;
            
            % Clear figure
            [caz,cel] = view;
            clf(app.fig);
            
            % Plot volumetric mesh
            if app.VolumetricMeshButton.Value
                plotTetMesh(app.tets,20,0,0);
            end
            
            % Plot Centerline if button is selected
            if app.CenterlineButton.Value
                plot3(app.cline(:,1),app.cline(:,2),app.cline(:,3),'-o',...
                    'Color','m',...
                    'MarkerSize',5,...
                    'MarkerFaceColor','m');
                legend_names{num_names} = "Centerline"; num_names = num_names + 1;
                hold on;
            end
            
            % Plot VHIVUS pixels if button is selected
            if app.VHIVUSDataButton.Value
                % define colors for each material type
                col_arterial      =   [135 135 135]./ 255;    % Arterial      - Grey
                col_calcium       =   [255 255 255]./ 255;    % Calcium       - White
                col_fibrotic      =   [0   170 0  ]./ 255;    % Fibrotic      - Dark Green
                col_fibrofatty    =   [186 255 0  ]./ 255;    % Fibrofatty    - Light Green
                col_necrotic      =   [255 0   0  ]./ 255;    % Necrotic Core - Red
                col_sleeve        =   [0   0   255]./ 255;    % Sleeve        - Blue
                
                % Stack pixel coords and types
                coords = vertcat(app.layers.coords);
                types = vertcat(app.layers.types);
                
                % Arterial
                v = find(types == app.mesh_config.mats.artery.id);
                if ~ isempty(v)
                    scatter3(coords(v,1), coords(v,2), coords(v,3),'.','MarkerFaceColor', col_arterial,'MarkerEdgeColor', col_arterial); hold on;
                    legend_names{num_names} = 'Arterial'; num_names = num_names + 1;
                end
                
                % Necrotic
                v = find(types == app.mesh_config.mats.necrotic.id);
                if ~ isempty(v)
                    scatter3(coords(v,1), coords(v,2), coords(v,3),'.','MarkerFaceColor', col_necrotic,'MarkerEdgeColor', col_necrotic); hold on;
                    legend_names{num_names} = 'Necrotic'; num_names = num_names + 1;
                end
                
                % Fibrotic
                v = find(types == app.mesh_config.mats.fibrotic.id);
                if ~ isempty(v)
                    scatter3(coords(v,1), coords(v,2), coords(v,3),'.','MarkerFaceColor', col_fibrotic,'MarkerEdgeColor', col_fibrotic); hold on;
                    legend_names{num_names} = 'Fibrotic'; num_names = num_names + 1;
                end
                
                % Fibrofatty
                v = find(types == app.mesh_config.mats.fibrofatty.id);
                if ~ isempty(v)
                    scatter3(coords(v,1), coords(v,2), coords(v,3),'.','MarkerFaceColor', col_fibrofatty,'MarkerEdgeColor', col_fibrofatty); hold on;
                    legend_names{num_names} = 'Fibrofatty'; num_names = num_names + 1;
                end
                
                % Calcium
                v = find(types == app.mesh_config.mats.calcium.id);
                if ~ isempty(v)
                    scatter3(coords(v,1), coords(v,2), coords(v,3),'.','MarkerFaceColor', col_calcium,'MarkerEdgeColor', col_calcium); hold on;
                    legend_names{num_names} = 'Calcium'; num_names = num_names + 1;
                end
                
                % Sleeve
                v = find(types == app.mesh_config.mats.sleeve.id);
                if ~ isempty(v)
                    scatter3(coords(v,1), coords(v,2), coords(v,3),'.','MarkerFaceColor', col_sleeve,'MarkerEdgeColor', col_sleeve); hold on;
                    legend_names{num_names} = 'Sleeve'; num_names = num_names + 1;
                end
            end
            
            % Plot surface mesh
            if app.SurfaceMeshButton.Value
                gpatch(app.F,app.V,'kw','k',0.3);
                legend_names{num_names} = "Mesh"; num_names = num_names + 1;
            end
            
            % Set daspect
            if app.DaspectButton.Value
                daspect([1 1 1]);
            else
                daspect auto;
            end
            
            % Set axis
            if app.AxisButton_2.Value
                axis on;
                xlabel('X');
                ylabel('Y');
                zlabel('Z');
            else
                axis off;
                xlabel('');
                ylabel('');
                zlabel('');
            end
            
            % Set grid
            if app.GridButton.Value
                grid on;
            else
                grid off;
            end
            
            % Set title name
            title(app.TitleEditField.Value);
            
            view(caz,cel);
            legend(legend_names);
            
        end

        % Close request function: UIFigure
        function UIFigureCloseRequest(app, event)
            close all;
            delete(app)
        end

        % Button pushed function: ClearFigureButton
        function ClearFigureButtonPushed(app, event)
            clf(app.fig);
        end

        % Value changed function: PoissonsRatioEditField, 
        % PoissonsRatioEditField_2, PoissonsRatioEditField_3, 
        % PoissonsRatioEditField_4, PoissonsRatioEditField_5, 
        % YoungsModulusEditField, YoungsModulusEditField_2, 
        % YoungsModulusEditField_3, YoungsModulusEditField_4, 
        % YoungsModulusEditField_5
        function MaterialPropertyValueChanged(app, event)
            % Update feb_config object
            app.feb_config.mats.fibrotic.E      = app.YoungsModulusEditField_4.Value;
            app.feb_config.mats.fibrotic.v      = app.PoissonsRatioEditField_4.Value;
            app.feb_config.mats.calcium.E       = app.YoungsModulusEditField.Value;
            app.feb_config.mats.calcium.v       = app.PoissonsRatioEditField.Value;
            app.feb_config.mats.fibrofatty.E    = app.YoungsModulusEditField_3.Value;
            app.feb_config.mats.fibrofatty.v    = app.PoissonsRatioEditField_3.Value;
            app.feb_config.mats.artery.E        = app.YoungsModulusEditField_5.Value;
            app.feb_config.mats.artery.v        = app.PoissonsRatioEditField_5.Value;
            app.feb_config.mats.necrotic.E      = app.YoungsModulusEditField_5.Value;
            app.feb_config.mats.necrotic.v      = app.PoissonsRatioEditField_5.Value;
            
            % Check if all values are valid and enable the "Generate FEBio File" button if they
            
        end

        % Value changed function: FEBiofebFileNameEditField, 
        % FEBiofebSavePathEditField, LumenPressureEditField, 
        % MaxReformationsEditField, MaxRetriesEditField, 
        % MaxUpdatesEditField, NumberofStepsEditField, 
        % StepSizeEditField
        function FEBioConfigPropertyValueChanged(app, event)
            % Update feb_config object
            app.feb_config.feb.step_size        = app.StepSizeEditField.Value;
            app.feb_config.feb.num_steps        = app.NumberofStepsEditField.Value;
            app.feb_config.feb.max_refs         = app.MaxReformationsEditField.Value;
            app.feb_config.feb.max_ups          = app.MaxUpdatesEditField.Value;
            app.feb_config.feb.max_retries      = app.MaxRetriesEditField.Value;
            app.feb_config.feb.lumen_p          = app.LumenPressureEditField.Value;
            app.feb_config.feb.filename         = app.FEBiofebFileNameEditField.Value;
            app.feb_config.feb_folder           = app.FEBiofebSavePathEditField.Value;
            
            % Check if all values are valid and enable the "Generate FEBio File" button if they
            if isfolder(fullfile(app.feb_config.feb_folder)) && ~isempty(fieldnames(app.tets))
                app.SaveFEBioFileButton.Enable = true;
            else
                app.SaveFEBioFileButton.Enable = false;
            end
        end

        % Callback function: ButtonGroup_3, ButtonGroup_4, 
        % ButtonGroup_5, CenterlineFilePathEditField, 
        % MaxVHIVUSIDEditField, MeshResolutionmmEditField, 
        % MinVHIVUSIDEditField, PixelmmScaleFactorEditField, 
        % SleeveThicknessmmEditField, VHIVUSDirectoryEditField
        function MeshConfigPropertyValueChanged(app, event)
            % Update mesh_config object
            if app.CircularButton.Value == 1
                app.mesh_config.mesh.branch_ideal = 1;
            else
                app.mesh_config.mesh.branch_ideal = 0;
            end
            if app.YesButton.Value == 1
                app.mesh_config.mesh.branch_taper = 1;
            else
                app.mesh_config.mesh.branch_taper = 0;
            end
            app.mesh_config.cline_path = app.CenterlineFilePathEditField.Value;
            app.mesh_config.img_folder = app.VHIVUSDirectoryEditField.Value;
            app.mesh_config.ivus.min = app.MinVHIVUSIDEditField.Value;
            app.mesh_config.ivus.max = app.MaxVHIVUSIDEditField.Value;
            app.mesh_config.ivus.pixel_scale = app.PixelmmScaleFactorEditField.Value;
            app.mesh_config.mesh.resample = app.MeshResolutionmmEditField.Value;
            app.mesh_config.mesh.sleeve_thick = app.SleeveThicknessmmEditField.Value;
            
            app.mesh_config = getIVUSRange(app.mesh_config);
            app.updateVHIVUSMeshingLabels();
            
            if app.CurvedButton.Value == 1 && isfile(app.mesh_config.cline_path)
                app.mesh_config.mesh.curvature = "curved";
                app.LoadCenterlineButton.Enable = true;
            elseif app.CurvedButton.Value == 1 && ~isfile(app.mesh_config.cline_path)
                app.mesh_config.mesh.curvature = "straight";
                app.CurvedButton.Value = 0;
                app.StraightButton.Value = 1;
                app.LoadCenterlineButton.Enable = false;
            elseif isfolder(app.mesh_config.img_folder)
                app.CurvedButton.Value = 0;
                app.StraightButton.Value = 1;
                app.LoadCenterlineButton.Enable = true;
            else
                app.LoadCenterlineButton.Enable = false;
            end
            
            if isfolder(app.mesh_config.img_folder)
                app.ParseImagesButton.Enable = true;
            else
                app.ParseImagesButton.Enable = false;
            end
            
        end

        % Button pushed function: ClearCenterlineDataButton
        function ClearCenterlineDataButtonPushed(app, event)
            % Clear centerline object
            app.cline = [];
            
            % Disable plotting and clear buttons
            app.CenterlineButton.Enable = false;
            app.CenterlineButton.Value = false;
            app.ClearCenterlineDataButton.Enable = false;
            app.UpdateFigureButtonPushed();
            
            % Re-enable input fields
            app.CurvedButton.Enable = true;
            app.StraightButton.Enable = true;
            app.CenterlineFilePathEditField.Enable = true;
            app.LoadCenterlineButton.Enable = true;
        end

        % Button pushed function: ClearImageDataButton
        function ClearImageDataButtonPushed(app, event)
            % Clear layers and is_branched objects
            app.layers = struct();
            app.is_branched = 0;
            
            % Disable plotting and clear buttons
            app.VHIVUSDataButton.Enable = false;
            app.VHIVUSDataButton.Value = false;
            app.ClearImageDataButton.Enable = false;
            app.UpdateFigureButtonPushed();
            
            % Re-enable input fields
            app.VHIVUSDirectoryEditField.Enable = true;
            app.MinVHIVUSIDEditField.Enable = true;
            app.MaxVHIVUSIDEditField.Enable = true;
            app.PixelmmScaleFactorEditField.Enable = true;
            app.ParseImagesButton.Enable = true;
            
        end

        % Button pushed function: ClearMeshDataButton
        function ClearMeshDataButtonPushed(app, event)
            % Clear objects
            app.tets = struct();
            app.F = [];
            app.V = [];
            
            % Disable plotting and clear buttons
            app.SurfaceMeshButton.Enable = false;
            app.SurfaceMeshButton.Value = false;
            app.ClearMeshDataButton.Enable = false;
            app.UpdateFigureButtonPushed();
            
            % Re-enable input fields
            app.GenerateMeshButton.Enable = true;
            app.MeshResolutionmmEditField.Enable = true;
            app.SleeveThicknessmmEditField.Enable = true;
            app.CircularButton.Enable = true;
            app.NaturalButton.Enable = true;
            app.YesButton.Enable = true;
            app.NoButton.Enable = true;
            app.GenerateMeshButton.Enable = true;
        end

        % Button pushed function: ReturnButton
        function ClearErrorPanel(app, event)
            app.enableAppActions();
            app.ERRORPanel.Visible = false;
        end

        % Button pushed function: SaveFEBioFileButton
        function SaveFEBioFileButtonPushed(app, event)
            generateFEbioInputFile(app.F, app.tets.surfs, app.tets, app.mesh_config, app.feb_config);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 649 709];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);

            % Create AutomatedVHIVUS3DArteryReconstructionLabel
            app.AutomatedVHIVUS3DArteryReconstructionLabel = uilabel(app.UIFigure);
            app.AutomatedVHIVUS3DArteryReconstructionLabel.HorizontalAlignment = 'center';
            app.AutomatedVHIVUS3DArteryReconstructionLabel.FontSize = 20;
            app.AutomatedVHIVUS3DArteryReconstructionLabel.FontWeight = 'bold';
            app.AutomatedVHIVUS3DArteryReconstructionLabel.Position = [311 642 330 44];
            app.AutomatedVHIVUS3DArteryReconstructionLabel.Text = 'VH-IVUS Artery Reconstruction';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [111 590 190 110];
            app.Image.ImageSource = 'VolumeAndStressCrossover.png';

            % Create Image3
            app.Image3 = uiimage(app.UIFigure);
            app.Image3.Position = [11 590 110 110];
            app.Image3.ImageSource = 'utdLogo.jpg';

            % Create MeshingFEBioPropertyManagerPanel
            app.MeshingFEBioPropertyManagerPanel = uipanel(app.UIFigure);
            app.MeshingFEBioPropertyManagerPanel.TitlePosition = 'centertop';
            app.MeshingFEBioPropertyManagerPanel.Title = 'Meshing/FEBio Property Manager';
            app.MeshingFEBioPropertyManagerPanel.BackgroundColor = [0.902 0.902 0.902];
            app.MeshingFEBioPropertyManagerPanel.FontWeight = 'bold';
            app.MeshingFEBioPropertyManagerPanel.FontSize = 15;
            app.MeshingFEBioPropertyManagerPanel.Position = [311 10 330 570];

            % Create TabGroup
            app.TabGroup = uitabgroup(app.MeshingFEBioPropertyManagerPanel);
            app.TabGroup.Position = [11 7 310 530];

            % Create VHIVUSMeshingTab
            app.VHIVUSMeshingTab = uitab(app.TabGroup);
            app.VHIVUSMeshingTab.Title = 'VH-IVUS/Meshing';
            app.VHIVUSMeshingTab.BackgroundColor = [0.902 0.902 0.902];

            % Create GridLayout41
            app.GridLayout41 = uigridlayout(app.VHIVUSMeshingTab);
            app.GridLayout41.ColumnWidth = {'1x'};
            app.GridLayout41.RowHeight = {'0.75x', '1.3x', '1x', '0.4x'};
            app.GridLayout41.ColumnSpacing = 5;
            app.GridLayout41.RowSpacing = 5;
            app.GridLayout41.Padding = [5 5 5 5];

            % Create CenterlinePanel
            app.CenterlinePanel = uipanel(app.GridLayout41);
            app.CenterlinePanel.Title = 'Centerline';
            app.CenterlinePanel.BackgroundColor = [0.8 0.8 0.8];
            app.CenterlinePanel.Layout.Row = 1;
            app.CenterlinePanel.Layout.Column = 1;
            app.CenterlinePanel.FontWeight = 'bold';
            app.CenterlinePanel.FontSize = 13;

            % Create GridLayout33
            app.GridLayout33 = uigridlayout(app.CenterlinePanel);
            app.GridLayout33.ColumnWidth = {'1x'};
            app.GridLayout33.RowHeight = {'1x', '1x', '1x'};
            app.GridLayout33.ColumnSpacing = 5;
            app.GridLayout33.RowSpacing = 5;
            app.GridLayout33.Padding = [5 5 5 5];

            % Create GridLayout34
            app.GridLayout34 = uigridlayout(app.GridLayout33);
            app.GridLayout34.RowHeight = {'1x'};
            app.GridLayout34.ColumnSpacing = 5;
            app.GridLayout34.RowSpacing = 5;
            app.GridLayout34.Padding = [5 0 5 0];
            app.GridLayout34.Layout.Row = 1;
            app.GridLayout34.Layout.Column = 1;

            % Create CurvatureLabel
            app.CurvatureLabel = uilabel(app.GridLayout34);
            app.CurvatureLabel.HorizontalAlignment = 'center';
            app.CurvatureLabel.Layout.Row = 1;
            app.CurvatureLabel.Layout.Column = 1;
            app.CurvatureLabel.Text = 'Curvature';

            % Create ButtonGroup_3
            app.ButtonGroup_3 = uibuttongroup(app.GridLayout34);
            app.ButtonGroup_3.SelectionChangedFcn = createCallbackFcn(app, @MeshConfigPropertyValueChanged, true);
            app.ButtonGroup_3.BorderType = 'none';
            app.ButtonGroup_3.BackgroundColor = [0.8 0.8 0.8];
            app.ButtonGroup_3.Layout.Row = 1;
            app.ButtonGroup_3.Layout.Column = 2;

            % Create CurvedButton
            app.CurvedButton = uitogglebutton(app.ButtonGroup_3);
            app.CurvedButton.Text = 'Curved';
            app.CurvedButton.Position = [1 0 60 22];

            % Create StraightButton
            app.StraightButton = uitogglebutton(app.ButtonGroup_3);
            app.StraightButton.IconAlignment = 'right';
            app.StraightButton.Text = 'Straight';
            app.StraightButton.Position = [71 0 60 22];
            app.StraightButton.Value = true;

            % Create GridLayout35
            app.GridLayout35 = uigridlayout(app.GridLayout33);
            app.GridLayout35.RowHeight = {'1x'};
            app.GridLayout35.ColumnSpacing = 5;
            app.GridLayout35.RowSpacing = 5;
            app.GridLayout35.Padding = [5 0 5 0];
            app.GridLayout35.Layout.Row = 2;
            app.GridLayout35.Layout.Column = 1;

            % Create CenterlineFilePathEditFieldLabel
            app.CenterlineFilePathEditFieldLabel = uilabel(app.GridLayout35);
            app.CenterlineFilePathEditFieldLabel.HorizontalAlignment = 'center';
            app.CenterlineFilePathEditFieldLabel.Layout.Row = 1;
            app.CenterlineFilePathEditFieldLabel.Layout.Column = 1;
            app.CenterlineFilePathEditFieldLabel.Text = 'Centerline File Path';

            % Create CenterlineFilePathEditField
            app.CenterlineFilePathEditField = uieditfield(app.GridLayout35, 'text');
            app.CenterlineFilePathEditField.ValueChangedFcn = createCallbackFcn(app, @MeshConfigPropertyValueChanged, true);
            app.CenterlineFilePathEditField.Layout.Row = 1;
            app.CenterlineFilePathEditField.Layout.Column = 2;

            % Create GridLayout45
            app.GridLayout45 = uigridlayout(app.GridLayout33);
            app.GridLayout45.RowHeight = {'1x'};
            app.GridLayout45.ColumnSpacing = 5;
            app.GridLayout45.RowSpacing = 0;
            app.GridLayout45.Padding = [0 0 0 0];
            app.GridLayout45.Layout.Row = 3;
            app.GridLayout45.Layout.Column = 1;

            % Create LoadCenterlineButton
            app.LoadCenterlineButton = uibutton(app.GridLayout45, 'push');
            app.LoadCenterlineButton.ButtonPushedFcn = createCallbackFcn(app, @LoadCenterlineButtonPushed, true);
            app.LoadCenterlineButton.BackgroundColor = [0.1608 0.6 0.2196];
            app.LoadCenterlineButton.FontSize = 13;
            app.LoadCenterlineButton.FontWeight = 'bold';
            app.LoadCenterlineButton.Enable = 'off';
            app.LoadCenterlineButton.Layout.Row = 1;
            app.LoadCenterlineButton.Layout.Column = 1;
            app.LoadCenterlineButton.Text = 'Load Centerline';

            % Create ClearCenterlineDataButton
            app.ClearCenterlineDataButton = uibutton(app.GridLayout45, 'push');
            app.ClearCenterlineDataButton.ButtonPushedFcn = createCallbackFcn(app, @ClearCenterlineDataButtonPushed, true);
            app.ClearCenterlineDataButton.BackgroundColor = [0.9294 0.6941 0.1255];
            app.ClearCenterlineDataButton.FontSize = 13;
            app.ClearCenterlineDataButton.FontWeight = 'bold';
            app.ClearCenterlineDataButton.Enable = 'off';
            app.ClearCenterlineDataButton.Layout.Row = 1;
            app.ClearCenterlineDataButton.Layout.Column = 2;
            app.ClearCenterlineDataButton.Text = 'Clear Centerline Data';

            % Create VHIVUSPanel
            app.VHIVUSPanel = uipanel(app.GridLayout41);
            app.VHIVUSPanel.Title = 'VH-IVUS';
            app.VHIVUSPanel.BackgroundColor = [0.8 0.8 0.8];
            app.VHIVUSPanel.Layout.Row = 2;
            app.VHIVUSPanel.Layout.Column = 1;
            app.VHIVUSPanel.FontWeight = 'bold';
            app.VHIVUSPanel.Scrollable = 'on';
            app.VHIVUSPanel.FontSize = 13;

            % Create GridLayout3
            app.GridLayout3 = uigridlayout(app.VHIVUSPanel);
            app.GridLayout3.ColumnWidth = {'1x'};
            app.GridLayout3.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x'};
            app.GridLayout3.ColumnSpacing = 5;
            app.GridLayout3.RowSpacing = 5;
            app.GridLayout3.Padding = [5 5 5 5];

            % Create GridLayout28
            app.GridLayout28 = uigridlayout(app.GridLayout3);
            app.GridLayout28.RowHeight = {'1x'};
            app.GridLayout28.ColumnSpacing = 5;
            app.GridLayout28.RowSpacing = 5;
            app.GridLayout28.Padding = [5 0 5 0];
            app.GridLayout28.Layout.Row = 1;
            app.GridLayout28.Layout.Column = 1;

            % Create VHIVUSDirectoryEditFieldLabel
            app.VHIVUSDirectoryEditFieldLabel = uilabel(app.GridLayout28);
            app.VHIVUSDirectoryEditFieldLabel.HorizontalAlignment = 'center';
            app.VHIVUSDirectoryEditFieldLabel.Layout.Row = 1;
            app.VHIVUSDirectoryEditFieldLabel.Layout.Column = 1;
            app.VHIVUSDirectoryEditFieldLabel.Text = 'VH-IVUS Directory';

            % Create VHIVUSDirectoryEditField
            app.VHIVUSDirectoryEditField = uieditfield(app.GridLayout28, 'text');
            app.VHIVUSDirectoryEditField.ValueChangedFcn = createCallbackFcn(app, @MeshConfigPropertyValueChanged, true);
            app.VHIVUSDirectoryEditField.Layout.Row = 1;
            app.VHIVUSDirectoryEditField.Layout.Column = 2;

            % Create GridLayout30
            app.GridLayout30 = uigridlayout(app.GridLayout3);
            app.GridLayout30.RowHeight = {'1x'};
            app.GridLayout30.ColumnSpacing = 5;
            app.GridLayout30.RowSpacing = 5;
            app.GridLayout30.Padding = [5 0 5 0];
            app.GridLayout30.Layout.Row = 2;
            app.GridLayout30.Layout.Column = 1;

            % Create MinVHIVUSIDEditFieldLabel
            app.MinVHIVUSIDEditFieldLabel = uilabel(app.GridLayout30);
            app.MinVHIVUSIDEditFieldLabel.HorizontalAlignment = 'center';
            app.MinVHIVUSIDEditFieldLabel.Layout.Row = 1;
            app.MinVHIVUSIDEditFieldLabel.Layout.Column = 1;
            app.MinVHIVUSIDEditFieldLabel.Text = 'Min VH-IVUS ID';

            % Create MinVHIVUSIDEditField
            app.MinVHIVUSIDEditField = uieditfield(app.GridLayout30, 'numeric');
            app.MinVHIVUSIDEditField.Limits = [-1 Inf];
            app.MinVHIVUSIDEditField.ValueChangedFcn = createCallbackFcn(app, @MeshConfigPropertyValueChanged, true);
            app.MinVHIVUSIDEditField.HorizontalAlignment = 'center';
            app.MinVHIVUSIDEditField.Layout.Row = 1;
            app.MinVHIVUSIDEditField.Layout.Column = 2;

            % Create GridLayout31
            app.GridLayout31 = uigridlayout(app.GridLayout3);
            app.GridLayout31.RowHeight = {'1x'};
            app.GridLayout31.ColumnSpacing = 5;
            app.GridLayout31.RowSpacing = 5;
            app.GridLayout31.Padding = [5 0 5 0];
            app.GridLayout31.Layout.Row = 3;
            app.GridLayout31.Layout.Column = 1;

            % Create MaxVHIVUSIDEditFieldLabel
            app.MaxVHIVUSIDEditFieldLabel = uilabel(app.GridLayout31);
            app.MaxVHIVUSIDEditFieldLabel.HorizontalAlignment = 'center';
            app.MaxVHIVUSIDEditFieldLabel.Layout.Row = 1;
            app.MaxVHIVUSIDEditFieldLabel.Layout.Column = 1;
            app.MaxVHIVUSIDEditFieldLabel.Text = 'Max VH-IVUS ID';

            % Create MaxVHIVUSIDEditField
            app.MaxVHIVUSIDEditField = uieditfield(app.GridLayout31, 'numeric');
            app.MaxVHIVUSIDEditField.Limits = [1 Inf];
            app.MaxVHIVUSIDEditField.ValueChangedFcn = createCallbackFcn(app, @MeshConfigPropertyValueChanged, true);
            app.MaxVHIVUSIDEditField.HorizontalAlignment = 'center';
            app.MaxVHIVUSIDEditField.Layout.Row = 1;
            app.MaxVHIVUSIDEditField.Layout.Column = 2;
            app.MaxVHIVUSIDEditField.Value = 1;

            % Create GridLayout32
            app.GridLayout32 = uigridlayout(app.GridLayout3);
            app.GridLayout32.RowHeight = {'1x'};
            app.GridLayout32.ColumnSpacing = 5;
            app.GridLayout32.RowSpacing = 5;
            app.GridLayout32.Padding = [5 0 5 0];
            app.GridLayout32.Layout.Row = 4;
            app.GridLayout32.Layout.Column = 1;

            % Create PixelmmScaleFactorEditFieldLabel
            app.PixelmmScaleFactorEditFieldLabel = uilabel(app.GridLayout32);
            app.PixelmmScaleFactorEditFieldLabel.HorizontalAlignment = 'center';
            app.PixelmmScaleFactorEditFieldLabel.Layout.Row = 1;
            app.PixelmmScaleFactorEditFieldLabel.Layout.Column = 1;
            app.PixelmmScaleFactorEditFieldLabel.Text = 'Pixel-mm Scale Factor';

            % Create PixelmmScaleFactorEditField
            app.PixelmmScaleFactorEditField = uieditfield(app.GridLayout32, 'numeric');
            app.PixelmmScaleFactorEditField.Limits = [0.0001 Inf];
            app.PixelmmScaleFactorEditField.ValueChangedFcn = createCallbackFcn(app, @MeshConfigPropertyValueChanged, true);
            app.PixelmmScaleFactorEditField.HorizontalAlignment = 'center';
            app.PixelmmScaleFactorEditField.Layout.Row = 1;
            app.PixelmmScaleFactorEditField.Layout.Column = 2;
            app.PixelmmScaleFactorEditField.Value = 0.0148;

            % Create GridLayout46
            app.GridLayout46 = uigridlayout(app.GridLayout3);
            app.GridLayout46.RowHeight = {'1x'};
            app.GridLayout46.ColumnSpacing = 5;
            app.GridLayout46.Padding = [0 0 0 0];
            app.GridLayout46.Layout.Row = 6;
            app.GridLayout46.Layout.Column = 1;

            % Create ParseImagesButton
            app.ParseImagesButton = uibutton(app.GridLayout46, 'push');
            app.ParseImagesButton.ButtonPushedFcn = createCallbackFcn(app, @ParseImagesButtonPushed, true);
            app.ParseImagesButton.BackgroundColor = [0.1608 0.6 0.2196];
            app.ParseImagesButton.FontSize = 13;
            app.ParseImagesButton.FontWeight = 'bold';
            app.ParseImagesButton.Enable = 'off';
            app.ParseImagesButton.Layout.Row = 1;
            app.ParseImagesButton.Layout.Column = 1;
            app.ParseImagesButton.Text = 'Parse Images';

            % Create ClearImageDataButton
            app.ClearImageDataButton = uibutton(app.GridLayout46, 'push');
            app.ClearImageDataButton.ButtonPushedFcn = createCallbackFcn(app, @ClearImageDataButtonPushed, true);
            app.ClearImageDataButton.BackgroundColor = [0.9294 0.6941 0.1255];
            app.ClearImageDataButton.FontSize = 13;
            app.ClearImageDataButton.FontWeight = 'bold';
            app.ClearImageDataButton.Enable = 'off';
            app.ClearImageDataButton.Layout.Row = 1;
            app.ClearImageDataButton.Layout.Column = 2;
            app.ClearImageDataButton.Text = 'Clear Image Data';

            % Create GridLayout50
            app.GridLayout50 = uigridlayout(app.GridLayout3);
            app.GridLayout50.RowHeight = {'1x'};
            app.GridLayout50.ColumnSpacing = 5;
            app.GridLayout50.RowSpacing = 5;
            app.GridLayout50.Padding = [5 0 5 0];
            app.GridLayout50.Layout.Row = 5;
            app.GridLayout50.Layout.Column = 1;

            % Create SleeveThicknessmmEditFieldLabel
            app.SleeveThicknessmmEditFieldLabel = uilabel(app.GridLayout50);
            app.SleeveThicknessmmEditFieldLabel.HorizontalAlignment = 'center';
            app.SleeveThicknessmmEditFieldLabel.Layout.Row = 1;
            app.SleeveThicknessmmEditFieldLabel.Layout.Column = 1;
            app.SleeveThicknessmmEditFieldLabel.Text = 'Sleeve Thickness [mm]';

            % Create SleeveThicknessmmEditField
            app.SleeveThicknessmmEditField = uieditfield(app.GridLayout50, 'numeric');
            app.SleeveThicknessmmEditField.Limits = [0 Inf];
            app.SleeveThicknessmmEditField.ValueChangedFcn = createCallbackFcn(app, @MeshConfigPropertyValueChanged, true);
            app.SleeveThicknessmmEditField.HorizontalAlignment = 'center';
            app.SleeveThicknessmmEditField.Layout.Row = 1;
            app.SleeveThicknessmmEditField.Layout.Column = 2;

            % Create MeshingPanel
            app.MeshingPanel = uipanel(app.GridLayout41);
            app.MeshingPanel.Title = 'Meshing';
            app.MeshingPanel.BackgroundColor = [0.8 0.8 0.8];
            app.MeshingPanel.Layout.Row = 3;
            app.MeshingPanel.Layout.Column = 1;
            app.MeshingPanel.FontWeight = 'bold';
            app.MeshingPanel.Scrollable = 'on';
            app.MeshingPanel.FontSize = 13;

            % Create GridLayout2
            app.GridLayout2 = uigridlayout(app.MeshingPanel);
            app.GridLayout2.ColumnWidth = {'1x'};
            app.GridLayout2.RowHeight = {'1x', '1x', '1x', '1x'};
            app.GridLayout2.ColumnSpacing = 5;
            app.GridLayout2.RowSpacing = 5;
            app.GridLayout2.Padding = [5 5 5 5];

            % Create GridLayout4
            app.GridLayout4 = uigridlayout(app.GridLayout2);
            app.GridLayout4.ColumnWidth = {'1x', '0.75x'};
            app.GridLayout4.RowHeight = {'1x'};
            app.GridLayout4.ColumnSpacing = 5;
            app.GridLayout4.RowSpacing = 5;
            app.GridLayout4.Padding = [5 0 5 0];
            app.GridLayout4.Layout.Row = 1;
            app.GridLayout4.Layout.Column = 1;

            % Create MeshResolutionmmEditFieldLabel
            app.MeshResolutionmmEditFieldLabel = uilabel(app.GridLayout4);
            app.MeshResolutionmmEditFieldLabel.HorizontalAlignment = 'center';
            app.MeshResolutionmmEditFieldLabel.Layout.Row = 1;
            app.MeshResolutionmmEditFieldLabel.Layout.Column = 1;
            app.MeshResolutionmmEditFieldLabel.Text = 'Mesh Resolution [mm]';

            % Create MeshResolutionmmEditField
            app.MeshResolutionmmEditField = uieditfield(app.GridLayout4, 'numeric');
            app.MeshResolutionmmEditField.Limits = [0.001 Inf];
            app.MeshResolutionmmEditField.ValueChangedFcn = createCallbackFcn(app, @MeshConfigPropertyValueChanged, true);
            app.MeshResolutionmmEditField.HorizontalAlignment = 'center';
            app.MeshResolutionmmEditField.Layout.Row = 1;
            app.MeshResolutionmmEditField.Layout.Column = 2;
            app.MeshResolutionmmEditField.Value = 0.2;

            % Create GridLayout7
            app.GridLayout7 = uigridlayout(app.GridLayout2);
            app.GridLayout7.ColumnWidth = {'1x', '0.75x'};
            app.GridLayout7.RowHeight = {'1x'};
            app.GridLayout7.ColumnSpacing = 5;
            app.GridLayout7.RowSpacing = 5;
            app.GridLayout7.Padding = [5 0 5 0];
            app.GridLayout7.Layout.Row = 2;
            app.GridLayout7.Layout.Column = 1;

            % Create BranchOutletShapeLabel
            app.BranchOutletShapeLabel = uilabel(app.GridLayout7);
            app.BranchOutletShapeLabel.HorizontalAlignment = 'center';
            app.BranchOutletShapeLabel.Layout.Row = 1;
            app.BranchOutletShapeLabel.Layout.Column = 1;
            app.BranchOutletShapeLabel.Text = 'Branch Outlet Shape';

            % Create ButtonGroup_4
            app.ButtonGroup_4 = uibuttongroup(app.GridLayout7);
            app.ButtonGroup_4.SelectionChangedFcn = createCallbackFcn(app, @MeshConfigPropertyValueChanged, true);
            app.ButtonGroup_4.BorderType = 'none';
            app.ButtonGroup_4.BackgroundColor = [0.8 0.8 0.8];
            app.ButtonGroup_4.Layout.Row = 1;
            app.ButtonGroup_4.Layout.Column = 2;

            % Create CircularButton
            app.CircularButton = uitogglebutton(app.ButtonGroup_4);
            app.CircularButton.Text = 'Circular';
            app.CircularButton.Position = [1 2 50 22];
            app.CircularButton.Value = true;

            % Create NaturalButton
            app.NaturalButton = uitogglebutton(app.ButtonGroup_4);
            app.NaturalButton.Text = 'Natural';
            app.NaturalButton.Position = [61 2 50 22];

            % Create GridLayout8
            app.GridLayout8 = uigridlayout(app.GridLayout2);
            app.GridLayout8.ColumnWidth = {'1x', '0.75x'};
            app.GridLayout8.RowHeight = {'1x'};
            app.GridLayout8.ColumnSpacing = 5;
            app.GridLayout8.RowSpacing = 5;
            app.GridLayout8.Padding = [5 0 5 0];
            app.GridLayout8.Layout.Row = 3;
            app.GridLayout8.Layout.Column = 1;

            % Create TaperBranchOutletLabel
            app.TaperBranchOutletLabel = uilabel(app.GridLayout8);
            app.TaperBranchOutletLabel.HorizontalAlignment = 'center';
            app.TaperBranchOutletLabel.Layout.Row = 1;
            app.TaperBranchOutletLabel.Layout.Column = 1;
            app.TaperBranchOutletLabel.Text = 'Taper Branch Outlet?';

            % Create ButtonGroup_5
            app.ButtonGroup_5 = uibuttongroup(app.GridLayout8);
            app.ButtonGroup_5.SelectionChangedFcn = createCallbackFcn(app, @MeshConfigPropertyValueChanged, true);
            app.ButtonGroup_5.BorderType = 'none';
            app.ButtonGroup_5.BackgroundColor = [0.8 0.8 0.8];
            app.ButtonGroup_5.Layout.Row = 1;
            app.ButtonGroup_5.Layout.Column = 2;

            % Create YesButton
            app.YesButton = uitogglebutton(app.ButtonGroup_5);
            app.YesButton.Text = 'Yes';
            app.YesButton.Position = [1 2 50 22];
            app.YesButton.Value = true;

            % Create NoButton
            app.NoButton = uitogglebutton(app.ButtonGroup_5);
            app.NoButton.Text = 'No';
            app.NoButton.Position = [61 2 50 22];

            % Create GridLayout47
            app.GridLayout47 = uigridlayout(app.GridLayout2);
            app.GridLayout47.RowHeight = {'1x'};
            app.GridLayout47.ColumnSpacing = 5;
            app.GridLayout47.RowSpacing = 0;
            app.GridLayout47.Padding = [0 0 0 0];
            app.GridLayout47.Layout.Row = 4;
            app.GridLayout47.Layout.Column = 1;

            % Create GenerateMeshButton
            app.GenerateMeshButton = uibutton(app.GridLayout47, 'push');
            app.GenerateMeshButton.ButtonPushedFcn = createCallbackFcn(app, @GenerateMeshButtonPushed, true);
            app.GenerateMeshButton.BackgroundColor = [0.1608 0.6 0.2196];
            app.GenerateMeshButton.FontSize = 13;
            app.GenerateMeshButton.FontWeight = 'bold';
            app.GenerateMeshButton.Enable = 'off';
            app.GenerateMeshButton.Layout.Row = 1;
            app.GenerateMeshButton.Layout.Column = 1;
            app.GenerateMeshButton.Text = 'Generate Mesh';

            % Create ClearMeshDataButton
            app.ClearMeshDataButton = uibutton(app.GridLayout47, 'push');
            app.ClearMeshDataButton.ButtonPushedFcn = createCallbackFcn(app, @ClearMeshDataButtonPushed, true);
            app.ClearMeshDataButton.BackgroundColor = [0.9294 0.6941 0.1255];
            app.ClearMeshDataButton.FontSize = 13;
            app.ClearMeshDataButton.FontWeight = 'bold';
            app.ClearMeshDataButton.Enable = 'off';
            app.ClearMeshDataButton.Layout.Row = 1;
            app.ClearMeshDataButton.Layout.Column = 2;
            app.ClearMeshDataButton.Text = 'Clear Mesh Data';

            % Create MaterialsTab
            app.MaterialsTab = uitab(app.TabGroup);
            app.MaterialsTab.Title = 'Materials';

            % Create GridLayout42
            app.GridLayout42 = uigridlayout(app.MaterialsTab);
            app.GridLayout42.ColumnWidth = {'1x'};
            app.GridLayout42.RowHeight = {'1x', '1x', '1x', '1x', '1x'};
            app.GridLayout42.ColumnSpacing = 5;
            app.GridLayout42.RowSpacing = 5;
            app.GridLayout42.Padding = [5 5 5 5];

            % Create CalciumPanel
            app.CalciumPanel = uipanel(app.GridLayout42);
            app.CalciumPanel.Title = 'Calcium';
            app.CalciumPanel.BackgroundColor = [0.8 0.8 0.8];
            app.CalciumPanel.Layout.Row = 1;
            app.CalciumPanel.Layout.Column = 1;
            app.CalciumPanel.FontWeight = 'bold';
            app.CalciumPanel.FontSize = 13;

            % Create GridLayout11
            app.GridLayout11 = uigridlayout(app.CalciumPanel);
            app.GridLayout11.RowHeight = {'0.75x', '1x', '1x'};
            app.GridLayout11.ColumnSpacing = 5;
            app.GridLayout11.RowSpacing = 5;
            app.GridLayout11.Padding = [5 5 5 5];

            % Create YoungsModulusEditFieldLabel
            app.YoungsModulusEditFieldLabel = uilabel(app.GridLayout11);
            app.YoungsModulusEditFieldLabel.HorizontalAlignment = 'center';
            app.YoungsModulusEditFieldLabel.Layout.Row = 2;
            app.YoungsModulusEditFieldLabel.Layout.Column = 1;
            app.YoungsModulusEditFieldLabel.Text = 'Young''s Modulus';

            % Create YoungsModulusEditField
            app.YoungsModulusEditField = uieditfield(app.GridLayout11, 'numeric');
            app.YoungsModulusEditField.Limits = [1e-05 Inf];
            app.YoungsModulusEditField.ValueChangedFcn = createCallbackFcn(app, @MaterialPropertyValueChanged, true);
            app.YoungsModulusEditField.HorizontalAlignment = 'center';
            app.YoungsModulusEditField.Layout.Row = 2;
            app.YoungsModulusEditField.Layout.Column = 2;
            app.YoungsModulusEditField.Value = 10;

            % Create PoissonsRatioEditFieldLabel
            app.PoissonsRatioEditFieldLabel = uilabel(app.GridLayout11);
            app.PoissonsRatioEditFieldLabel.HorizontalAlignment = 'center';
            app.PoissonsRatioEditFieldLabel.Layout.Row = 3;
            app.PoissonsRatioEditFieldLabel.Layout.Column = 1;
            app.PoissonsRatioEditFieldLabel.Text = 'Poisson''s Ratio';

            % Create PoissonsRatioEditField
            app.PoissonsRatioEditField = uieditfield(app.GridLayout11, 'numeric');
            app.PoissonsRatioEditField.Limits = [1e-05 0.49];
            app.PoissonsRatioEditField.ValueChangedFcn = createCallbackFcn(app, @MaterialPropertyValueChanged, true);
            app.PoissonsRatioEditField.HorizontalAlignment = 'center';
            app.PoissonsRatioEditField.Layout.Row = 3;
            app.PoissonsRatioEditField.Layout.Column = 2;
            app.PoissonsRatioEditField.Value = 0.48;

            % Create PlotColorLampLabel
            app.PlotColorLampLabel = uilabel(app.GridLayout11);
            app.PlotColorLampLabel.HorizontalAlignment = 'center';
            app.PlotColorLampLabel.Layout.Row = 1;
            app.PlotColorLampLabel.Layout.Column = 1;
            app.PlotColorLampLabel.Text = 'Plot Color';

            % Create PlotColorLamp
            app.PlotColorLamp = uilamp(app.GridLayout11);
            app.PlotColorLamp.Layout.Row = 1;
            app.PlotColorLamp.Layout.Column = 2;
            app.PlotColorLamp.Color = [1 1 1];

            % Create FibroticPanel
            app.FibroticPanel = uipanel(app.GridLayout42);
            app.FibroticPanel.Title = 'Fibrotic';
            app.FibroticPanel.BackgroundColor = [0.8 0.8 0.8];
            app.FibroticPanel.Layout.Row = 2;
            app.FibroticPanel.Layout.Column = 1;
            app.FibroticPanel.FontWeight = 'bold';
            app.FibroticPanel.FontSize = 13;

            % Create GridLayout16
            app.GridLayout16 = uigridlayout(app.FibroticPanel);
            app.GridLayout16.RowHeight = {'0.75x', '1x', '1x'};
            app.GridLayout16.ColumnSpacing = 5;
            app.GridLayout16.RowSpacing = 5;
            app.GridLayout16.Padding = [5 5 5 5];

            % Create YoungsModulusEditField_4Label
            app.YoungsModulusEditField_4Label = uilabel(app.GridLayout16);
            app.YoungsModulusEditField_4Label.HorizontalAlignment = 'center';
            app.YoungsModulusEditField_4Label.Layout.Row = 2;
            app.YoungsModulusEditField_4Label.Layout.Column = 1;
            app.YoungsModulusEditField_4Label.Text = 'Young''s Modulus';

            % Create YoungsModulusEditField_4
            app.YoungsModulusEditField_4 = uieditfield(app.GridLayout16, 'numeric');
            app.YoungsModulusEditField_4.Limits = [1e-05 Inf];
            app.YoungsModulusEditField_4.ValueChangedFcn = createCallbackFcn(app, @MaterialPropertyValueChanged, true);
            app.YoungsModulusEditField_4.HorizontalAlignment = 'center';
            app.YoungsModulusEditField_4.Layout.Row = 2;
            app.YoungsModulusEditField_4.Layout.Column = 2;
            app.YoungsModulusEditField_4.Value = 0.6;

            % Create PoissonsRatioEditField_4Label
            app.PoissonsRatioEditField_4Label = uilabel(app.GridLayout16);
            app.PoissonsRatioEditField_4Label.HorizontalAlignment = 'center';
            app.PoissonsRatioEditField_4Label.Layout.Row = 3;
            app.PoissonsRatioEditField_4Label.Layout.Column = 1;
            app.PoissonsRatioEditField_4Label.Text = 'Poisson''s Ratio';

            % Create PoissonsRatioEditField_4
            app.PoissonsRatioEditField_4 = uieditfield(app.GridLayout16, 'numeric');
            app.PoissonsRatioEditField_4.Limits = [1e-05 0.49];
            app.PoissonsRatioEditField_4.ValueChangedFcn = createCallbackFcn(app, @MaterialPropertyValueChanged, true);
            app.PoissonsRatioEditField_4.HorizontalAlignment = 'center';
            app.PoissonsRatioEditField_4.Layout.Row = 3;
            app.PoissonsRatioEditField_4.Layout.Column = 2;
            app.PoissonsRatioEditField_4.Value = 0.48;

            % Create PlotColorLamp_4Label
            app.PlotColorLamp_4Label = uilabel(app.GridLayout16);
            app.PlotColorLamp_4Label.HorizontalAlignment = 'center';
            app.PlotColorLamp_4Label.Layout.Row = 1;
            app.PlotColorLamp_4Label.Layout.Column = 1;
            app.PlotColorLamp_4Label.Text = 'Plot Color';

            % Create PlotColorLamp_4
            app.PlotColorLamp_4 = uilamp(app.GridLayout16);
            app.PlotColorLamp_4.Layout.Row = 1;
            app.PlotColorLamp_4.Layout.Column = 2;
            app.PlotColorLamp_4.Color = [0 0.6588 0];

            % Create FibrofattyPanel
            app.FibrofattyPanel = uipanel(app.GridLayout42);
            app.FibrofattyPanel.Title = 'Fibrofatty';
            app.FibrofattyPanel.BackgroundColor = [0.8 0.8 0.8];
            app.FibrofattyPanel.Layout.Row = 3;
            app.FibrofattyPanel.Layout.Column = 1;
            app.FibrofattyPanel.FontWeight = 'bold';
            app.FibrofattyPanel.FontSize = 13;

            % Create GridLayout15
            app.GridLayout15 = uigridlayout(app.FibrofattyPanel);
            app.GridLayout15.RowHeight = {'0.75x', '1x', '1x'};
            app.GridLayout15.ColumnSpacing = 5;
            app.GridLayout15.RowSpacing = 5;
            app.GridLayout15.Padding = [5 5 5 5];

            % Create YoungsModulusEditField_3Label
            app.YoungsModulusEditField_3Label = uilabel(app.GridLayout15);
            app.YoungsModulusEditField_3Label.HorizontalAlignment = 'center';
            app.YoungsModulusEditField_3Label.Layout.Row = 2;
            app.YoungsModulusEditField_3Label.Layout.Column = 1;
            app.YoungsModulusEditField_3Label.Text = 'Young''s Modulus';

            % Create YoungsModulusEditField_3
            app.YoungsModulusEditField_3 = uieditfield(app.GridLayout15, 'numeric');
            app.YoungsModulusEditField_3.Limits = [1e-05 Inf];
            app.YoungsModulusEditField_3.ValueChangedFcn = createCallbackFcn(app, @MaterialPropertyValueChanged, true);
            app.YoungsModulusEditField_3.HorizontalAlignment = 'center';
            app.YoungsModulusEditField_3.Layout.Row = 2;
            app.YoungsModulusEditField_3.Layout.Column = 2;
            app.YoungsModulusEditField_3.Value = 0.5;

            % Create PoissonsRatioEditField_3Label
            app.PoissonsRatioEditField_3Label = uilabel(app.GridLayout15);
            app.PoissonsRatioEditField_3Label.HorizontalAlignment = 'center';
            app.PoissonsRatioEditField_3Label.Layout.Row = 3;
            app.PoissonsRatioEditField_3Label.Layout.Column = 1;
            app.PoissonsRatioEditField_3Label.Text = 'Poisson''s Ratio';

            % Create PoissonsRatioEditField_3
            app.PoissonsRatioEditField_3 = uieditfield(app.GridLayout15, 'numeric');
            app.PoissonsRatioEditField_3.Limits = [1e-05 0.49];
            app.PoissonsRatioEditField_3.ValueChangedFcn = createCallbackFcn(app, @MaterialPropertyValueChanged, true);
            app.PoissonsRatioEditField_3.HorizontalAlignment = 'center';
            app.PoissonsRatioEditField_3.Layout.Row = 3;
            app.PoissonsRatioEditField_3.Layout.Column = 2;
            app.PoissonsRatioEditField_3.Value = 0.48;

            % Create PlotColorLamp_3Label
            app.PlotColorLamp_3Label = uilabel(app.GridLayout15);
            app.PlotColorLamp_3Label.HorizontalAlignment = 'center';
            app.PlotColorLamp_3Label.Layout.Row = 1;
            app.PlotColorLamp_3Label.Layout.Column = 1;
            app.PlotColorLamp_3Label.Text = 'Plot Color';

            % Create PlotColorLamp_3
            app.PlotColorLamp_3 = uilamp(app.GridLayout15);
            app.PlotColorLamp_3.Layout.Row = 1;
            app.PlotColorLamp_3.Layout.Column = 2;
            app.PlotColorLamp_3.Color = [0.7294 1 0];

            % Create NecroticCorePanel
            app.NecroticCorePanel = uipanel(app.GridLayout42);
            app.NecroticCorePanel.Title = 'Necrotic Core';
            app.NecroticCorePanel.BackgroundColor = [0.8 0.8 0.8];
            app.NecroticCorePanel.Layout.Row = 4;
            app.NecroticCorePanel.Layout.Column = 1;
            app.NecroticCorePanel.FontWeight = 'bold';
            app.NecroticCorePanel.FontSize = 13;

            % Create GridLayout14
            app.GridLayout14 = uigridlayout(app.NecroticCorePanel);
            app.GridLayout14.RowHeight = {'0.75x', '1x', '1x'};
            app.GridLayout14.ColumnSpacing = 5;
            app.GridLayout14.RowSpacing = 5;
            app.GridLayout14.Padding = [5 5 5 5];

            % Create YoungsModulusEditField_2Label
            app.YoungsModulusEditField_2Label = uilabel(app.GridLayout14);
            app.YoungsModulusEditField_2Label.HorizontalAlignment = 'center';
            app.YoungsModulusEditField_2Label.Layout.Row = 2;
            app.YoungsModulusEditField_2Label.Layout.Column = 1;
            app.YoungsModulusEditField_2Label.Text = 'Young''s Modulus';

            % Create YoungsModulusEditField_2
            app.YoungsModulusEditField_2 = uieditfield(app.GridLayout14, 'numeric');
            app.YoungsModulusEditField_2.Limits = [1e-05 Inf];
            app.YoungsModulusEditField_2.ValueChangedFcn = createCallbackFcn(app, @MaterialPropertyValueChanged, true);
            app.YoungsModulusEditField_2.HorizontalAlignment = 'center';
            app.YoungsModulusEditField_2.Layout.Row = 2;
            app.YoungsModulusEditField_2.Layout.Column = 2;
            app.YoungsModulusEditField_2.Value = 0.02;

            % Create PoissonsRatioEditField_2Label
            app.PoissonsRatioEditField_2Label = uilabel(app.GridLayout14);
            app.PoissonsRatioEditField_2Label.HorizontalAlignment = 'center';
            app.PoissonsRatioEditField_2Label.Layout.Row = 3;
            app.PoissonsRatioEditField_2Label.Layout.Column = 1;
            app.PoissonsRatioEditField_2Label.Text = 'Poisson''s Ratio';

            % Create PoissonsRatioEditField_2
            app.PoissonsRatioEditField_2 = uieditfield(app.GridLayout14, 'numeric');
            app.PoissonsRatioEditField_2.Limits = [1e-06 0.49];
            app.PoissonsRatioEditField_2.ValueChangedFcn = createCallbackFcn(app, @MaterialPropertyValueChanged, true);
            app.PoissonsRatioEditField_2.HorizontalAlignment = 'center';
            app.PoissonsRatioEditField_2.Layout.Row = 3;
            app.PoissonsRatioEditField_2.Layout.Column = 2;
            app.PoissonsRatioEditField_2.Value = 0.48;

            % Create PlotColorLamp_2Label
            app.PlotColorLamp_2Label = uilabel(app.GridLayout14);
            app.PlotColorLamp_2Label.HorizontalAlignment = 'center';
            app.PlotColorLamp_2Label.Layout.Row = 1;
            app.PlotColorLamp_2Label.Layout.Column = 1;
            app.PlotColorLamp_2Label.Text = 'Plot Color';

            % Create PlotColorLamp_2
            app.PlotColorLamp_2 = uilamp(app.GridLayout14);
            app.PlotColorLamp_2.Layout.Row = 1;
            app.PlotColorLamp_2.Layout.Column = 2;
            app.PlotColorLamp_2.Color = [1 0 0];

            % Create ArteryWallPanel
            app.ArteryWallPanel = uipanel(app.GridLayout42);
            app.ArteryWallPanel.Title = 'Artery Wall';
            app.ArteryWallPanel.BackgroundColor = [0.8 0.8 0.8];
            app.ArteryWallPanel.Layout.Row = 5;
            app.ArteryWallPanel.Layout.Column = 1;
            app.ArteryWallPanel.FontWeight = 'bold';
            app.ArteryWallPanel.FontSize = 13;

            % Create GridLayout17
            app.GridLayout17 = uigridlayout(app.ArteryWallPanel);
            app.GridLayout17.RowHeight = {'0.75x', '1x', '1x'};
            app.GridLayout17.ColumnSpacing = 5;
            app.GridLayout17.RowSpacing = 5;
            app.GridLayout17.Padding = [5 5 5 5];

            % Create YoungsModulusEditField_5Label
            app.YoungsModulusEditField_5Label = uilabel(app.GridLayout17);
            app.YoungsModulusEditField_5Label.HorizontalAlignment = 'center';
            app.YoungsModulusEditField_5Label.Layout.Row = 2;
            app.YoungsModulusEditField_5Label.Layout.Column = 1;
            app.YoungsModulusEditField_5Label.Text = 'Young''s Modulus';

            % Create YoungsModulusEditField_5
            app.YoungsModulusEditField_5 = uieditfield(app.GridLayout17, 'numeric');
            app.YoungsModulusEditField_5.Limits = [1e-05 Inf];
            app.YoungsModulusEditField_5.ValueChangedFcn = createCallbackFcn(app, @MaterialPropertyValueChanged, true);
            app.YoungsModulusEditField_5.HorizontalAlignment = 'center';
            app.YoungsModulusEditField_5.Layout.Row = 2;
            app.YoungsModulusEditField_5.Layout.Column = 2;
            app.YoungsModulusEditField_5.Value = 0.3;

            % Create PoissonsRatioEditField_5Label
            app.PoissonsRatioEditField_5Label = uilabel(app.GridLayout17);
            app.PoissonsRatioEditField_5Label.HorizontalAlignment = 'center';
            app.PoissonsRatioEditField_5Label.Layout.Row = 3;
            app.PoissonsRatioEditField_5Label.Layout.Column = 1;
            app.PoissonsRatioEditField_5Label.Text = 'Poisson''s Ratio';

            % Create PoissonsRatioEditField_5
            app.PoissonsRatioEditField_5 = uieditfield(app.GridLayout17, 'numeric');
            app.PoissonsRatioEditField_5.Limits = [1e-05 0.49];
            app.PoissonsRatioEditField_5.ValueChangedFcn = createCallbackFcn(app, @MaterialPropertyValueChanged, true);
            app.PoissonsRatioEditField_5.HorizontalAlignment = 'center';
            app.PoissonsRatioEditField_5.Layout.Row = 3;
            app.PoissonsRatioEditField_5.Layout.Column = 2;
            app.PoissonsRatioEditField_5.Value = 0.48;

            % Create PlotColorLamp_5Label
            app.PlotColorLamp_5Label = uilabel(app.GridLayout17);
            app.PlotColorLamp_5Label.HorizontalAlignment = 'center';
            app.PlotColorLamp_5Label.Layout.Row = 1;
            app.PlotColorLamp_5Label.Layout.Column = 1;
            app.PlotColorLamp_5Label.Text = 'Plot Color';

            % Create PlotColorLamp_5
            app.PlotColorLamp_5 = uilamp(app.GridLayout17);
            app.PlotColorLamp_5.Layout.Row = 1;
            app.PlotColorLamp_5.Layout.Column = 2;
            app.PlotColorLamp_5.Color = [0.5294 0.5294 0.5294];

            % Create FEBioTab
            app.FEBioTab = uitab(app.TabGroup);
            app.FEBioTab.Title = 'FEBio';

            % Create GridLayout43
            app.GridLayout43 = uigridlayout(app.FEBioTab);
            app.GridLayout43.ColumnWidth = {'1x'};
            app.GridLayout43.RowHeight = {'1.1x', '0.4x', '0.8x', '1x'};
            app.GridLayout43.ColumnSpacing = 5;
            app.GridLayout43.RowSpacing = 5;
            app.GridLayout43.Padding = [5 5 5 5];

            % Create FEBioControlParametersPanel
            app.FEBioControlParametersPanel = uipanel(app.GridLayout43);
            app.FEBioControlParametersPanel.Title = 'FEBio Control Parameters';
            app.FEBioControlParametersPanel.BackgroundColor = [0.8 0.8 0.8];
            app.FEBioControlParametersPanel.Layout.Row = 1;
            app.FEBioControlParametersPanel.Layout.Column = 1;
            app.FEBioControlParametersPanel.FontWeight = 'bold';
            app.FEBioControlParametersPanel.FontSize = 13;

            % Create GridLayout13
            app.GridLayout13 = uigridlayout(app.FEBioControlParametersPanel);
            app.GridLayout13.RowHeight = {'1x', '1x', '1x', '1x', '1x'};
            app.GridLayout13.ColumnSpacing = 5;
            app.GridLayout13.RowSpacing = 5;
            app.GridLayout13.Padding = [5 5 5 5];

            % Create StepSizeEditFieldLabel
            app.StepSizeEditFieldLabel = uilabel(app.GridLayout13);
            app.StepSizeEditFieldLabel.HorizontalAlignment = 'center';
            app.StepSizeEditFieldLabel.Layout.Row = 1;
            app.StepSizeEditFieldLabel.Layout.Column = 1;
            app.StepSizeEditFieldLabel.Text = 'Step Size';

            % Create StepSizeEditField
            app.StepSizeEditField = uieditfield(app.GridLayout13, 'numeric');
            app.StepSizeEditField.Limits = [1e-05 Inf];
            app.StepSizeEditField.ValueChangedFcn = createCallbackFcn(app, @FEBioConfigPropertyValueChanged, true);
            app.StepSizeEditField.HorizontalAlignment = 'center';
            app.StepSizeEditField.Layout.Row = 1;
            app.StepSizeEditField.Layout.Column = 2;
            app.StepSizeEditField.Value = 0.1;

            % Create NumberofStepsEditFieldLabel
            app.NumberofStepsEditFieldLabel = uilabel(app.GridLayout13);
            app.NumberofStepsEditFieldLabel.HorizontalAlignment = 'center';
            app.NumberofStepsEditFieldLabel.Layout.Row = 2;
            app.NumberofStepsEditFieldLabel.Layout.Column = 1;
            app.NumberofStepsEditFieldLabel.Text = 'Number of Steps';

            % Create NumberofStepsEditField
            app.NumberofStepsEditField = uieditfield(app.GridLayout13, 'numeric');
            app.NumberofStepsEditField.Limits = [1 Inf];
            app.NumberofStepsEditField.ValueChangedFcn = createCallbackFcn(app, @FEBioConfigPropertyValueChanged, true);
            app.NumberofStepsEditField.HorizontalAlignment = 'center';
            app.NumberofStepsEditField.Layout.Row = 2;
            app.NumberofStepsEditField.Layout.Column = 2;
            app.NumberofStepsEditField.Value = 10;

            % Create MaxReformationsEditFieldLabel
            app.MaxReformationsEditFieldLabel = uilabel(app.GridLayout13);
            app.MaxReformationsEditFieldLabel.HorizontalAlignment = 'center';
            app.MaxReformationsEditFieldLabel.Layout.Row = 3;
            app.MaxReformationsEditFieldLabel.Layout.Column = 1;
            app.MaxReformationsEditFieldLabel.Text = 'Max Reformations';

            % Create MaxReformationsEditField
            app.MaxReformationsEditField = uieditfield(app.GridLayout13, 'numeric');
            app.MaxReformationsEditField.Limits = [1 Inf];
            app.MaxReformationsEditField.ValueChangedFcn = createCallbackFcn(app, @FEBioConfigPropertyValueChanged, true);
            app.MaxReformationsEditField.HorizontalAlignment = 'center';
            app.MaxReformationsEditField.Layout.Row = 3;
            app.MaxReformationsEditField.Layout.Column = 2;
            app.MaxReformationsEditField.Value = 15;

            % Create MaxUpdatesEditFieldLabel
            app.MaxUpdatesEditFieldLabel = uilabel(app.GridLayout13);
            app.MaxUpdatesEditFieldLabel.HorizontalAlignment = 'center';
            app.MaxUpdatesEditFieldLabel.Layout.Row = 4;
            app.MaxUpdatesEditFieldLabel.Layout.Column = 1;
            app.MaxUpdatesEditFieldLabel.Text = 'Max Updates';

            % Create MaxUpdatesEditField
            app.MaxUpdatesEditField = uieditfield(app.GridLayout13, 'numeric');
            app.MaxUpdatesEditField.Limits = [0 Inf];
            app.MaxUpdatesEditField.ValueChangedFcn = createCallbackFcn(app, @FEBioConfigPropertyValueChanged, true);
            app.MaxUpdatesEditField.HorizontalAlignment = 'center';
            app.MaxUpdatesEditField.Layout.Row = 4;
            app.MaxUpdatesEditField.Layout.Column = 2;

            % Create MaxRetriesEditFieldLabel
            app.MaxRetriesEditFieldLabel = uilabel(app.GridLayout13);
            app.MaxRetriesEditFieldLabel.HorizontalAlignment = 'center';
            app.MaxRetriesEditFieldLabel.Layout.Row = 5;
            app.MaxRetriesEditFieldLabel.Layout.Column = 1;
            app.MaxRetriesEditFieldLabel.Text = 'Max Retries';

            % Create MaxRetriesEditField
            app.MaxRetriesEditField = uieditfield(app.GridLayout13, 'numeric');
            app.MaxRetriesEditField.Limits = [0 Inf];
            app.MaxRetriesEditField.ValueChangedFcn = createCallbackFcn(app, @FEBioConfigPropertyValueChanged, true);
            app.MaxRetriesEditField.HorizontalAlignment = 'center';
            app.MaxRetriesEditField.Layout.Row = 5;
            app.MaxRetriesEditField.Layout.Column = 2;
            app.MaxRetriesEditField.Value = 10;

            % Create LoadsPanel
            app.LoadsPanel = uipanel(app.GridLayout43);
            app.LoadsPanel.Title = 'Loads';
            app.LoadsPanel.BackgroundColor = [0.8 0.8 0.8];
            app.LoadsPanel.Layout.Row = 2;
            app.LoadsPanel.Layout.Column = 1;
            app.LoadsPanel.FontWeight = 'bold';
            app.LoadsPanel.FontSize = 13;

            % Create GridLayout27
            app.GridLayout27 = uigridlayout(app.LoadsPanel);
            app.GridLayout27.RowHeight = {'1x'};
            app.GridLayout27.ColumnSpacing = 5;
            app.GridLayout27.RowSpacing = 5;
            app.GridLayout27.Padding = [5 5 5 5];

            % Create LumenPressureEditFieldLabel
            app.LumenPressureEditFieldLabel = uilabel(app.GridLayout27);
            app.LumenPressureEditFieldLabel.HorizontalAlignment = 'center';
            app.LumenPressureEditFieldLabel.FontWeight = 'bold';
            app.LumenPressureEditFieldLabel.Layout.Row = 1;
            app.LumenPressureEditFieldLabel.Layout.Column = 1;
            app.LumenPressureEditFieldLabel.Text = 'Lumen Pressure';

            % Create LumenPressureEditField
            app.LumenPressureEditField = uieditfield(app.GridLayout27, 'numeric');
            app.LumenPressureEditField.Limits = [0 Inf];
            app.LumenPressureEditField.ValueChangedFcn = createCallbackFcn(app, @FEBioConfigPropertyValueChanged, true);
            app.LumenPressureEditField.HorizontalAlignment = 'center';
            app.LumenPressureEditField.Layout.Row = 1;
            app.LumenPressureEditField.Layout.Column = 2;

            % Create OutputPanel
            app.OutputPanel = uipanel(app.GridLayout43);
            app.OutputPanel.Title = 'Output';
            app.OutputPanel.BackgroundColor = [0.8 0.8 0.8];
            app.OutputPanel.Layout.Row = 3;
            app.OutputPanel.Layout.Column = 1;
            app.OutputPanel.FontWeight = 'bold';
            app.OutputPanel.FontSize = 13;

            % Create GridLayout12
            app.GridLayout12 = uigridlayout(app.OutputPanel);
            app.GridLayout12.ColumnWidth = {'1x'};
            app.GridLayout12.RowHeight = {'1x', '1x', '1x'};
            app.GridLayout12.ColumnSpacing = 5;
            app.GridLayout12.RowSpacing = 5;
            app.GridLayout12.Padding = [5 5 5 5];

            % Create GridLayout36
            app.GridLayout36 = uigridlayout(app.GridLayout12);
            app.GridLayout36.RowHeight = {'1x'};
            app.GridLayout36.ColumnSpacing = 5;
            app.GridLayout36.RowSpacing = 5;
            app.GridLayout36.Padding = [0 0 0 0];
            app.GridLayout36.Layout.Row = 1;
            app.GridLayout36.Layout.Column = 1;

            % Create FEBiofebSavePathEditFieldLabel
            app.FEBiofebSavePathEditFieldLabel = uilabel(app.GridLayout36);
            app.FEBiofebSavePathEditFieldLabel.HorizontalAlignment = 'center';
            app.FEBiofebSavePathEditFieldLabel.Layout.Row = 1;
            app.FEBiofebSavePathEditFieldLabel.Layout.Column = 1;
            app.FEBiofebSavePathEditFieldLabel.Text = 'FEBio .feb Save Path';

            % Create FEBiofebSavePathEditField
            app.FEBiofebSavePathEditField = uieditfield(app.GridLayout36, 'text');
            app.FEBiofebSavePathEditField.ValueChangedFcn = createCallbackFcn(app, @FEBioConfigPropertyValueChanged, true);
            app.FEBiofebSavePathEditField.Layout.Row = 1;
            app.FEBiofebSavePathEditField.Layout.Column = 2;

            % Create GridLayout37
            app.GridLayout37 = uigridlayout(app.GridLayout12);
            app.GridLayout37.RowHeight = {'1x'};
            app.GridLayout37.ColumnSpacing = 5;
            app.GridLayout37.RowSpacing = 5;
            app.GridLayout37.Padding = [0 0 0 0];
            app.GridLayout37.Layout.Row = 2;
            app.GridLayout37.Layout.Column = 1;

            % Create FEBiofebFileNameEditFieldLabel
            app.FEBiofebFileNameEditFieldLabel = uilabel(app.GridLayout37);
            app.FEBiofebFileNameEditFieldLabel.HorizontalAlignment = 'center';
            app.FEBiofebFileNameEditFieldLabel.Layout.Row = 1;
            app.FEBiofebFileNameEditFieldLabel.Layout.Column = 1;
            app.FEBiofebFileNameEditFieldLabel.Text = 'FEBio .feb File Name';

            % Create FEBiofebFileNameEditField
            app.FEBiofebFileNameEditField = uieditfield(app.GridLayout37, 'text');
            app.FEBiofebFileNameEditField.ValueChangedFcn = createCallbackFcn(app, @FEBioConfigPropertyValueChanged, true);
            app.FEBiofebFileNameEditField.Layout.Row = 1;
            app.FEBiofebFileNameEditField.Layout.Column = 2;

            % Create SaveFEBioFileButton
            app.SaveFEBioFileButton = uibutton(app.GridLayout12, 'push');
            app.SaveFEBioFileButton.ButtonPushedFcn = createCallbackFcn(app, @SaveFEBioFileButtonPushed, true);
            app.SaveFEBioFileButton.Icon = 'FEBioLogo.png';
            app.SaveFEBioFileButton.BackgroundColor = [0.1608 0.6 0.2196];
            app.SaveFEBioFileButton.FontSize = 13;
            app.SaveFEBioFileButton.FontWeight = 'bold';
            app.SaveFEBioFileButton.Enable = 'off';
            app.SaveFEBioFileButton.Layout.Row = 3;
            app.SaveFEBioFileButton.Layout.Column = 1;
            app.SaveFEBioFileButton.Text = 'Save FEBio File';

            % Create ConfigurationFileManagerPanel
            app.ConfigurationFileManagerPanel = uipanel(app.UIFigure);
            app.ConfigurationFileManagerPanel.TitlePosition = 'centertop';
            app.ConfigurationFileManagerPanel.Title = 'Configuration File Manager';
            app.ConfigurationFileManagerPanel.BackgroundColor = [0.902 0.902 0.902];
            app.ConfigurationFileManagerPanel.FontWeight = 'bold';
            app.ConfigurationFileManagerPanel.FontSize = 15;
            app.ConfigurationFileManagerPanel.Position = [11 220 290 360];

            % Create LoadSingleConfigurationFilePanel
            app.LoadSingleConfigurationFilePanel = uipanel(app.ConfigurationFileManagerPanel);
            app.LoadSingleConfigurationFilePanel.Title = 'Load Single Configuration File';
            app.LoadSingleConfigurationFilePanel.BackgroundColor = [0.8 0.8 0.8];
            app.LoadSingleConfigurationFilePanel.FontWeight = 'bold';
            app.LoadSingleConfigurationFilePanel.FontSize = 13;
            app.LoadSingleConfigurationFilePanel.Position = [11 227 270 100];

            % Create GridLayout25
            app.GridLayout25 = uigridlayout(app.LoadSingleConfigurationFilePanel);
            app.GridLayout25.ColumnWidth = {'1x'};
            app.GridLayout25.RowHeight = {'0.75x', '1x'};
            app.GridLayout25.ColumnSpacing = 5;
            app.GridLayout25.RowSpacing = 5;
            app.GridLayout25.Padding = [5 5 5 5];

            % Create SelectFromFileExplorerButton_3
            app.SelectFromFileExplorerButton_3 = uibutton(app.GridLayout25, 'push');
            app.SelectFromFileExplorerButton_3.ButtonPushedFcn = createCallbackFcn(app, @SelectSingleConfigFileExplorer, true);
            app.SelectFromFileExplorerButton_3.Tag = 'InputFileLoadButton';
            app.SelectFromFileExplorerButton_3.BackgroundColor = [0.1608 0.6 0.2196];
            app.SelectFromFileExplorerButton_3.FontSize = 13;
            app.SelectFromFileExplorerButton_3.FontWeight = 'bold';
            app.SelectFromFileExplorerButton_3.Layout.Row = 1;
            app.SelectFromFileExplorerButton_3.Layout.Column = 1;
            app.SelectFromFileExplorerButton_3.Text = 'Select From File Explorer';

            % Create GridLayout26
            app.GridLayout26 = uigridlayout(app.GridLayout25);
            app.GridLayout26.ColumnWidth = {'0.5x', '1x', '0.5x'};
            app.GridLayout26.RowHeight = {'1x'};
            app.GridLayout26.ColumnSpacing = 5;
            app.GridLayout26.RowSpacing = 5;
            app.GridLayout26.Padding = [5 5 5 5];
            app.GridLayout26.Layout.Row = 2;
            app.GridLayout26.Layout.Column = 1;

            % Create EnterPathEditField_3Label
            app.EnterPathEditField_3Label = uilabel(app.GridLayout26);
            app.EnterPathEditField_3Label.HorizontalAlignment = 'center';
            app.EnterPathEditField_3Label.Layout.Row = 1;
            app.EnterPathEditField_3Label.Layout.Column = 1;
            app.EnterPathEditField_3Label.Text = 'Enter Path';

            % Create EnterPathEditField_3
            app.EnterPathEditField_3 = uieditfield(app.GridLayout26, 'text');
            app.EnterPathEditField_3.Layout.Row = 1;
            app.EnterPathEditField_3.Layout.Column = 2;

            % Create LoadButton_4
            app.LoadButton_4 = uibutton(app.GridLayout26, 'push');
            app.LoadButton_4.FontWeight = 'bold';
            app.LoadButton_4.Layout.Row = 1;
            app.LoadButton_4.Layout.Column = 3;
            app.LoadButton_4.Text = 'Load';

            % Create Lamp
            app.Lamp = uilamp(app.ConfigurationFileManagerPanel);
            app.Lamp.HandleVisibility = 'callback';
            app.Lamp.Tag = 'InputFileLamp';
            app.Lamp.Position = [261 307 20 20];
            app.Lamp.Color = [0.9294 0.6902 0.1294];

            % Create LoadIVUSMeshingConfigurationFilePanel
            app.LoadIVUSMeshingConfigurationFilePanel = uipanel(app.ConfigurationFileManagerPanel);
            app.LoadIVUSMeshingConfigurationFilePanel.Title = 'Load IVUS/Meshing Configuration File';
            app.LoadIVUSMeshingConfigurationFilePanel.BackgroundColor = [0.8 0.8 0.8];
            app.LoadIVUSMeshingConfigurationFilePanel.FontWeight = 'bold';
            app.LoadIVUSMeshingConfigurationFilePanel.FontSize = 13;
            app.LoadIVUSMeshingConfigurationFilePanel.Position = [11 117 270 100];

            % Create GridLayout20
            app.GridLayout20 = uigridlayout(app.LoadIVUSMeshingConfigurationFilePanel);
            app.GridLayout20.ColumnWidth = {'1x'};
            app.GridLayout20.RowHeight = {'0.75x', '1x'};
            app.GridLayout20.ColumnSpacing = 5;
            app.GridLayout20.RowSpacing = 5;
            app.GridLayout20.Padding = [5 5 5 5];

            % Create GridLayout22
            app.GridLayout22 = uigridlayout(app.GridLayout20);
            app.GridLayout22.ColumnWidth = {'0.5x', '1x', '0.5x'};
            app.GridLayout22.RowHeight = {'1x'};
            app.GridLayout22.ColumnSpacing = 5;
            app.GridLayout22.RowSpacing = 5;
            app.GridLayout22.Padding = [5 5 5 5];
            app.GridLayout22.Layout.Row = 2;
            app.GridLayout22.Layout.Column = 1;

            % Create EnterPathEditFieldLabel
            app.EnterPathEditFieldLabel = uilabel(app.GridLayout22);
            app.EnterPathEditFieldLabel.HorizontalAlignment = 'center';
            app.EnterPathEditFieldLabel.Layout.Row = 1;
            app.EnterPathEditFieldLabel.Layout.Column = 1;
            app.EnterPathEditFieldLabel.Text = 'Enter Path';

            % Create EnterPathEditField
            app.EnterPathEditField = uieditfield(app.GridLayout22, 'text');
            app.EnterPathEditField.HorizontalAlignment = 'center';
            app.EnterPathEditField.Layout.Row = 1;
            app.EnterPathEditField.Layout.Column = 2;

            % Create LoadButton_3
            app.LoadButton_3 = uibutton(app.GridLayout22, 'push');
            app.LoadButton_3.Tag = 'ImageLoadButton';
            app.LoadButton_3.FontWeight = 'bold';
            app.LoadButton_3.Layout.Row = 1;
            app.LoadButton_3.Layout.Column = 3;
            app.LoadButton_3.Text = 'Load';

            % Create SelectFromFileExplorerButton
            app.SelectFromFileExplorerButton = uibutton(app.GridLayout20, 'push');
            app.SelectFromFileExplorerButton.ButtonPushedFcn = createCallbackFcn(app, @SelectVHIVUSMeshConfigFileExplorer, true);
            app.SelectFromFileExplorerButton.BackgroundColor = [0.1608 0.6 0.2196];
            app.SelectFromFileExplorerButton.FontSize = 13;
            app.SelectFromFileExplorerButton.FontWeight = 'bold';
            app.SelectFromFileExplorerButton.Layout.Row = 1;
            app.SelectFromFileExplorerButton.Layout.Column = 1;
            app.SelectFromFileExplorerButton.Text = 'Select From File Explorer';

            % Create Lamp_2
            app.Lamp_2 = uilamp(app.ConfigurationFileManagerPanel);
            app.Lamp_2.Tag = 'MeshFileLamp';
            app.Lamp_2.Position = [261 198 19 19];
            app.Lamp_2.Color = [0.9294 0.6902 0.1294];

            % Create LoadFEBioConfigurationFilePanel
            app.LoadFEBioConfigurationFilePanel = uipanel(app.ConfigurationFileManagerPanel);
            app.LoadFEBioConfigurationFilePanel.Title = 'Load FEBio Configuration File';
            app.LoadFEBioConfigurationFilePanel.BackgroundColor = [0.8 0.8 0.8];
            app.LoadFEBioConfigurationFilePanel.FontWeight = 'bold';
            app.LoadFEBioConfigurationFilePanel.FontSize = 13;
            app.LoadFEBioConfigurationFilePanel.Position = [11 7 270 100];

            % Create GridLayout21
            app.GridLayout21 = uigridlayout(app.LoadFEBioConfigurationFilePanel);
            app.GridLayout21.ColumnWidth = {'1x'};
            app.GridLayout21.RowHeight = {'0.75x', '1x'};
            app.GridLayout21.ColumnSpacing = 5;
            app.GridLayout21.RowSpacing = 5;
            app.GridLayout21.Padding = [5 5 5 5];

            % Create GridLayout23
            app.GridLayout23 = uigridlayout(app.GridLayout21);
            app.GridLayout23.ColumnWidth = {'0.5x', '1x', '0.5x'};
            app.GridLayout23.RowHeight = {'1x'};
            app.GridLayout23.ColumnSpacing = 5;
            app.GridLayout23.RowSpacing = 5;
            app.GridLayout23.Padding = [5 5 5 5];
            app.GridLayout23.Layout.Row = 2;
            app.GridLayout23.Layout.Column = 1;

            % Create EnterPathEditField_2Label
            app.EnterPathEditField_2Label = uilabel(app.GridLayout23);
            app.EnterPathEditField_2Label.HorizontalAlignment = 'center';
            app.EnterPathEditField_2Label.Layout.Row = 1;
            app.EnterPathEditField_2Label.Layout.Column = 1;
            app.EnterPathEditField_2Label.Text = 'Enter Path';

            % Create EnterPathEditField_2
            app.EnterPathEditField_2 = uieditfield(app.GridLayout23, 'text');
            app.EnterPathEditField_2.Layout.Row = 1;
            app.EnterPathEditField_2.Layout.Column = 2;

            % Create LoadButton_2
            app.LoadButton_2 = uibutton(app.GridLayout23, 'push');
            app.LoadButton_2.Tag = 'CenterlineLoadButton';
            app.LoadButton_2.FontWeight = 'bold';
            app.LoadButton_2.Layout.Row = 1;
            app.LoadButton_2.Layout.Column = 3;
            app.LoadButton_2.Text = 'Load';

            % Create SelectFromFileExplorerButton_2
            app.SelectFromFileExplorerButton_2 = uibutton(app.GridLayout21, 'push');
            app.SelectFromFileExplorerButton_2.ButtonPushedFcn = createCallbackFcn(app, @SelectMaterialFEBioConfigFileExplorer, true);
            app.SelectFromFileExplorerButton_2.BackgroundColor = [0.1608 0.6 0.2196];
            app.SelectFromFileExplorerButton_2.FontSize = 13;
            app.SelectFromFileExplorerButton_2.FontWeight = 'bold';
            app.SelectFromFileExplorerButton_2.Layout.Row = 1;
            app.SelectFromFileExplorerButton_2.Layout.Column = 1;
            app.SelectFromFileExplorerButton_2.Text = 'Select From File Explorer';

            % Create Lamp_3
            app.Lamp_3 = uilamp(app.ConfigurationFileManagerPanel);
            app.Lamp_3.Tag = 'FEBioFileLamp';
            app.Lamp_3.Position = [261 88 19 19];
            app.Lamp_3.Color = [0.9294 0.6902 0.1294];

            % Create PlotManagerPanel
            app.PlotManagerPanel = uipanel(app.UIFigure);
            app.PlotManagerPanel.TitlePosition = 'centertop';
            app.PlotManagerPanel.Title = 'Plot Manager';
            app.PlotManagerPanel.BackgroundColor = [0.902 0.902 0.902];
            app.PlotManagerPanel.FontWeight = 'bold';
            app.PlotManagerPanel.Scrollable = 'on';
            app.PlotManagerPanel.FontSize = 15;
            app.PlotManagerPanel.Position = [11 10 290 200];

            % Create GridLayout52
            app.GridLayout52 = uigridlayout(app.PlotManagerPanel);
            app.GridLayout52.RowHeight = {'1x', '0.2x'};
            app.GridLayout52.ColumnSpacing = 5;
            app.GridLayout52.Padding = [5 5 5 5];

            % Create GridLayout53
            app.GridLayout53 = uigridlayout(app.GridLayout52);
            app.GridLayout53.ColumnWidth = {'1x'};
            app.GridLayout53.RowHeight = {'0.2x', '1x'};
            app.GridLayout53.ColumnSpacing = 5;
            app.GridLayout53.RowSpacing = 5;
            app.GridLayout53.Padding = [10 5 10 0];
            app.GridLayout53.Layout.Row = 1;
            app.GridLayout53.Layout.Column = 1;

            % Create GridLayout54
            app.GridLayout54 = uigridlayout(app.GridLayout53);
            app.GridLayout54.ColumnWidth = {'1x'};
            app.GridLayout54.RowHeight = {'1x', '1x', '1x', '1x'};
            app.GridLayout54.ColumnSpacing = 5;
            app.GridLayout54.RowSpacing = 5;
            app.GridLayout54.Padding = [0 0 0 0];
            app.GridLayout54.Layout.Row = 2;
            app.GridLayout54.Layout.Column = 1;

            % Create CenterlineButton
            app.CenterlineButton = uibutton(app.GridLayout54, 'state');
            app.CenterlineButton.Enable = 'off';
            app.CenterlineButton.Text = 'Centerline';
            app.CenterlineButton.Layout.Row = 1;
            app.CenterlineButton.Layout.Column = 1;

            % Create VHIVUSDataButton
            app.VHIVUSDataButton = uibutton(app.GridLayout54, 'state');
            app.VHIVUSDataButton.Enable = 'off';
            app.VHIVUSDataButton.Text = 'VH-IVUS Data';
            app.VHIVUSDataButton.Layout.Row = 2;
            app.VHIVUSDataButton.Layout.Column = 1;

            % Create SurfaceMeshButton
            app.SurfaceMeshButton = uibutton(app.GridLayout54, 'state');
            app.SurfaceMeshButton.Enable = 'off';
            app.SurfaceMeshButton.Text = 'Surface Mesh';
            app.SurfaceMeshButton.Layout.Row = 3;
            app.SurfaceMeshButton.Layout.Column = 1;

            % Create VolumetricMeshButton
            app.VolumetricMeshButton = uibutton(app.GridLayout54, 'state');
            app.VolumetricMeshButton.Enable = 'off';
            app.VolumetricMeshButton.Text = 'Volumetric Mesh';
            app.VolumetricMeshButton.Layout.Row = 4;
            app.VolumetricMeshButton.Layout.Column = 1;

            % Create ObjectsInPlotLabel
            app.ObjectsInPlotLabel = uilabel(app.GridLayout53);
            app.ObjectsInPlotLabel.HorizontalAlignment = 'center';
            app.ObjectsInPlotLabel.FontWeight = 'bold';
            app.ObjectsInPlotLabel.Layout.Row = 1;
            app.ObjectsInPlotLabel.Layout.Column = 1;
            app.ObjectsInPlotLabel.Text = 'Objects In Plot';

            % Create GridLayout55
            app.GridLayout55 = uigridlayout(app.GridLayout52);
            app.GridLayout55.ColumnWidth = {'1x'};
            app.GridLayout55.RowHeight = {'0.2x', '1x'};
            app.GridLayout55.ColumnSpacing = 5;
            app.GridLayout55.RowSpacing = 5;
            app.GridLayout55.Padding = [5 0 5 0];
            app.GridLayout55.Layout.Row = 1;
            app.GridLayout55.Layout.Column = 2;

            % Create GridLayout56
            app.GridLayout56 = uigridlayout(app.GridLayout55);
            app.GridLayout56.ColumnWidth = {'1x'};
            app.GridLayout56.RowHeight = {'1x', '1x', '1x', '1x'};
            app.GridLayout56.ColumnSpacing = 5;
            app.GridLayout56.RowSpacing = 5;
            app.GridLayout56.Padding = [5 5 5 5];
            app.GridLayout56.Layout.Row = 2;
            app.GridLayout56.Layout.Column = 1;

            % Create DaspectButton
            app.DaspectButton = uibutton(app.GridLayout56, 'state');
            app.DaspectButton.Text = 'Daspect';
            app.DaspectButton.Layout.Row = 1;
            app.DaspectButton.Layout.Column = 1;
            app.DaspectButton.Value = true;

            % Create AxisButton_2
            app.AxisButton_2 = uibutton(app.GridLayout56, 'state');
            app.AxisButton_2.Text = 'Axis';
            app.AxisButton_2.Layout.Row = 2;
            app.AxisButton_2.Layout.Column = 1;
            app.AxisButton_2.Value = true;

            % Create GridLayout57
            app.GridLayout57 = uigridlayout(app.GridLayout56);
            app.GridLayout57.ColumnWidth = {'0.5x', '1x'};
            app.GridLayout57.RowHeight = {'1x'};
            app.GridLayout57.ColumnSpacing = 5;
            app.GridLayout57.RowSpacing = 0;
            app.GridLayout57.Padding = [0 0 0 0];
            app.GridLayout57.Layout.Row = 4;
            app.GridLayout57.Layout.Column = 1;

            % Create TitleEditFieldLabel
            app.TitleEditFieldLabel = uilabel(app.GridLayout57);
            app.TitleEditFieldLabel.HorizontalAlignment = 'center';
            app.TitleEditFieldLabel.Layout.Row = 1;
            app.TitleEditFieldLabel.Layout.Column = 1;
            app.TitleEditFieldLabel.Text = 'Title';

            % Create TitleEditField
            app.TitleEditField = uieditfield(app.GridLayout57, 'text');
            app.TitleEditField.Layout.Row = 1;
            app.TitleEditField.Layout.Column = 2;

            % Create GridButton
            app.GridButton = uibutton(app.GridLayout56, 'state');
            app.GridButton.Text = 'Grid';
            app.GridButton.Layout.Row = 3;
            app.GridButton.Layout.Column = 1;
            app.GridButton.Value = true;

            % Create SettingsLabel
            app.SettingsLabel = uilabel(app.GridLayout55);
            app.SettingsLabel.HorizontalAlignment = 'center';
            app.SettingsLabel.FontWeight = 'bold';
            app.SettingsLabel.Layout.Row = 1;
            app.SettingsLabel.Layout.Column = 1;
            app.SettingsLabel.Text = 'Settings';

            % Create UpdateFigureButton
            app.UpdateFigureButton = uibutton(app.GridLayout52, 'push');
            app.UpdateFigureButton.ButtonPushedFcn = createCallbackFcn(app, @UpdateFigureButtonPushed, true);
            app.UpdateFigureButton.BackgroundColor = [0.1608 0.6 0.2196];
            app.UpdateFigureButton.FontSize = 13;
            app.UpdateFigureButton.FontWeight = 'bold';
            app.UpdateFigureButton.Layout.Row = 2;
            app.UpdateFigureButton.Layout.Column = 1;
            app.UpdateFigureButton.Text = 'Update Figure';

            % Create ClearFigureButton
            app.ClearFigureButton = uibutton(app.GridLayout52, 'push');
            app.ClearFigureButton.ButtonPushedFcn = createCallbackFcn(app, @ClearFigureButtonPushed, true);
            app.ClearFigureButton.BackgroundColor = [0.9294 0.6941 0.1255];
            app.ClearFigureButton.FontSize = 13;
            app.ClearFigureButton.FontWeight = 'bold';
            app.ClearFigureButton.Layout.Row = 2;
            app.ClearFigureButton.Layout.Column = 2;
            app.ClearFigureButton.Text = 'Clear Figure';

            % Create UniversityofTexasatDallasVascularMechanobiologyLabLabel
            app.UniversityofTexasatDallasVascularMechanobiologyLabLabel = uilabel(app.UIFigure);
            app.UniversityofTexasatDallasVascularMechanobiologyLabLabel.FontSize = 15;
            app.UniversityofTexasatDallasVascularMechanobiologyLabLabel.Position = [373 609 206 34];
            app.UniversityofTexasatDallasVascularMechanobiologyLabLabel.Text = {'University of Texas at Dallas'; 'Vascular Mechanobiology Lab'};

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.Enable = 'off';
            app.Label.Visible = 'off';
            app.Label.Position = [1 0 650 710];
            app.Label.Text = '';

            % Create ERRORPanel
            app.ERRORPanel = uipanel(app.UIFigure);
            app.ERRORPanel.ForegroundColor = [1 1 1];
            app.ERRORPanel.TitlePosition = 'centertop';
            app.ERRORPanel.Title = 'ERROR';
            app.ERRORPanel.Visible = 'off';
            app.ERRORPanel.BackgroundColor = [0.8314 0 0];
            app.ERRORPanel.FontWeight = 'bold';
            app.ERRORPanel.FontSize = 15;
            app.ERRORPanel.Position = [151 300 330 130];

            % Create GridLayout48
            app.GridLayout48 = uigridlayout(app.ERRORPanel);
            app.GridLayout48.ColumnWidth = {'1x'};
            app.GridLayout48.RowHeight = {'1x', '0.5x'};
            app.GridLayout48.ColumnSpacing = 5;
            app.GridLayout48.RowSpacing = 5;
            app.GridLayout48.Padding = [5 5 5 5];

            % Create ERRORMESSAGELabel
            app.ERRORMESSAGELabel = uilabel(app.GridLayout48);
            app.ERRORMESSAGELabel.HorizontalAlignment = 'center';
            app.ERRORMESSAGELabel.FontSize = 13;
            app.ERRORMESSAGELabel.FontWeight = 'bold';
            app.ERRORMESSAGELabel.FontColor = [1 1 1];
            app.ERRORMESSAGELabel.Layout.Row = 1;
            app.ERRORMESSAGELabel.Layout.Column = 1;
            app.ERRORMESSAGELabel.Text = 'ERROR MESSAGE';

            % Create GridLayout49
            app.GridLayout49 = uigridlayout(app.GridLayout48);
            app.GridLayout49.ColumnWidth = {'0.5x', '0.5x', '1x'};
            app.GridLayout49.RowHeight = {'1x'};
            app.GridLayout49.ColumnSpacing = 5;
            app.GridLayout49.RowSpacing = 5;
            app.GridLayout49.Padding = [5 5 5 5];
            app.GridLayout49.Layout.Row = 2;
            app.GridLayout49.Layout.Column = 1;

            % Create ReturnButton
            app.ReturnButton = uibutton(app.GridLayout49, 'push');
            app.ReturnButton.ButtonPushedFcn = createCallbackFcn(app, @ClearErrorPanel, true);
            app.ReturnButton.BackgroundColor = [0.502 0.502 0.502];
            app.ReturnButton.FontWeight = 'bold';
            app.ReturnButton.FontColor = [1 1 1];
            app.ReturnButton.Layout.Row = 1;
            app.ReturnButton.Layout.Column = 3;
            app.ReturnButton.Text = 'Return';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = VHIVUSArteryMeshReconstructionApp

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end