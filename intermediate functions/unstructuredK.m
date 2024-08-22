function K = unstructuredK(Phiu, Phix, Iu, Ix, p)
%unstructuredK Construct unstructured realization of K.
%   Constructs realization in terms of the realization of the cascaded
%   system $[(s+p)\Phi^u][(s+p)\Phi^x]^{-1}$
    tot_state_u = sum(Iu); tot_state_x = sum(Ix);

    A_u = Phiu.A; A_x = Phix.A;
    B_u = Phiu.B; B_x = Phix.B;
    C_x = Phiu.C; C_u = Phix.C;
    
    AK11 = A_x - B_x*C_u*(A_x+p*eye(tot_state_x)); 
    AK12 = zeros(tot_state_x,tot_state_u);
    AK21 = -B_u*C_u*(A_x+p*eye(tot_state_x)); AK22 = A_u;
    
    BK1 = B_x; BK2 = B_u;

    CK1 = -C_x*B_u*C_u*(A_x + p*eye(tot_state_x)); 
    CK2 = C_x*(A_u + p*eye(tot_state_u));
    DK = C_x * B_u;
    
    AK = [AK11, AK12;
        AK21, AK22];
    BK = [BK1; BK2];
    CK = [CK1, CK2];

    K = ss(AK,BK,CK,DK);
end