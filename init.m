%initialization of model parameters

global m_p m_c l_p alpha_1 alpha_2 g x_bound x_1_bound u_bound state0 state0_1;

%structural parameters
m_p = 0.175;        %mass of pendulum (kilograms)
m_c = 1.5;          %mass of the cart (kilograms)
l_p = 0.28;         %distance from pivot to pendulum's center of mass (meters)
alpha_1 = 159;      %motor constant 1 (voltage-to-force) (Newtons)
alpha_2 = -22.5;    %%motor constant 2 (electrical resistance-to-force) (Newtons*second/meters)
g = 9.81;           %gravitational constant (meters/second^2)

%bounds
x_bound = 0.5;      %bound due to finite rail length (meters)
x_1_bound = 5;      %bound due to limited velocity of the cart (meters/seconds)
u_bound = 0.2;      %bound due to limited velocity of motor (meters/seconds)

%initial conditions
state0=zeros(2,1);
state0_1=zeros(2,1);
state0(1) = 0;      %initial position x of cart (meters)
state0(2) = pi;     %initial angle phi of pendulum (radians)
state0_1(1) = 0;    %initial linear velocity x_1 of cart (meters/seconds)
state0_1(2) = 0;    %initial angularvelocity phi_1 of pendulum (radians/seconds)