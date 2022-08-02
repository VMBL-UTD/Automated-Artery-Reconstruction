% Example:
% P = [292   196   -56;
%    280   153    75;
%    321   140   140;
%    356   148   248];
% 
% Q3D=Bezier(P,10);
% 
% figure
% plot3(Q3D(:,1),Q3D(:,2),Q3D(:,3),'b','LineWidth',2),
% hold on
% plot3(P(:,1),P(:,2),P(:,3),'g:','LineWidth',2)        % plot control polygon
% plot3(P(:,1),P(:,2),P(:,3),'ro','LineWidth',2)     % plot control points
% view(3);
% box;

% Modified from: https://www.mathworks.com/matlabcentral/fileexchange/35154-3d-bezier-curve
function Q=bezier(P,num_points)
t=linspace(0,1,num_points);
Q = zeros(length(t),3);
for k=1:length(t)
    Q(k,:)=[0 0 0]';
    for j=1:size(P,1)
        Q(k,:)=Q(k,:)+P(j,:)*Bernstein(size(P,1)-1,j-1,t(k));
    end
end
end
 
function B=Bernstein(n,j,t)
    B=factorial(n)/(factorial(j)*factorial(n-j))*(t^j)*(1-t)^(n-j);
end