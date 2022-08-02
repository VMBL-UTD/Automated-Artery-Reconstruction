function [names] = getMatNamesByID(tets, geom_opts)
% only materials in tetmesh
ids = unique(tets.elementMaterialID);

% all materials
mats = struct2cell(geom_opts.mats);
mat_names = fieldnames(geom_opts.mats);

% get the name of each material in 'ids'
names = cell(length(ids), 1);
for i=1:length(ids)
    names{i} = mat_names{mats{ids(i)}.id};
end
names = string(names);
end