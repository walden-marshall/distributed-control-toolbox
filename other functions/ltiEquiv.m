function sys_equiv = ltiEquiv(G1,G2)
%ltiEquiv Test whether LTI systems G1 and G2 have the same input/output
%behavior
%   Simulates the responses of G1 and G2 to an input to test if they are
%   the same (to within numerical precision).

    sys_equiv = true;
    
    %test sizes
    
    sz1 = size(G1); sz2 = size(G2);
    
    if sz1(1) ~= sz2(1)
        sys_equiv = false;
        disp('systems not equivalent: systems have different number of outputs')
    end
    
    if sz1(2) ~= sz2(2)
        sys_equiv = false;
        disp('systems not equivalent: systems have different number of inputs')
    end
    
    if not(sys_equiv)
        return
    end
    
    %test IO behavior
    
    %look at poles to determine how to drive it
    p1 = pole(G1); p2 = pole(G2);
    p_max = max( [abs(p1);abs(p2)] );
    p_min = min( [abs(p1);abs(p2)] );
    dec_p = ceil( log10(p_max/p_min) );
    
    omega = logspace( log10(p_min)-1, log10(p_max)+1, 3*dec_p+3);
    
    res = 0.1/p_max; dur = 10/p_min;
    N = ceil(dur/res);
    
    t = linspace(0,dur,N);
    
    u = zeros(size(G1,2),N);
    for i = 1:length(omega)
        u = u + sin(omega(i)*t) .* ones(size(G1,2),1);
    end
    
    %simulate the systems
    y1 = lsim(G1,u,t); y2 = lsim(G2,u,t);
    
    %test if the error exceeds a threshold
    err = y1-y2;
    err_max = max(err,[],'all');
    
    G1 = zpk(G1); G2 = zpk(G2);
    K1 = G1.K; K2 = G2.K;
    gain = max(abs([K1,K2]),[],'all');
    in_amp = max(u,[],'all');
    thr = gain*in_amp*1e-9;
    if err_max > thr
        disp('systems not equivalent: simulation error tolerance exceeded')
        sys_equiv = false;
        return
    end
    
    if sys_equiv
        disp('systems are equivalent to within numerical precision')
    end

end