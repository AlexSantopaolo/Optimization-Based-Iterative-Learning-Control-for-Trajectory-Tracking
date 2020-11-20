function [xHistory_dev] = simulation_linearized(x0_dev,uHistory_dev,xHistory_optimal,uHistory_optimal)

global Ts;
N=size(xHistory_optimal,2);      %number of timesteps
xHistory_dev=zeros([4,N]);
xHistory_dev(:,1)=x0_dev;

%get jacobians
A=zeros(4,4,N);
B=zeros(4,N);
for ct=1:N
    [nA,nB]=get_jacobians(xHistory_optimal(:,ct),uHistory_optimal(ct));
    A(:,:,ct)=nA;
    B(:,ct)=nB;
end

for i=2:N
    Ad=eye([4,4])+Ts*A(:,:,i-1);
    Bd=Ts*B(:,i-1);
    xHistory_dev(:,i)= Ad*xHistory_dev(:,i-1)+Bd*uHistory_dev(i-1);
end
end

