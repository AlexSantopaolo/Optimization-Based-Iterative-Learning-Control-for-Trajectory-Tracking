function [c,ceq] = nonlinearconstraints(u)
global x0_real u_optimal_History N x_optimal_History F d_estimated;

x=x_optimal_History+reshape(F*u+d_estimated,[4,N]);

c(1) = max(abs(x(1,:)))-0.5;
c(2) = max(abs(x(2,:)))-5;
%c(3) = max(movvar(u,5))-0.001;
%c=[];
ceq = [];

end
