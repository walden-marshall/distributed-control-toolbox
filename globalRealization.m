function result = globalRealization(Phi, A, B, C, D)
%Given a matrix of L which contains multiple realizations of state space
%models, produce a global realization of L.
    r = 1;
    
    for c = 1:size(Phi, 2)
        tempA = ss(Phi(:,c)).A;
        tempB = ss(Phi(:,c)).B;
        tempC = ss(Phi(:,c)).C;
        if r == 1
            A = tempA;
            B = tempB;
            C = tempC;
            r = r + 1;
        elseif (r <= size(Phi, 1) && r > 1)
            A = blkdiag(A, tempA);
            B = blkdiag(B, tempB);
            C = cat(2, C, tempC);
            r = r + 1;
        end
    end
    result = ss(A,B,C,D);
end