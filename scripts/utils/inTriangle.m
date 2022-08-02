function [in] = inTriangle(P,a,b,c)
b=b-a;
c=c-a;
P=P-a;

d = b(1)*c(2) - c(1)*b(2);
wa = (P(:,1)*(b(2)*c(2)) + P(:,2)*(c(1)-b(1)) + b(1)*c(2) - c(1)*b(2))/d;
wb = (P(:,1)*c(2) - P(:,2)*c(1))/d;
wc = (P(:,2)*b(1) - P(:,1)*b(2))/d;

in = (wa>=0 & wa<=1) & (wb>=0 & wb<=1) & (wc>=0 & wc<=1);
end