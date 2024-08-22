function [K,partition_ksi_K] = structuredControllerRealization(Phix,Phiu,partition_x,partition_u)
%structuredControllerRealization Generate structured controller realization
%from structured SLS parameters.
%   For transfer matrices $\Phi^x$ and $\Phi^u$ with some block sparsity
%   pattern (block sizes prescribed by partition_x and partition_u, which
%   implicitly assumes signals x and u are grouped accoring to node), this
%   pipeline will provide a structured realization of the the state
%   feedback controller $u=Kx$. This also returns the partition of the
%   internal state $\ksi_K$.

    partition_ksi_x = idxSet(Phix,partition_x); partition_ksi_u = idxSet(Phiu,partition_u);
    Phix = structuredRlztn(Phix); Phiu = structuredRlztn(Phiu);
    T = permutationT(partition_ksi_x,partition_ksi_u);
    K = unstructuredK(Phiu,Phix,partition_ksi_u,partition_ksi_x,1);
    K = structureK(K,T);
    partition_ksi_K = partition_ksi_x + partition_ksi_u;
end