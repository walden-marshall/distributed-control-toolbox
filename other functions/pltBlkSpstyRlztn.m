function pltBlkSpstyRlztn(G,Ix,Iu,Iy)
%pltBlkSpstyRlztn Plot block sparsity structure of state space model
%   Plot plot sparsity structure of LTI system G with state partitioned by
%   Ix, input partitioned by Iu and output partitions by Iy.
figure()
subplot(2,2,1)
pltBlkSpsty(G.A,Ix,Ix);
axis('square')
title('Sparsity $A$', 'Interpreter','latex')
subplot(2,2,2)
pltBlkSpsty(G.B,Ix,Iu);
axis('square')
title('Sparsity $B$', 'Interpreter','latex')
subplot(2,2,3)
pltBlkSpsty(G.C,Iy,Ix);
axis('square')
title('Sparsity $C$', 'Interpreter','latex')
subplot(2,2,4)
pltBlkSpsty(G.D,Iy,Iu);
axis('square')
title('Sparsity $D$', 'Interpreter','latex')
end