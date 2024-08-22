function  G_tf = sym2tf(G,z)
%sym2tf Convert symbolic transfer matrix G with frequency domain variable z
%into a tf object
    dt=0.1;
    [Num,Den] = numden(G);
    for i = 1:size(G,1)
        for j = 1:size(G,2)
            c_n = double(coeffs(Num(i,j),z,'All'));
            c_d = double(coeffs(Den(i,j),z,'All'));
            G_tf(i,j) = tf(c_n,c_d,dt);
        end
    end
end