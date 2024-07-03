function error = inputChecking(idx_L, idx_R)
%this function checks errors in input's contents
% 2 represents negative values in L
% 3 represents negative values in R
% 4 represents non-integer values in L
% 5 represents non-integer values in R
    if any(idx_L < 0)
        error = 2;
    elseif any(idx_R < 0)
        error = 3;
    elseif ~(isnumeric(idx_L))
        error = 4;
    elseif ~(isnumeric(idx_R))
        error = 5;
    else
        error = 0;
    end
end