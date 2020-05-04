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


%% parameters

global m_c m_p g l_p alpha_1 alpha_2 b c;

%% Obtain x, u and y
% x
x_2 = x(2); % Cart_velocity
x_3= x(3);  % Pendulum angle
x_4 = x(4); % Pendulum velocity
% u
F = alpha_1*u + alpha_2*x_2; % Force 

%% Compute dxdt
dxdt = x;
% z_dot
dxdt(1) = x_2;
% z_dot_dot
dxdt(2) = (F/m_p - g*sin(x_3)*cos(x_3) + l_p*(x_4)^2*sin(x_3))/(b + sin(x_3)^2);
% theta_dot
dxdt(3) = x_4;
% theta_dot_dot
dxdt(4) = (-cos(x_3)*F/m_p + (c - l_p*x_4^2*cos(x_3))*sin(x_3))/(l_p*(m_c/m_p + sin(x_3)^2));