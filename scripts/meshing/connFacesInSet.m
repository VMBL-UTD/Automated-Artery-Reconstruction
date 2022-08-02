function [face_groups] = connFacesInSet(fin,C)
parsed_faces = zeros(length(fin),1);
face_groups = zeros(length(fin),1);
group_count=1;
while sum(parsed_faces)~=length(parsed_faces)
    f = fin(find(parsed_faces==0,1));
    conn_f=f;
    len_conn=0;
    while(len_conn<length(conn_f))
        len_conn=length(conn_f);
        flist = unique([reshape(C(conn_f,:).',[],1); f]);   % get unique list of faces connected to faces in conn
        conn_f = flist(ismember(flist,fin));               % get the members of f in fin
    end
    fi = ismember(fin,conn_f);
    parsed_faces(fi) = 1;
    face_groups(fi) = group_count;
    group_count = group_count+1;
end
end