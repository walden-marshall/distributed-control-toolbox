function [AK, BK, CK, DK] = generateRealization(p, idx_set_L, idx_set_R, adjacency)
% generate the realization of LR^{-1}
    tot_state_L = sum(idx_set_L); tot_state_R = sum(idx_set_R);

    A_L = zeros(tot_state_L); A_R = zeros(tot_state_R);
    B_L = zeros(tot_state_L,3); B_R = zeros(tot_state_R,3);
    C_L = zeros(3,tot_state_L); C_R = zeros(3,tot_state_R);
    D_L = zeros(3); D_R = zeros(3);
    
    idx_inc_L = [0;cumsum(idx_set_L)]; idx_inc_R = [0;cumsum(idx_set_R)]; %just makes keeping track of where to
                                                                        %place the blocks easier
    
    for i = 1:3 %rows
        for j = 1:3 %columns
            if adjacency(i,j)
                rows_L = idx_inc_L(i)+1:idx_inc_L(i+1); rows_R = idx_inc_R(i)+1:idx_inc_R(i+1);
                cols_L = idx_inc_L(j)+1:idx_inc_L(j+1); cols_R = idx_inc_R(j)+1:idx_inc_R(j+1);
    
                A_block_L = rand(idx_set_L(i),idx_set_L(j)); A_block_R = rand(idx_set_R(i),idx_set_R(j));
                A_L(rows_L,cols_L) = A_block_L; A_R(rows_R,cols_R) = A_block_R;
    
                C_block_L = rand(1,idx_set_L(j)); C_block_R = rand(1,idx_set_R(j));
                C_L(i,cols_L) = C_block_L; C_R(i,cols_R) = C_block_R;
                if i == j
                    B_block_L = rand(idx_set_L(i),1); B_block_R = rand(idx_set_R(i),1);
                    B_L(rows_L,i) = B_block_L; B_R(rows_R,i) = B_block_R;
                end
            end
        end
    end

    AK11 = A_R - B_R*C_R*(A_R+p*eye(tot_state_R)); 
    AK12 = zeros(tot_state_R,tot_state_L);
    AK21 = -B_L*C_R*(A_R+p*eye(tot_state_R)); AK22 = A_L;
    
    BK1 = B_R; BK2 = B_L;
    CK1 = -C_L*B_L*C_R*(A_R + p*eye(tot_state_R)); 
    CK2 = C_L*(A_L + p*eye(tot_state_L));
    DK = C_L * B_L;
    
    AK = [AK11, AK12;
        AK21, AK22];
    BK = [BK1; BK2];
    CK = [CK1, CK2];
end