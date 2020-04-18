function plot_trajectory(xHistory,uHistory)
%%

global Ts Duration;

% Plot the closed-loop response.
figure
subplot(2,3,1)
plot(0:Ts:Duration,xHistory(1,:))
xlabel('time')
ylabel('z')
title('cart position')
subplot(2,3,2)
plot(0:Ts:Duration,xHistory(2,:))
xlabel('time')
ylabel('zdot')
title('cart velocity')
subplot(2,3,3)
plot(0:Ts:Duration,xHistory(3,:))
xlabel('time')
ylabel('theta')
title('pendulum angle')
subplot(2,3,4)
plot(0:Ts:Duration,xHistory(4,:))
xlabel('time')
ylabel('thetadot')
title('pendulum velocity')
subplot(2,3,5)
plot(0:Ts:Duration,uHistory)
xlabel('time')
ylabel('thetadot')
title('input u')


