function N=remove_lefteye(x,m)
s=size(x);
j=0;
for i=1:s(2)
    if x(2,i)>m
        j=j+1;
        N(:,j)=x(:,i);
    end
end


