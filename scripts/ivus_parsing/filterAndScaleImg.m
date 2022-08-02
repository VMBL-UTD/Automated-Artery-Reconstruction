%{
Custom function to filter noise from VH-IVUS images and 
extract the pixels of interest from a single ivus image

Returns a struct 'pixels' that contains:
    -> pixel type
    -> pixel coordinates cartesian
    -> pixel coordinates polar
%}
function [pixels] = filterAndScaleImg(img, mesh_config)
% define translation for pixels
trans = [250 250];

% define colors for each material type
col_arterial    =   [135 135 135];    % Arterial Wall   - Grey
col_fibrotic    =   [0   170 0  ];    % Fibrotic        - Dark Green
col_fibrofatty  =   [186 255 0  ];    % Fibrofatty      - Light Green
col_calcium     =   [255 255 255];    % Calcium         - White
col_necrotic    =   [255 0   0  ];    % Necrotic Core   - Red

%% FILTER IMAGE
% Isolate R, G, B arrays from tif image
imgR = img(:,:,1);
imgG = img(:,:,2);
imgB = img(:,:,3);

% create mask for necrotic, fibrofatty, and fibrotic
mask_b = imgR==col_necrotic(1) & imgG==col_necrotic(2) & imgB==col_necrotic(3) ...
    | imgR==col_fibrotic(1) & imgG==col_fibrotic(2) & imgB==col_fibrotic(3)...
    | imgR==col_fibrofatty(1) & imgG==col_fibrofatty(2) & imgB==col_fibrofatty(3);

% create mask for arterial pixels and remove isolated pixel groups
mask_a = imgR==col_arterial(1) & imgG==col_arterial(2) & imgB==col_arterial(3);
mask_a = any(uint8(255*mat2gray(double(bwareaopen(applyMask(uint8(255*mask_a),ones(size(img)),0),2500)))),3);

% create mask for calcium pixels and remove isolated pixel groups
mask_c = imgR==col_calcium(1) & imgG==col_calcium(2) & imgB==col_calcium(3);
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
arterial_pix = double(and(and(R==col_arterial(1),G==col_arterial(2)),B==col_arterial(3)));

% get dark green pixels
fibrotic_pix = double(and(and(R==col_fibrotic(1),G==col_fibrotic(2)),B==col_fibrotic(3)));

% get light green pixels     
fibrofatty_pix = double(and(and(R==col_fibrofatty(1),G==col_fibrofatty(2)), B==col_fibrofatty(3)));

% get white pixels     
calcium_pix = double(and(and(R==col_calcium(1),G==col_calcium(2)), B==col_calcium(3)));

% get red pixels     
necrotic_pix = double(and(and(R==col_necrotic(1),G==col_necrotic(2)), B==col_necrotic(3)));

% combine pixels
combined_pixels = mesh_config.mats.fibrotic.id*fibrotic_pix + mesh_config.mats.artery.id*arterial_pix +...
    mesh_config.mats.fibrofatty.id*fibrofatty_pix + mesh_config.mats.necrotic.id*necrotic_pix +...
    mesh_config.mats.calcium.id*calcium_pix;
[pixel_i, pixel_j] = find(combined_pixels > 0);

% store pixel type
pixels.type = combined_pixels(combined_pixels>0);

% compute and store cartesian pixel coordinates
pixels.cart = [(pixel_j-trans(1))*mesh_config.ivus.pixel_scale, -(pixel_i-trans(2))*mesh_config.ivus.pixel_scale];

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