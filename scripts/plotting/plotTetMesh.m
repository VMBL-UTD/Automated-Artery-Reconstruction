function [fig] = plotTetMesh(tets,mesh_config,steps,lights,axlab)
optionStruct.numSliceSteps=steps; %Number of animation steps
optionStruct.cutDir=1;
optionStruct.cutSide=1;
optionStruct.faceAlpha1 = 0.2;
optionStruct.faceAlpha2 = 1;

% optionStruct.cMap=[];
cnames = fieldnames(mesh_config.mats);
egroups = unique(tets.elementMaterialID);
legnames = cell(size(egroups,1));
colors = zeros(size(egroups,1),3);
ni = 1;
for i=1:size(egroups,1)
    for j=1:size(cnames,1)
        if mesh_config.mats.(cnames{j}).id == i
            colors(ni,:) = mesh_config.ivus.(cnames{j}).c/255;
            legnames{ni} = cnames{j};
            ni=ni+1;
            break
        end
    end
end
optionStruct.cMap = colors;
fig = meshView(tets,optionStruct);

if lights==0
    delete(findall(gcf,'Type','light')); % in Future's voice, "TURN OFF THE LIGHTS!"
end
if axlab==0
    axis off
end

end