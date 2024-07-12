function result = globalRealization(Phi)
%Given a matrix of L which contains multiple realizations of state space
%models, produce a global realization of L.
    c = 1;
    A = zeros(2,2);
    B = zeros(2,1);
    C = zeros(1,2);
    D = zeros(1,1);
    
    for r = 1:size(Phi, 1)
        tempA = ss(Phi(r,:)).A;
        tempB = ss(Phi(r,:)).B;
        tempC = ss(Phi(r,:)).C;
        if c == 1
            A = tempA;
            B = tempB;
            C = tempC;
            c = c + 1;
        elseif (c <= size(Phi, 2) && c > 1)
            A = blkdiag(A, tempA);
            B = cat(1, B, tempB);
            C = blkdiag(C, tempC);
            c = c + 1;
        end
    end
    result = ss(A,B,C,D);
end