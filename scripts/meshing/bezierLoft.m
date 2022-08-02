function [F,V,X,Y,Z]=bezierLoft(P1,P4,N1,N4,pointSpacing,f)

D12=sqrt(sum((P1-P4).^2,2));
numPoints=ceil(max(D12)./pointSpacing);
if numPoints<2
    numPoints=2;
end

P2=P1+D12.*f.*N1;
P3=P4-D12.*f.*N4;

X=zeros(numPoints,size(P1,1));
Y=zeros(numPoints,size(P1,1));
Z=zeros(numPoints,size(P1,1));
for q=1:1:size(P1,1)
    p=[P1(q,:); P2(q,:); P3(q,:); P4(q,:)]; %Control points
    V_bezier=bezierCurve(p,numPoints*2); %Compute bezier curve
    V_bezier=evenlySampleCurve(V_bezier,numPoints,'pchip'); %resample evenly
    X(:,q)=V_bezier(:,1);
    Y(:,q)=V_bezier(:,2);
    Z(:,q)=V_bezier(:,3);
end

%Create quad patch data
[F,V,~] = surf2patch(X,Y,Z);
I=[(1:size(Z,1)-1)' (1:size(Z,1)-1)' (2:size(Z,1))' (2:size(Z,1))' ];
J=[size(Z,2).*ones(size(Z,1)-1,1) ones(size(Z,1)-1,1) ones(size(Z,1)-1,1) size(Z,2).*ones(size(Z,1)-1,1)];
F_sub=sub2ind(size(Z),I,J);
F=[F;F_sub];
F=fliplr(F);

% Convert to tri
[F,V,~] = quad2tri(F,V,'f');
end