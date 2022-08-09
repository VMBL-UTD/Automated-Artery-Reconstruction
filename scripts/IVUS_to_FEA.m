close all;
clear;
clc;


%% Setup
[mesh_config, feb_config] = parseSingleConfig("config.ini");
% [mesh_config] = parseMeshConfig("mesh_config.ini");
% [feb_config] = parseFEBioConfig("febio_config.ini");


%% Read in centerline
[cline] = getCenterline(mesh_config);


%% Image Filtering and Tissue Parsing
fprintf('Reading IVUS images\n');
[layers, isbranched] = getIVUSLayers(mesh_config, cline);


%% Initial Geometry Creation
fprintf('\nCreating Mesh\n');
[F,V,tets,outlet_vecs] = generateSurfaceMesh(layers,mesh_config,isbranched);


%% Assign materials
fprintf("\nAssigning Materials to %d Elements\n",length(tets.elements));
[tets] = assignMaterialsLayers(tets,layers);


%% Write .feb file
fprintf('\nWriting .feb file\n');
febio_feb = generateFEbioInputFile(F, tets.surfs, tets, mesh_config, feb_config);
