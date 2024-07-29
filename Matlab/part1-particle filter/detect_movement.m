function d=detect_movement(dx,dy,sigmax,sigmay)
if abs(dx)>=sigmax
    if abs(dy)>=sigmay
        if dx<0 
            if dy<0
            d=1;
            else
            d=3;
            end
        else
            if dy<0
                d=7;
            else
                d=9;
            end
        end
        
    else
        if dx<0
            d=2;
        else
            d=8;
        end
    end
    
else
        if abs(dy)>=sigmay
            if dy<0
                d=4;
            else
                d=6;
            end
        else
            d=5;
        end
end

                
            
               
    
    
    
    