function dxdt = pendulumCT0(x, u)
%% Continuous-time nonlinear dynamic model of a pendulum on a cart

%structural parameters
m_p = 0.175;        %mass of pendulum (kilograms)
m_c = 1.5;          %mass of the cart (kilograms)
l_p = 0.28;         %distance from pivot to pendulum's center of mass (meters)
alpha_1 = 159;      %motor constant 1 (voltage-to-force) (Newtons)
alpha_2 = -22.5;    %%motor constant 2 (electrical resistance-to-force) (Newtons*second/meters)
g = 9.81;           %gravitational constant (meters/second^2)
% Input
F = alpha_1*u+alpha_2*x(2);
%% Compute dxdt
%x=[x,x_dot,theta,theta_dot]
dxdt = x;
% z_dot
dxdt(1) = x(2);
% z_dot_dot
dxdt(2) = (F/m_p-g*sin(x(3))*cos(x(3))+l_p*x(4)^2*sin(x(3)))/((m_c+m_p)+(sin(x(3)))^2);
% theta_dot
dxdt(3) = x(4);
% theta_dot_dot
dxdt(4) = (-cos(x(3))*(F/m_p)+(((((m_c+m_p)*g)/(m_p))-l_p*(x(4))^2*cos(x(3)))*sin(x(3))))/(l_p*((m_c/m_p)+(sin(x(3)))^2));
