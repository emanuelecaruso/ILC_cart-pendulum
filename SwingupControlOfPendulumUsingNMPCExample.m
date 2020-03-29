clear all; close all; clc
%% Create Nonlinear MPC Controller

nx = 4;
ny = 2;
nu = 1;
nlobj = nlmpc(nx, ny, nu);

%% Sampling time

Ts = 0.1;
nlobj.Ts = Ts;

p=9;
nlobj.PredictionHorizon = p;

%%
%Control Horizon
c=5;
nlobj.ControlHorizon = c;

%% Specify Nonlinear Plant Model

nlobj.Model.StateFcn = "pendulumDT0";

%% Parameter
nlobj.Model.IsContinuousTime = false;

nlobj.Model.NumberOfParameters = 1;

%%
% The two plant outputs are the first and third state in the model.
nlobj.Model.OutputFcn = @(x,u,Ts) [x(1); x(3)];

%% Jacobina of the Output 
nlobj.Jacobian.OutputFcn = @(x,u,Ts) [1 0 0 0; 0 0 1 0];


%% Cost and Constraints

nlobj.Weights.OutputVariables = [2 2];   % Weight that penalize deviation from output references
nlobj.Weights.ManipulatedVariablesRate = 0.1; % Penalize large changes in control moves. Default value setted

%%
    nlobj.OV(1).Min = -0.5;
    nlobj.OV(1).Max = 0.5;
    nlobj.States(2).Min = -5;
    nlobj.States(2).Max = 5;
%%
% The force has a range between |-100| and |100|.
nlobj.MV.Min =-0.45;
nlobj.MV.Max = 0.;

%% Validating Nonlinear MPC

x0 = [0;0;-pi/2;0]; % Trying stuff a cazzo to validate
u0 = 0; 
validateFcns(nlobj, x0, u0, [], {Ts});

%% Closed-Loop Simulation in MATLAB(R)

% The initial conditions of the simulation are:
x = [0;0;-pi;0]; % Pendulum and cart stopped with pendulum down
y = [x(1);x(3)];
mv = 0; % Control
%% Reference
yref = [0 0];  %pendulum app and cart stopped

%% NLMPC SETTING
nloptions = nlmpcmoveopt;  %Creates a default set of options for the nlmpcmove function.
nloptions.Parameters = {Ts};

%% Simulation

Duration = 18.6;
hbar = waitbar(0,'Wait I am giving birth to a bad guy');
xHistory = x; % Conserve data

for ct = 1:(Duration/Ts)   % Istant of time
    
    
 % velocity are calculated with numerical derivative from istant of time 2
%     if (ct>1)
%         vel=(xHistory(1,ct)-xHistory(1,ct-1))/(ct-(ct-1));
%         ang_vel=(xHistory(3,ct)-xHistory(3,ct-1))/(ct-(ct-1));
%         fprintf('ciao')
%     else
%         vel=0;
%         ang_vel=0;
%     end
%    
    % Data that will go inside the NLMPC
%     xk=[x(1);vel;x(3);ang_vel];
    % Compute optimal control moves.
    [mv,nloptions,info] = nlmpcmove(nlobj,x,mv,yref,[],nloptions);
    % Implement first optimal control move and update plant states.
    x = pendulumDT0(x,mv,Ts);
    % Save plant states for display.
    xHistory = [xHistory x]; %Concatenation of column vector
    waitbar(ct*Ts/20,hbar);
end
close(hbar);

%%
% Plot the closed-loop response.
figure
subplot(2,2,1)
plot(0:Ts:Duration,xHistory(1,:))
xlabel('time')
ylabel('x')
title('cart position')
subplot(2,2,2)
plot(0:Ts:Duration,xHistory(2,:))
xlabel('time')
ylabel('xdot')
title('cart velocity')
subplot(2,2,3)
plot(0:Ts:Duration,xHistory(3,:))
xlabel('time')
ylabel('theta')
title('pendulum angle')
subplot(2,2,4)
plot(0:Ts:Duration,xHistory(4,:))
xlabel('time')
ylabel('thetadot')
title('pendulum velocity')

