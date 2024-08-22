function Phi_struc = structuredRlztn(Phi)
%structuredRlztn Create structured realization of structured transfer
%matrix $\Phi$.
%   Creates a realization of $\Phi$ with  $A$ and $C$ block diagonal and $B$
%   with the same structure as the transfer matrix.
    
    Phi = minreal(Phi);
    
    deg = @(x) length(x)-1; %lambda function for size of A when a scalar TF is realized
    numstates = cellfun(deg, Phi.Denominator);
    
    szA = sum(numstates,'all');
    [szC,szB] = size(Phi);
    
    A = zeros(szA,szA); B = zeros(szA,szB); C = zeros(szC,szA);
    
    I_by_row = sum(numstates,2);
    statecumsum = [0;cumsum(I_by_row)];

    %lambda functions for extracting realizations from a TF
    extractA = @(x) ss(x).A;
    extractB = @(x) ss(x).B;
    extractC = @(x) ss(x).C;
    
    for i = 1:szC
        Arow = arrayfun(extractA, Phi(i,:),'UniformOutput',false);
        Brow = arrayfun(extractB, Phi(i,:),'UniformOutput',false);
        Crow = arrayfun(extractC, Phi(i,:),'UniformOutput',false);
        dims = statecumsum(i)+1:statecumsum(i+1);
        A(dims,dims) = blkdiag(Arow{:});
        B(dims,:) = blkdiag(Brow{:});
        C(i,dims) = cell2mat(Crow);
    end

    Phi_struc = ss(A,B,C,zeros(szC,szB));

end
