clear all; close all; clc
syms z z_dot theta theta_dot u        %variables
syms g m_p m_c l_p alpha_1 alpha_2      %parameters

% z_dot
f1 = z_dot;
% z_dot_dot
f2 = ((alpha_1*u+alpha_2*z_dot)/m_p - g*sin(theta)*cos(theta) + l_p*(theta_dot)^2*sin(theta))/(m_c/m_p + sin(theta)^2);
% theta_dot
f3 = theta_dot;
% theta_dot_dot
f4 = (-cos(theta)*(alpha_1*u+alpha_2*z_dot)/m_p + (((m_c + m_p)/m_p)*g - l_p*theta_dot^2*cos(theta))*sin(theta))/(l_p*(m_c/m_p + sin(theta)^2));

f=[f1;f2;f3;f4];

%get jacobians
A=jacobian(f,[z,z_dot,theta,theta_dot]);
B=jacobian(f,u);

A;
B;