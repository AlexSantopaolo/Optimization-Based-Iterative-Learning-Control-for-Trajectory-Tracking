function xHistory = simulation_nonlinearized(uHistory,x0)

global Ts;
N=length(uHistory);
xHistory=zeros([4,N]);
xHistory(:,1)=x0;
for i=2:N
    xHistory(:,i)= pendulum_ur_DT0(xHistory(:,i-1), uHistory(i-1), Ts);
end
end

