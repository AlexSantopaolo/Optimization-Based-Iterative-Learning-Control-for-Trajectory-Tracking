function xk1 = pendulum_ur_DT0(xk, uk, Ts)
%% Discrete-time nonlinear dynamic model of a pendulum on a cart at time k
%
% 4 states (xk): 
%   cart position (z)
%   cart velocity (z_dot): when positive, cart moves to right
%   angle (theta): when 0, pendulum is at upright position
%   angular velocity (theta_dot): when positive, pendulum moves anti-clockwisely
% 
% 1 inputs: (uk)
%   force (F): when positive, force pushes cart to right 
%
% xk1 is the states at time k+1.
%
% Copyright 2018 The MathWorks, Inc.

%#codegen

% Repeat application of Euler method sampled at Ts/M.

delta = Ts;

xk1 = xk + delta*pendulum_ur_CT0(xk,uk);

% Note that we choose the Euler method (first oder Runge-Kutta method)
% because it is more efficient for plant with non-stiff ODEs.  You can
% choose other ODE solvers such as ode23, ode45 for better accuracy or
% ode15s and ode23s for stiff ODEs.  Those solvers are available from
% MATLAB.