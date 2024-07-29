function class=Detect_eyedirection(oldX,X,Pclass,B,sigma,Mid_c)
%x is row, y is column ,
w=B(1,3);
h=B(1,4);
oldX=remove_lefteye(oldX,Mid_c);
X=remove_lefteye(X,Mid_c);
p_X=mean(oldX, 2);
X_mean=mean(X, 2);
y=X_mean(2,:);
x=X_mean(1,:);
py=p_X(2,:);
px=p_X(1,:);
dy=y-py;
dx=x-px;
sigmax=(h/3)*sigma;
sigmay=(w/3)*sigma;

M=detect_movement(dx,dy,sigmax,sigmay);

switch Pclass
    
    case 1
        switch M
            case 6
                class=2;
            case 9
                class=5;
            case 8
                class=4;
            otherwise
                class=pclass;
        end
        
    case 2
        switch M
            case 4
                class=1;
            case 7
                class=4;
            case 8
                class=5;
            case 9
                class=6;
            case 6
                class=3;
            otherwise
                class=pclass;
        end
        
    case 3
        switch M
            case 4
                class=2;
            case 7
                class=5;
            case 8
                class=6;
            otherwise
                class=pclass;
        end
        
    case 4
        switch M
            case 2
                class=1;
            case 3
                class=2;
            case 6
                class=5;
            case 9
                class=8;
            case 8
                class=7;
            otherwise
                class=pclass;
        end
        
        
    case 5
        
        class=M;
        
    case 6
        switch M
            case 2
                class=3;
            case 1
                class=4;
            case 4
                class=5;
            case 7
                class=8;
            case 8
                class=9;
            otherwise
                class=pclass;
        end
        
        
    case 7
        switch M
            case 2
                class=4;
            case 3
                class=5;
            case 6
                class=8;
                
            otherwise
                class=pclass;
        end
        
        
    case 8
        switch M
            case 4
                class=7;
            case 1
                class=4;
            case 2
                class=5;
            case 3
                class=6;
            case 6
                class=9;
            otherwise
                class=pclass;
        end
        
    otherwise
        switch M
            case 2
                class=6;
            case 1
                class=5;
            case 4
                class=8;
            otherwise
                class=pclass;
        end
        
        
end