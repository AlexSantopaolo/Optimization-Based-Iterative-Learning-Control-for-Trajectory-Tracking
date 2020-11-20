function dxdt = pendulum_ur_CT0_real(x, u)
%% Continuous-time nonlinear dynamic model of a pendulum on a cart
%
% 4 states (x): 
%   cart position (z)
%   cart velocity (z_dot): when positive, cart moves to right
%   angle (theta): when 0, pendulum is at upright position
%   angular velocity (theta_dot): when positive, pendulum moves anti-clockwisely
% 
% 1 inputs: (u)
%   force (F): when positive, force pushes cart to right 
%
% Copyright 2018 The MathWorks, Inc.

%#codegen

%% parameters

global g;
global m_c_real m_p_real l_p_real alpha_1_real alpha_2_real;

mp=m_p_real;
mc=m_c_real;
lp=l_p_real;
alpha1=alpha_1_real;
alpha2=alpha_2_real;

%% Obtain x, u and y
% x
z_dot = x(2);
theta = x(3);
theta_dot = x(4);
% u
F = alpha1*u + alpha2*z_dot;

%% Compute dxdt
dxdt = x;
% z_dot
dxdt(1) = z_dot;
% z_dot_dot
dxdt(2) = (F/mp - g*sin(theta)*cos(theta) + lp*(theta_dot)^2*sin(theta))/(mc/mp + sin(theta)^2);
% theta_dot
dxdt(3) = theta_dot;
% theta_dot_dot
dxdt(4) = (-cos(theta)*F/mp + (((mc + mp)/mp)*g - lp*theta_dot^2*cos(theta))*sin(theta))/(lp*(mc/mp + sin(theta)^2));