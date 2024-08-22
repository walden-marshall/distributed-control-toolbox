function T = permutationT(idx_x,idx_u)
%permutationT Create the similarity transformation $T$ to arrange the
%states in a realization of $K$ by node.
%   Goes from a realization of $K$ whose states are grouped according to
%   whether they are states from $\Phi^x$ or $\Phi^u$ to a realization
%   where the states are grouped according to the node they correspond to.

    if length(idx_x) ~= length(idx_u)
        error('index sets not same length')
    elseif any( [idx_x;idx_u] < 0 )
        error('index sets contain negative values')
    end
    
    N = length(idx_x); %number of nodes
    I = eye(2*N);
    odd = 1:2:2*N-1; even = 2:2:2*N;
    
    I_locs = [I(:,odd),I(:,even)]; %location of I blocks in T
    
    old_idx_set = [idx_x;idx_u]; %index set of the original K realization
    new_idx_set = reshape([idx_x';idx_u'],[2*N,1]); %index set after T transformation
    
    %loop through and put I and 0 blocks of the proper size in the proper locations
    T = zeros(sum(new_idx_set));
    idx_inc_old = [0;cumsum(old_idx_set)]; idx_inc_new = [0;cumsum(new_idx_set)];
    I_indcs = find(I_locs);
    
    for k = 1:2*N
        [i,j] = ind2sub([2*N,2*N],I_indcs(k));
        rows = idx_inc_new(i)+1:idx_inc_new(i+1); cols = idx_inc_old(j)+1:idx_inc_old(j+1);
        T(rows,cols) = eye(new_idx_set(i));
    end

end