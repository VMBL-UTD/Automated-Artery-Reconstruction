function [Fc,Vc,tetsc] = generateFluidMesh(tets, outlet_vecs, geom_opts)
% Invert the normals of the lumen surface
[Fc,Vc] = patchCleanUnused(fliplr(tets.facesBoundary(tets.surfs.lumen.F,:)), tets.nodes);

Et = patchBoundary(Fc);

% Separate edge boundary into groups for each end cap
optionStruct.outputType='label';
nodeGroups = tesgroup(Et,optionStruct);
vInds = zeros(size(nodeGroups,1),1);

for i=1:length(unique(nodeGroups))
    % Get nodes on current edge boundary group
    edgeNodes = edgeListToCurve(Et(nodeGroups==i,:));
    edgeNodes = edgeNodes(1:end-1);
    vInds(nodeGroups==i) = edgeNodes;
    nlen = length(edgeNodes);
    
    % Calculate mean coordinate
    centerv = mean(Vc(edgeNodes,:),1);
    
    % See if we need multiple inward lofts to match resample rate
    v = centerv - Vc(edgeNodes,:);
    nodedists = sqrt(sum(v.^2,2));
    nodenorms = v./nodedists;
    n = floor(mean(nodedists./geom_opts.resample));
    
    % Create new faces and nodes
    Vn = Vc(edgeNodes,:);
    vi = (1:nlen);
    Fn = [];
    if n>1
        cPar.closeLoopOpt=1;
        cPar.patchType='tri_slash';
        cPar.numSteps = n;
        [Fn,Vn] = polyLoftLinear(Vc(edgeNodes,:),Vc(edgeNodes,:) + nodenorms.*((nodedists./n).*(n-1)),cPar);
        vi = (n:n:size(Vn,1));
    end
    Vo = [Vn;centerv];
    Fo = [Fn;[vi' vi(wrapN((2:nlen+1),nlen))' ones(nlen,1)*size(Vo,1)]];
    
    [Fc,Vc] = joinElementSets({Fc,Fo},{Vc,Vo});
end
[Fc,Vc] = mergeVertices(Fc,Vc);

% Tetrahedralize mesh
edgeLen = mean(patchEdgeLengths(Fc,Vc));
[tetsc] = customTETGEN(Fc,Vc, edgeLen);
tetsc.elementMaterialID = zeros(size(tetsc.elements,1),1);
% tetsc.surfs = sepSurfsAny(tetsc.facesBoundary,tetsc.nodes,layers);
tetsc.surfs = separateMeshSurfacesNew(Fc,Vc,outlet_vecs.xyz,outlet_vecs.uvw,0.1);

% tetsc.facesBoundary(tetsc.surfs.lumen.F,:) = fliplr(tetsc.facesBoundary(tetsc.surfs.lumen.F,:));
end