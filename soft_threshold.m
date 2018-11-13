function y = soft_threshold(x, r)
    assert(r>=0);
    
    if r > 0
        if (x > r)
            y = x - r;
            
        elseif (x < -r)
            
            y = x +r;
            
        else
            
            y = 0;
            
            
        end
        
    else
        
        y = x;
        
    end

end