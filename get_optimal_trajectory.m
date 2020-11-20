function [xHistory, uHistory] = get_optimal_trajectory()
%% create NLMPC controller with appropriate states, outputs and inputs
nx = 4;
ny = 1;
nu = 1;
nlobj = nlmpc(nx, ny, nu);

%Set sampling time, prediction and control horizon

global Ts Duration;

nlobj.Ts = Ts;

nlobj.PredictionHorizon = 100;

nlobj.ControlHorizon = 2;

nlobj.Model.StateFcn = "pendulum_ur_DT0";

nlobj.Model.IsContinuousTime = false;
nlobj.Model.NumberOfParameters = 1;
nlobj.Model.OutputFcn = @(x,u,Ts) [x(3)];
nlobj.Jacobian.OutputFcn = @(x,u,Ts) [0 0 1 0];

nlobj.Weights.OutputVariables = [3];
nlobj.Weights.ManipulatedVariablesRate = 0.1;

%nlobj.OV(1).Min = -10;
%nlobj.OV(1).Max = 10;

%x
global x_bound;
nlobj.States(1).Min = -x_bound;
nlobj.States(1).Max =  x_bound;

%x dot
global x_1_bound;
nlobj.States(2).Min = -x_1_bound;
nlobj.States(2).Max =  x_1_bound;

global u_bound_opt;
nlobj.MV.Min = -u_bound_opt;
nlobj.MV.Max =  u_bound_opt;

global x0;
x = x0;
y = [x(3)];

mv = 0; %manipulated variable

yref = [0]; %cart position and angle

nloptions = nlmpcmoveopt;

nloptions.Parameters = {Ts};

%%
% Run the simulation.

hbar = waitbar(0,'Simulation Progress');
xHistory = x;
uHistory = mv;

for ct = 1:(Duration/Ts)

    % Correct previous prediction using current measurement 
    % Compute optimal control moves 
    [mv,nloptions,info] = nlmpcmove(nlobj,x,mv,yref,[],nloptions);
    % Predict prediction model states for the next iteration
    %predict(EKF, [mv; Ts]);
    %xk = x;
    % Implement first optimal control move and update plant states.
    x = pendulum_ur_DT0(x,mv,Ts);
    % Generate sensor data with some white noise
    %y = x([1 3]) + randn(2,1)*0.01; 
    y = x([3]);% randn(2,1)*0.01; 

    % Save plant states for display.
    xHistory = [xHistory x]; %#ok<*AGROW>
    uHistory = [uHistory mv];
    
    waitbar(ct*Ts/Duration,hbar);
end
uHistory=[uHistory(2:length(uHistory)) 0];

close(hbar);
