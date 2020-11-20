%initialization of model parameters

global Ts Duration m_p m_c l_p alpha_1 alpha_2 m_p_real m_c_real l_p_real alpha_1_real alpha_2_real g x_bound x_1_bound u_bound u_bound_opt x0;

%Time parameters
Ts = 0.01;           %Sampling time (seconds)
Duration = 1;      %Simulation time (seconds)

g = 9.81;           %gravitational constant (meters/second^2)

%structural parameters (NOMINAL)
m_p = 0.175;        %mass of pendulum (kilograms)
m_c = 1.5;          %mass of the cart (kilograms)
l_p = 0.28;         %distance from pivot to pendulum's center of mass (meters)
alpha_1 = 159;      %motor constant 1 (voltage-to-force) (Newtons)
alpha_2 = -22.5;    %%motor constant 2 (electrical resistance-to-force) (Newtons*second/meters)

%structural parameters (REAL)
m_p_real = m_p*0.93;            %mass of pendulum (kilograms)
m_c_real = m_c*0.97;            %mass of the cart (kilograms)
l_p_real = l_p*1.10;           %distance from pivot to pendulum's center of mass (meters)
alpha_1_real = alpha_1*0.81;   %motor constant 1 (voltage-to-force) (Newtons)
alpha_2_real = alpha_2*0.86;    %%motor constant 2 (electrical resistance-to-force) (Newtons*second/meters)

% Bounds
x_bound = 0.5;      %bound due to finite rail length (meters)
x_1_bound = 5;      %bound due to limited velocity of the cart (meters/seconds)
u_bound = 0.45;     %bound due to limited velocity of motor (meters/seconds)
u_bound_opt = 0.2;  %bound due to limited velocity of motor (meters/seconds)

% Initial conditions (NOMINAL)
x0= zeros(4,1);
x0(1) = 0;          %initial position x of cart (meters)
x0(2) = 0;          %initial linear velocity x_1 of cart (meters/seconds)
x0(3) = -pi;        %initial angle phi of pendulum (radians)
x0(4) = 0;          %initial angularvelocity phi_1 of pendulum (radians/seconds)