function [K] = generateRealization(p, Phiu, Phix, Iu, Ix, T)
% generate the realization of LR^{-1} = K
    tot_state_Phiu = sum(Iu); tot_state_Phix = sum(Ix);

    A_Phiu = Phiu.A; A_Phix = Phix.A;
    B_Phiu = Phiu.B; B_Phix = Phix.B;
    C_Phiu = Phiu.C; C_Phix = Phix.C;
    D_L = Phiu.D; D_R = Phix.D;
    
    AK11 = A_Phix - B_Phix*C_Phix*(A_Phix+p*eye(tot_state_Phix)); 
    AK12 = zeros(tot_state_Phix,tot_state_Phiu);
    AK21 = -B_Phiu*C_Phix*(A_Phix+p*eye(tot_state_Phix)); AK22 = A_Phiu;
    
    BK1 = B_Phix; BK2 = B_Phiu;
    CK1 = -C_Phiu*B_Phiu*C_Phix*(A_Phix + p*eye(tot_state_Phix)); 
    CK2 = C_Phiu*(A_Phiu + p*eye(tot_state_Phiu));
    DK = C_Phiu * B_Phiu;
    
    AK = [AK11, AK12;
        AK21, AK22];
    BK = [BK1; BK2];
    CK = [CK1, CK2];
    AK_til = T*AK/T; BK_til = T*BK; CK_til = CK/T;

    K = ss(AK_til, BK_til, CK_til, DK);
end