function [E]=SIR(E,weights)
% SIR
% each row as a vector;
outIndex = zeros(size(weights));
N=length(weights);
w=cumsum(weights);
Et=zeros(size(E));
bin=1/N*rand(1)+1/N*(0:N-1);idx=1;
for t=1:N
while bin(t)>=w(idx)
idx=idx+1;
end
outIndex(t) = idx;
Et(:,t)=E(:,idx);
end
E=Et;

% ------------