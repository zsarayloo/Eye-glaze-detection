function L=find_location_peak(p,v)
sv=size(v);
s=size(p);
k=0;
z=0;
T=[];
for i=1:s(end)
    location=find(v==p(i));
    sl=size(location);
    if (sl(1)*sl(2))==1
        k=k+1;
        L(k)=location;
    else
        for j=1:length(sl)
            t=location(j);
            if t==1
                temp1=v(t);
            else
                temp1=v(t-1);
            end
            
            if t==sv(end)
                temp2=v(t);
            else
                temp2=v(t+1);
            end
            
            if temp1<v(t)  && temp2<v(t)
                z=z+1;
                T(z)=t;
                break;
            elseif temp1<v(t)  && temp2<=v(t)
                z=z+1;
                T(z)=t;
            elseif temp1<=v(t)  && temp2<v(t)
                z=z+1;
                T(z)=t;
                
            end
        end
        st=size(T);
        if st(1)==0
            z=0;
            k=k+1;
            L(k)=max(t);
        else
        z=0
        k=k+1;
        L(k)=max(T);
        end
        
    end
end




