function plotTetMesh(mesh,steps,lights,axlab)
optionStruct.numSliceSteps=steps; %Number of animation steps
optionStruct.cutDir=1;
optionStruct.cutSide=1;
optionStruct.faceAlpha1 = 0.2;
optionStruct.faceAlpha2 = 1;
meshView(mesh,optionStruct);
if lights==0
    delete(findall(gcf,'Type','light')); % in Future's voice, "TURN OFF THE LIGHTS!"
end
if axlab==0
    axis off
end
end