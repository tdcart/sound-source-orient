function y = makeEqSys(Tx,Rx,d)
N = length(Rx);
y = zeros(N-1,1);
for i=2:N
    y(i-1) = sqrt((Rx(i,1)-Tx(1))^2+(Rx(i,2)-Tx(2))^2) + (Rx(i,3)-Tx(3))^2 - ... 
    sqrt((Rx(1,1)-Tx(1))^2+(Rx(1,2)-Tx(2))^2 +(Rx(1,3)-Tx(3))^2) - d(i,1);
end
