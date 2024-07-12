function [T_matrix] = generateBlocks(idx_set_L, idx_set_R)
%generates blocks based on the sizes in the indexed sets L and R

    old_idx_set = [idx_set_R;idx_set_L]; %index set of the original K realization
    new_idx_set = []; %index set of the K realization after T transformation
    for i = 1:length(idx_set_L)
        new_idx_set = [new_idx_set; idx_set_R(i)];
        new_idx_set = [new_idx_set; idx_set_L(i)];
    end
    
    block_sizes = zeros(length(new_idx_set),length(new_idx_set),2); %used to store the size of each block of T
    %populate block_sizes from old and new index sets
    for i = 1:length(new_idx_set) %rows
        for j = 1:length(old_idx_set) %cols
            num_rows = new_idx_set(i); num_cols = old_idx_set(j);
            block_sizes(i,j,:) = reshape([num_rows,num_cols],[1,1,2]); %reshaping necessary to store in a 3D array
        end
    end
    
    %loop through and put I and 0 blocks of the proper size in the proper locations
    T_matrix = [];
    for i = 1:length(new_idx_set) %rows
        T_block_row = [];
        for j = 1:length(old_idx_set) %cols
            if I_locs(i,j)
                T_block_row = [T_block_row, eye(reshape(block_sizes(i,j,:),[1,2]))]; %append I block
            else
                T_block_row = [T_block_row, zeros(reshape(block_sizes(i,j,:),[1,2]))]; %append 0 block
            end
        end
        T_matrix = [T_matrix;T_block_row];
    end
end