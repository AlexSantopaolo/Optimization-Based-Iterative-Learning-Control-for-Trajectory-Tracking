function [A,B] = get_jacobians(x,u)

z_dot=x(2);
theta=x(3);
theta_dot=x(4);

global alpha_1 alpha_2 m_p m_c l_p g;

a22=alpha_2/(m_p*(sin(theta)^2 + m_c/m_p));
a23=(g*sin(theta)^2 - g*cos(theta)^2 + l_p*theta_dot^2*cos(theta))/(sin(theta)^2 + m_c/m_p) - (2*cos(theta)*sin(theta)*(l_p*sin(theta)*theta_dot^2 + (alpha_1*u + alpha_2*z_dot)/m_p - g*cos(theta)*sin(theta)))/(sin(theta)^2 + m_c/m_p)^2;
a24=(2*l_p*theta_dot*sin(theta))/(sin(theta)^2 + m_c/m_p);
a42=-(alpha_2*cos(theta))/(l_p*m_p*(sin(theta)^2 + m_c/m_p));
a43=((sin(theta)*(alpha_1*u + alpha_2*z_dot))/m_p - cos(theta)*(l_p*cos(theta)*theta_dot^2 - (g*(m_c + m_p))/m_p) + l_p*theta_dot^2*sin(theta)^2)/(l_p*(sin(theta)^2 + m_c/m_p)) + (2*cos(theta)*sin(theta)*(sin(theta)*(l_p*cos(theta)*theta_dot^2 - (g*(m_c + m_p))/m_p) + (cos(theta)*(alpha_1*u + alpha_2*z_dot))/m_p))/(l_p*(sin(theta)^2 + m_c/m_p)^2);
a44=-(2*theta_dot*cos(theta)*sin(theta))/(sin(theta)^2 + m_c/m_p);

A= [  0  ,  1  ,  0  ,  0  ;
      0  , a22 , a23 , a24 ;
      0  ,  0  ,  0  , 1   ;
      0  , a42 , a43 , a44 ];

b2= alpha_1/(m_p*(sin(theta)^2 + m_c/m_p));
b4= -(alpha_1*cos(theta))/(l_p*m_p*(sin(theta)^2 + m_c/m_p));

B = [0; b2; 0; b4];

end

