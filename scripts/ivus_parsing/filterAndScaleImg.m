%{
Custom function to filter noise from VH-IVUS images and 
extract the pixels of interest from a single ivus image

Returns a struct 'pixels' that contains:
    -> pixel type
    -> pixel coordinates cartesian
    -> pixel coordinates polar
%}
function [pixels] = filterAndScaleImg(img, mesh_config)
% Define the center of the image
origin = round(size(img,[1,2])/2);

%% FILTER IMAGE
% Isolate R, G, B arrays from tif image
imgR = img(:,:,1);
imgG = img(:,:,2);
imgB = img(:,:,3);

% create mask for necrotic, fibrofatty, and fibrotic
mask_b = imgR==mesh_config.ivus.necrotic.c(1) & imgG==mesh_config.ivus.necrotic.c(2) & imgB==mesh_config.ivus.necrotic.c(3) ...
    | imgR==mesh_config.ivus.fibrotic.c(1) & imgG==mesh_config.ivus.fibrotic.c(2) & imgB==mesh_config.ivus.fibrotic.c(3)...
    | imgR==mesh_config.ivus.fibrofatty.c(1) & imgG==mesh_config.ivus.fibrofatty.c(2) & imgB==mesh_config.ivus.fibrofatty.c(3);

% create mask for arterial pixels and remove isolated pixel groups
mask_a = imgR==mesh_config.ivus.artery.c(1) & imgG==mesh_config.ivus.artery.c(2) & imgB==mesh_config.ivus.artery.c(3);
mask_a = any(uint8(255*mat2gray(double(bwareaopen(applyMask(uint8(255*mask_a),ones(size(img)),0),2500)))),3);

% create mask for calcium pixels and remove isolated pixel groups
mask_c = imgR==mesh_config.ivus.calcium.c(1) & imgG==mesh_config.ivus.calcium.c(2) & imgB==mesh_config.ivus.calcium.c(3);
mask_bc1 = any(uint8(255*mat2gray(double(bwareaopen(applyMask(uint8(255*(mask_b | mask_c)),ones(size(img)),0),500)))),3);
mask_bc2 = any(uint8(255*mat2gray(double(bwareaopen(applyMask(uint8(255*(mask_b | mask_c)),ones(size(img)),0),4000)))),3);
mask_bc = mask_bc1 & mask_bc2;

% create final mask
mask_final = mask_b | mask_a | mask_bc;
mask_final = any(uint8(255*mat2gray(double(bwareaopen(applyMask(uint8(255*mask_final),ones(size(img)),0),5000)))),3);
img_final = applyMask(mask_final,img,0);

% separate RGB values
R = img_final(:,:,1);
G = img_final(:,:,2);
B = img_final(:,:,3);

%% EXTRACT PIXEL MATERIALS
% get grey pixels
arterial_pix = double(and(and(R==mesh_config.ivus.artery.c(1),G==mesh_config.ivus.artery.c(2)),B==mesh_config.ivus.artery.c(3)));

% get dark green pixels
fibrotic_pix = double(and(and(R==mesh_config.ivus.fibrotic.c(1),G==mesh_config.ivus.fibrotic.c(2)),B==mesh_config.ivus.fibrotic.c(3)));

% get light green pixels     
fibrofatty_pix = double(and(and(R==mesh_config.ivus.fibrofatty.c(1),G==mesh_config.ivus.fibrofatty.c(2)), B==mesh_config.ivus.fibrofatty.c(3)));

% get white pixels     
calcium_pix = double(and(and(R==mesh_config.ivus.calcium.c(1),G==mesh_config.ivus.calcium.c(2)), B==mesh_config.ivus.calcium.c(3)));

% get red pixels     
necrotic_pix = double(and(and(R==mesh_config.ivus.necrotic.c(1),G==mesh_config.ivus.necrotic.c(2)), B==mesh_config.ivus.necrotic.c(3)));

% combine pixels
combined_pixels = mesh_config.mats.fibrotic.id*fibrotic_pix + mesh_config.mats.artery.id*arterial_pix +...
    mesh_config.mats.fibrofatty.id*fibrofatty_pix + mesh_config.mats.necrotic.id*necrotic_pix +...
    mesh_config.mats.calcium.id*calcium_pix;
[pixel_i, pixel_j] = find(combined_pixels > 0);

% store pixel type
pixels.type = combined_pixels(combined_pixels>0);

% compute and store cartesian pixel coordinates
pixels.cart = [(pixel_j-origin(1))*mesh_config.ivus.pixel_scale, -(pixel_i-origin(2))*mesh_config.ivus.pixel_scale];

% compute and store polar pixel coordinates
pixels.pol = zeros(length(pixels.cart),2);
[pixels.pol(:,1), pixels.pol(:,2)] = cart2pol(pixels.cart(:,1), pixels.cart(:,2));
end

function [A_out] = applyMask(mask,A,pl)
A = uint8(A);
mask = uint8(mask);

A_out = uint8(zeros(size(A)));

A_out(:,:,1) = A(:,:,1).*mask;
A_out(:,:,2) = A(:,:,2).*mask;
A_out(:,:,3) = A(:,:,3).*mask;

if pl
figure;
imshow(A_out);
end
end