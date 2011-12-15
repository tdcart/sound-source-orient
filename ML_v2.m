x = [0,0,4,4];
y = [0,6,6,0];
xy = [x;y];
dij = [0.0848,0.99098,0.5937];

del = @(d) sqrt(d'*d);
res = @(z) [del(xy(:,1)-z) - del(xy(:,2)-z) - dij(1)
            del(xy(:,1)-z) - del(xy(:,3)-z) - dij(2)
            del(xy(:,1)-z) - del(xy(:,4)-z) - dij(3)];

        
[XY,ssq,cnt] = LMFnlsq(res,[1;11],'display',1) 