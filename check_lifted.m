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
[x_optimal_History, u_optimal_History]= get_optimal_trajectory();
plot_trajectory(x_optimal_History, u_optimal_History,"IDEAL TRAJECTORY");

%% GET REAL TRAJECTORY

u_real_History=u_optimal_History+0.0001; % just added a bias on u
x_real_History=simulation_nonlinearized(u_real_History,[0.0001;0;-pi+0.0001;0]); % little changes in initial conditions
plot_trajectory(x_real_History, u_real_History,"REAL TRAJECTORY");

% COMPUTE TRAJECTORY DEVIATIONS

u_dev_History=u_real_History-u_optimal_History;
x_dev_History=x_real_History-x_optimal_History;

plot_trajectory(x_dev_History, u_dev_History, "DEVIATION");

%% COMPUTE TRAJECTORY DEVIATIONS WITH LINEARIZED MODEL

u_dev_History=u_real_History-u_optimal_History;
x0_dev=x_dev_History(:,1);
x_dev_History_lin=simulation_linearized(x0_dev,u_dev_History,x_optimal_History,u_optimal_History);
plot_trajectory(x_dev_History_lin, u_dev_History, "DEVIATION (LINEARIZED)");

%% GET LIFTED REPRESENTATION

%get Matrices for lifted representation x=F*u+d0
x0_dev=x_dev_History(:,1);
[F,d0,G]=get_lifted_repr(x_optimal_History,u_optimal_History,x0_dev);

%get x_dev_LIFT_History
x_dev_LIFT_History=reshape(F*transpose(u_dev_History)+d0,size(x_optimal_History));
plot_trajectory(x_dev_LIFT_History, u_dev_History, "DEVIATION (LIFTED REPRESENTATION)");

%% GET TRAJECTORY FROM LIFTED REPRESENTATION

plot_trajectory(x_dev_LIFT_History+x_optimal_History, u_dev_History+u_optimal_History, "REAL TRAJECTORY (LIFTED REPRESENTATION)");

