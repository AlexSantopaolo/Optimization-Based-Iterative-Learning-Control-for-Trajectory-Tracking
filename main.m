if ~mpcchecktoolboxinstalled('optim')
    disp('Optimization Toolbox is required to run this example.')
    return
end
clear all;
close all;
clc;

%% main script

%initialize parameters
init;

%% GET IDEAL TRAJECTORY

%get ideal trajectory
global x_optimal_History u_optimal_History N;
[x_optimal_History, u_optimal_History]= get_optimal_trajectory();
N=size(x_optimal_History,2);
plot_trajectory(x_optimal_History, u_optimal_History,"IDEAL TRAJECTORY");

%% ITERATIVE LEARNING CONTROL

close all;
clc;

n_iterations=4;

%SIMULATE

%compute initial conditions
global x0_real;
x0_real=[0;0;-pi;0];
sigma_x0=0.001;
x0_real=x0_real+normrnd(0,sigma_x0,[4,1]);

%simulate applying nominal u
[x,y]=simulation_nonlinearized_real(transpose(u_optimal_History),x0_real);
y_iterations=[y];
x_iterations=[x];
u_iterations=[ u_optimal_History ];

%get matrices for lifted representation
global F d_estimated;
[F,~,G]=get_lifted_repr(x_optimal_History,u_optimal_History,[0;0;0;0]);

%parameters initialization for estimation
coeff_trial=2;
P=eye(N*4)*coeff_trial;
M_coeff=0.01;
M=eye(4*N)*M_coeff;
d_estimated=zeros([N*4,1]);
Kgain=zeros([4*N,N]);

u=zeros([N,1]);

for j=1:n_iterations

    %ESTIMATION STEP
    eps=0.01;
    OMEGA=eye(N*4)*eps;
    P_cond=P+OMEGA;
    THETA=G*P_cond*transpose(G)+M;
    Kgain=P_cond*transpose(G)*inv(THETA);
    P=(eye(4*N)-Kgain*G)*P_cond;
    
    y_dev=reshape(y-x_optimal_History,[4*N,1]);
    d_estimated=d_estimated+Kgain*(y_dev-G*d_estimated-(G*F)*u);
    
    %CONTROL STEP
    global u_bounds
    lb=-u_bound-transpose(u_optimal_History);
    ub=u_bound-transpose(u_optimal_History);
    u0=zeros([N,1]);
            
    % solve optimization problem with fmincon
    [Fcontr,d_estimated_contr]=get_Fd_contr(F,d_estimated);
    
    W=getWeights();
    fun = @(u_opt)transpose((Fcontr*u_opt+d_estimated_contr))*((Fcontr*u_opt+d_estimated_contr));
    options = optimoptions(@fmincon,'MaxFunctionEvaluations',100000000,'MaxIterations',10000);
    %problem = createOptimProblem('fmincon','objective',fun,'x0',u0,'lb',lb,'ub',ub,'options',options);
    %gs = GlobalSearch;
    
    %u = run(gs,problem);
    u = fmincon(fun,u0,[],[],[],[],lb,ub,@nonlinearconstraints,options);

    j
    transpose((Fcontr*u+d_estimated_contr))*((Fcontr*u+d_estimated_contr))
    
    u_iterations=[u_iterations; transpose(u)+u_optimal_History];
    
    %SIMULATE
    [x,y]=simulation_nonlinearized_real(u+transpose(u_optimal_History),x0_real);
    x_iterations=[x_iterations; x];
    y_iterations=[y_iterations; y];
    
    %compute new initial conditions for next iteration (random walk)
    x0_real=x0_real+normrnd(0,sigma_x0,[4,1]);
end

num_trials=0;
for j=1:num_trials
    if (j==1)
        x_iterations=[];
        y_iterations=[];
        u_iterations=[];
    end
    [x,y]=simulation_nonlinearized_idealwnoise(transpose(u_optimal_History),x0_real);
    x0_real=[0;0;-pi;0]+normrnd(0,sigma_x0,[4,1]);
    u_iterations=[u_iterations; u_optimal_History];
    x_iterations=[x_iterations; x];
    y_iterations=[y_iterations; y];
end

plot_trajectories(x_iterations,u_iterations,x_optimal_History,u_optimal_History,"Real output trajectory");
saveJson(x_iterations);

plot_trajectories(y_iterations,u_iterations,x_optimal_History,u_optimal_History,"Observed output trajectory");

