function dxdt = pendulum_ur_CT0(x, u)
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

global m_c m_p g l_p alpha_1 alpha_2;

%% Obtain x, u and y
% x
z_dot = x(2);
theta = x(3);
theta_dot = x(4);
% u
F = alpha_1*u + alpha_2*z_dot;

%% Compute dxdt
dxdt = x;
% z_dot
dxdt(1) = z_dot;
% z_dot_dot
dxdt(2) = (F/m_p - g*sin(theta)*cos(theta) + l_p*(theta_dot)^2*sin(theta))/(m_c/m_p + sin(theta)^2);
% theta_dot
dxdt(3) = theta_dot;
% theta_dot_dot
dxdt(4) = (-cos(theta)*F/m_p + (((m_c + m_p)/m_p)*g - l_p*theta_dot^2*cos(theta))*sin(theta))/(l_p*(m_c/m_p + sin(theta)^2));