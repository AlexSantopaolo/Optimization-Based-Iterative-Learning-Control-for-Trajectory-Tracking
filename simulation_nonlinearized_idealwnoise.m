function [xHistory ,yHistory] = simulation_nonlinearized_idealwnoise(uHistory,x0)

global Ts;
N=length(uHistory);
xHistory=zeros([4,N]);
yHistory=zeros([4,N]);
xHistory(:,1)=x0;
yHistory(:,1)=x0;

%noises
sigma_xi=0.000;
sigma_ni_x=0.001;
sigma_ni_theta=0.01;


for i=2:N
    
    %compute next state
    disturbance=normrnd(0,sigma_xi,[4,1]);
    disturbance(1)=0;
    disturbance(3)=0;
    xHistory(:,i)= pendulum_ur_DT0(xHistory(:,i-1), uHistory(i-1), Ts)+disturbance;
    
    %observe output
    y_x=xHistory(1,i)+normrnd(0,sigma_ni_x);
    y_x_1=(y_x-yHistory(1,i-1))/Ts;
    y_theta=xHistory(3,i)+normrnd(0,sigma_ni_theta);
    y_theta_1=(y_theta-yHistory(3,i-1))/Ts;
    y=[y_x,y_x_1,y_theta,y_theta_1];
    yHistory(:,i)=y;
    
end

end

