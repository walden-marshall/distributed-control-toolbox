function I_by_node = idxSet(Phi,partition)
%idxSet Generates the index set of a structured realization of $\Phi$.
%   Returns the index set of the $A$ matrix of a structured realization of
%   transfer matrix $\Phi$ (the structured realization must be formed with
%   structuredRlztn.m). The input partition should give the groupings of
%   the outputs of $\Phi$ (rows) which correspond to each node.
    
    %input checking
    if size(Phi,1) ~= sum(partition)
        error( ['number of rows implied by partition is not equal to ' ...
            'the number of rows in the transfer matrix'] )
    elseif any( partition < 0 )
        error('index sets contain negative values')
    end


    Phi = minreal(tf(Phi));
    N = length(partition); %number of nodes
    deg = @(x) length(x)-1; %lambda function for size of A when a scalar TF is realized
    numstates = cellfun(deg, Phi.Denominator);
    I_by_row = sum(numstates,2)'; %number of states each row constributes to A of
                                %the structured realization of entire TF matrix
    
    rowcumsum = [0,cumsum(partition)]; %used for keeping track of indices
    
    I_by_node = zeros(N,1);
    for i = 1:N
        rows_for_node = rowcumsum(i) + 1:rowcumsum(i+1); %the rows of the TF matrix that
                    %correspond to the i^th node (as prescribed by the partition)
        I_by_node(i) = sum( I_by_row(rows_for_node) );
    end
end