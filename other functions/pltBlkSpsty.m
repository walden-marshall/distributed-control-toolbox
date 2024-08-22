function pltBlkSpsty(M,blk_row_szs,blk_col_szs)
%pltBlkSpsty Plot the block sparsity structure of matrix M.
%   Uses Matlab native spy() with the addition of lines to show desired
%   block sizes, prescribed by blk_row_szs and blk_col_sizes

    row_cumsum = cumsum(blk_row_szs); col_cumsum = cumsum(blk_col_szs);
    
    %input checking
    row_sz_crct = true; col_sz_crct = true;
    if row_cumsum(end) ~= size(M,1)
        row_sz_crct = false;
    end
    if col_cumsum(end) ~= size(M,2)
        col_sz_crct = false;
    end
    if not(or(row_sz_crct,col_sz_crct))
        error('neither row or column index sets match with the dimensions of M')
    elseif not(row_sz_crct)
        error('row index set does not match with dimensions of M')
    elseif not(col_sz_crct)
        error('column index set does not match with dimensions of M')
    end

    hold on
    spy(M)
    for i = 1:length(row_cumsum)-1
        yline(row_cumsum(i)+0.5) %might be nice to show empty blocks
    end
    for j = 1:length(col_cumsum)-1
        xline(col_cumsum(j)+0.5) %might be nice to show empty blocks
    end
    hold off
    xticks(1:size(M,2)); yticks(1:size(M,1));
    xlabel('Column Index'); ylabel('Row Index');
    title('Sparsity Pattern')
end
