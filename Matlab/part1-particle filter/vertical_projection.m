function H=vertical_projection(I)
S=size(I);
H=zeros(1,S(2));
for i=1:S(2)
    temp=I(:,i);
    H(1,i)=sum(temp);
end