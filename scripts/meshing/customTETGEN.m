%{
Function to run TETGEN with customized inputs for arterial geometry
Input Arguments:
    F -> Faces of artery surface geometry
    V -> Vertices of artery surface geometry
    opts -> struct containing options and parameters for geometry specified at beginning
        of IVUS_to_FEA2
Outputs:
    tets -> struct containing the output from TETGEN tetrahedralizing mesh
        tets.nodes -> nodes in tet mesh
        tets.facesBoundary -> face boundaries in tet mesh (for visualizing)
        tets.boundaryMarker -> markers for face boundaries (for visualizing)
        tets.faces -> faces of the tet elements(for visualizing)
        tets.elements -> tetrahedral elements
        tets.elementMaterialID -> material IDs for each element
        tets.faceMaterialID -> material IDs for each tet face
        tets.loadNameStruct -> residual directories where TETGEN originally stored the outputs
%}
function [tets] = customTETGEN(F,V,edgeLen)
s = sprintf('-pqa%.8fYQ',edgeLen^3/(6*sqrt(2))); % Calculate optimal tetrahedral volume using edge length
inputStruct.Faces=F;
inputStruct.Nodes=V;
inputStruct.holePoints=[];
inputStruct.faceBoundaryMarker=ones(size(F,1),1); %Face boundary markers
inputStruct.regionPoints=[]; %region points
inputStruct.stringOpt=s;
[tets]=runTetGen(inputStruct); %Run tetGen

tets.element_centers  = getCentroids(tets.nodes, tets.elements);   % compute centroids of elements
end