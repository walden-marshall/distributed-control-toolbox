function K_struc = structureK(K,T)
%structuredK Applies transformation $T$ to structure the realization of $K$
%   The new realization of $K$ is $(T*A*T^{-1}, T*B, C*T^{-1}, D)$

    AK_til = T*K.A/T; BK_til = T*K.B; CK_til = K.C/T;
    K_struc = ss(AK_til,BK_til,CK_til,K.D);
end