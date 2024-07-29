function bbox=Generate_patch(I,m,n)
S=size(I);
M=floor(S(1)/m);
N=floor(S(2)/n);
k=m*n;

x=1;
y=1;
z=0;
for i=1:m
    for j=1:n
        z=z+1;
        bbox(z,:)=[y,x,N,M];
        y=y+N;
    end
    x=x+M;
    y=1;
end









