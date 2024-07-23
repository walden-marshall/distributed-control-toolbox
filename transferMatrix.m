function tMatrix = transferMatrix(idx_set_Phiu, idx_set_Phix)
    isBlockSquare = ( length(idx_set_Phiu) == length(idx_set_Phix) );
    check = inputChecking(idx_set_Phiu, idx_set_Phix);
    if isBlockSquare == 0
        fprintf("T matrix is not block square.")
    elseif ~(isvector(idx_set_Phiu) && isvector(idx_set_Phix))
        fprintf("ERROR: indexed sets L and R are not vectors")
    elseif check == 2
        fprintf("ERROR: indexed set L contains negative value(s)")
    elseif check == 3
        fprintf("ERROR: indexed set R contains negative value(s)")
    elseif check == 4
        fprintf("ERROR: indexed set L contains non-integer value(s)")
    elseif check == 5
        fprintf("ERROR: indexed set R contains non-integer value(s)")
    elseif check == 0    
        lenPhiu = length(idx_set_Phiu);
        lenPhix = length(idx_set_Phix);
        size = lenPhiu + lenPhix;
        tMatrix = zeros(size,size);
        tMatrix(1,1) = 1;
        
        iu = 2;
        ix = 1;
        r = lenPhiu + 1;
        x = 2;
        
        while iu <= lenPhiu || ix < lenPhix
            if mod(x,2) == 1 && iu <= lenPhiu
                tMatrix(x, iu) = 1;
                iu = iu + 1;
            elseif mod(x,2) == 0 && ix < lenPhix
                tMatrix(x, r) = 1;
                ix = ix + 1;
                r = r + 1;
            end
            x = x + 1;
        end
        tMatrix(size,size) = 1;
    end
end