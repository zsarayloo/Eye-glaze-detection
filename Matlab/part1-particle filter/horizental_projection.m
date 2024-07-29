function H=horizental_projection(I)
S=size(I);
H=zeros(S(1),1);
for i=1:S(1)
    temp=I(i,:);
    H(i,1)=sum(temp);
end

    