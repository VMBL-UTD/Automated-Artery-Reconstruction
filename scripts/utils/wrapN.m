% From: https://www.mathworks.com/matlabcentral/answers/44993
% Can also be defined via:
% wrapN = @(x, N) (1 + mod(x-1, N));
% wrapN(5,4) = 1
% wrapN(6,4) = 2
function [nout] = wrapN(x,n)
nout =  (1 + mod(x-1,n));
end