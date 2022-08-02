function [id_vol_mins, id_vol_maxs, id_vol_means, id_vols, id_names] = getVolumeStatsByID(tets, geom_opts)
% compute each element's volume
tet_vols = getElementVolumes(tets.elements, tets.nodes);
total_vol = sum(tet_vols);

% create storage for material types
E_id_unique = unique(tets.elementMaterialID);
id_vols=zeros(length(E_id_unique),2);
id_vols(:,1)=E_id_unique;
id_vol_mins=zeros(length(E_id_unique),1);
id_vol_maxs=zeros(length(E_id_unique),1);
id_vol_means=zeros(length(E_id_unique),1);

% get the volume for each material type
for i=1:length(E_id_unique)
    id_vols(i,2)=sum(tet_vols(tets.elementMaterialID == E_id_unique(i)))/total_vol*100;
    id_vol_mins(i)=min(tet_vols(tets.elementMaterialID == E_id_unique(i)));
    id_vol_maxs(i)=max(tet_vols(tets.elementMaterialID == E_id_unique(i)));
    id_vol_means(i)=mean(tet_vols(tets.elementMaterialID == E_id_unique(i)));
end

% get names of each material id
id_names = getMatNamesByID(tets, geom_opts);
end