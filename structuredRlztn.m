function Phi_struc = structuredRlztn(Phi)
%takes a strictly proper transfer matrix Phi and returns a realization of
%Phi with block diagonal A, block diagonal C, and B with the same block
%sparsity structure as Phi

    [nrow,ncol] = size(Phi);

    extractA = @(x) minreal(ss(x)).A;
    extractB = @(x) minreal(ss(x)).B;
    extractC = @(x) minreal(ss(x)).C;
    
    A = []; B = []; C = [];
    
    for i = 1:nrow
        Arow = arrayfun(extractA, Phi(i,:),'UniformOutput',false);
        Brow = arrayfun(extractB, Phi(i,:),'UniformOutput',false);
        Crow = arrayfun(extractC, Phi(i,:),'UniformOutput',false);
        A = blkdiag(A,blkdiag(Arow{:}));
        B = [B;blkdiag(Brow{:})];
        C = blkdiag(C,cell2mat(Crow));
    end

    Phi_struc = ss(A,B,C,zeros(nrow,ncol));
end