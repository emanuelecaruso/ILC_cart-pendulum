function xk1 = pendulumDT0(xk, uk, Ts)
%% Discrete-time nonlinear dynamic model of a pendulum on a cart at time k
M = 10;
delta = Ts/M;
xk1 = xk;
for ct=1:M
    xk1 = xk1 + delta*pendulumCT0(xk1,uk);
end

