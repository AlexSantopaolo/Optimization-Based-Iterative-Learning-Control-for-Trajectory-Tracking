<h1>Optimization-Based Iterative Learning Control for Trajectory Tracking</h1>

Developed by: S. Saif, A. Santopaolo (2020).

Supervisor: prof. G. Oriolo, L. Lanari.

Achievement: Underactuated robot exam.

<h2>Project description:</h2>

In this project an iterative learning controller is realized and tested on a Cart-Pole system. Starting from a feasible swing-up trajectory, at each trial, the uncertainties over the dynamics parameters of the model are estimated and incorporated in the controller formulation during the next iteration. Simulation implemented in Matlab.
<h3>File details:</h3>


- [MAIN.M](main.m) : is the main file.

1. Section A: there is an INIT.M call to initialize the parameters. 
1. Section B: Using get_optimal_trajectory function a NPLMC algotithm is run to find the ideal trajectory. There is the plotting of Ideal trajectory. 
1. Section C: Number of simulation for ILC to converge.
1. Section D: Setted up the real nominal condition that varies at each iteration. First simulation run with optimal input. Computed Lifted representation. Initilization of Kalman filter matrices and cycle with simulation. Run control step using fmicon. Computed each simulation trajectory and plotted all of them.

* INIT.M: Parameters initialization.

* PENDULUM_ur_CT0: Function with continuos time cart-pendulum equations of motion with nominal parameter.

* PENDULUM_ur_CT0_real: Function with continuos time cart-pendulum equations of motion with real parameters.

* PENDULUM_ur_DT0: Function with discrete time cart-pendulum equations of motions using Euler method. (Nominal parameter setup)

* PENDULUM_ur_DT0_real: Function with discrete time cart-pendulum equations of motions using Euler method. (Real parameters setup).

* Plot_trajectory: Script to plot in a same images plots of cart position, cart velocity, pendulum angle, pendulum velocity and input with respect to time.

* Plot_trajectories: Script to plot cart position, cart velocity, pendulumangle, pendulum velocity and input with respect to time for each single trial in the same image.

* Get_Fd_contr: Script to get F and D matrices related to angle position dynamics.

* get_jacobians: Script to get A and B matrices for state space model computing at each time istant the jacobians.

* get_lifted_repr: Algorithm to compute F,G and D_0 given column vectors of all state and input. F and G represent the model dyamics. Algorithm present in the report.

* get_optimal_trajectory: Script to run the NLMPC and get optimal trajectory. Implementation details in the report.

* nonlinearconstraints: Constraints of cart position and cart velocity due to rail length and cart actuator. Used to run fmincon algorithm.

> For further detail open the [ Project_Report](Report_Project.pdf)

>Watch the [video](https://youtu.be/KscG354lbqI) with the results

<h3> References </h3>
Schöllig, A., & D'Andrea, R. (2009, August). Optimization-based iterative learning control for trajectory tracking. In 2009 European Control Conference (ECC) (pp. 1505-1510). IEEE.

