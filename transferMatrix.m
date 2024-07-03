function tMatrix = transferMatrix(idx_set_L, idx_set_R)
    isBlockSquare = ( length(idx_set_L) == length(idx_set_R) );
    check = inputChecking(idx_set_L, idx_set_R);
    if isBlockSquare == 0
        fprintf("T matrix is not block square.")
    elseif ~(isvector(idx_set_L) && isvector(idx_set_R))
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
        lenL = length(idx_set_L);
        lenR = length(idx_set_R);
        size = lenL + lenR;
        tMatrix = zeros(size,size);
        tMatrix(1,1) = 1;
        
        iL = 2;
        iR = 1;
        r = lenL + 1;
        x = 2;
        
        while iL <= lenL || iR < lenR
            if mod(x,2) == 1 && iL <= lenL
                tMatrix(x, iL) = 1;
                iL = iL + 1;
            elseif mod(x,2) == 0 && iR < lenR
                tMatrix(x, r) = 1;
                iR = iR + 1;
                r = r + 1;
            end
            x = x + 1;
        end
        tMatrix(size,size) = 1;
    end
end