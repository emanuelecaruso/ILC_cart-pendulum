function [xHistory, uHistory] = get_optimal_trajectory()
%% create NLMPC controller with appropriate states, outputs and inputs
nx = 4;
ny = 2;
nu = 1;
nlobj = nlmpc(nx, ny, nu);

%Set sampling time, prediction and control horizon

global Ts Duration;

nlobj.Ts = Ts;

nlobj.PredictionHorizon = 10;

nlobj.ControlHorizon = 5;

nlobj.Model.StateFcn = "pendulum_ur_DT0";

nlobj.Model.IsContinuousTime = false;
nlobj.Model.NumberOfParameters = 1;
nlobj.Model.OutputFcn = @(x,u,Ts) [x(1); x(3)];
nlobj.Jacobian.OutputFcn = @(x,u,Ts) [1 0 0 0; 0 0 1 0];

nlobj.Weights.OutputVariables = [3 3];
nlobj.Weights.ManipulatedVariablesRate = 0.1;

%nlobj.OV(1).Min = -10;
%nlobj.OV(1).Max = 10;

%x
nlobj.States(1).Min = -0.5;
nlobj.States(1).Max =  0.5;

%x dot
nlobj.States(2).Min = -5;
nlobj.States(2).Max =  5;

nlobj.MV.Min = -0.45;
nlobj.MV.Max =  0.45;

x0 = [0.1;0.2;-pi/2;0.3];
u0 = 0.4;
validateFcns(nlobj, x0, u0, [], {Ts});

x = [0;0;-pi;0];
y = [x(1);x(3)];

mv = 0; %manipulated variable

yref = [0 0]; %cart position and angle

nloptions = nlmpcmoveopt;

nloptions.Parameters = {Ts};

%%
% Run the simulation for |20| seconds.

hbar = waitbar(0,'Simulation Progress');
xHistory = x;
uHistory = mv;

for ct = 1:(Duration/Ts)

    % Correct previous prediction using current measurement 
    % Compute optimal control moves 
    [mv,nloptions,info] = nlmpcmove(nlobj,x,mv,yref,[],nloptions);
    % Predict prediction model states for the next iteration
    %predict(EKF, [mv; Ts]);
    %xk = x;
    % Implement first optimal control move and update plant states.
    x = pendulum_ur_DT0(x,mv,Ts);
    % Generate sensor data with some white noise
    %y = x([1 3]) + randn(2,1)*0.01; 
    y = x([1 3]);% randn(2,1)*0.01; 

    % Save plant states for display.
    xHistory = [xHistory x]; %#ok<*AGROW>
    uHistory = [uHistory mv];
    
    waitbar(ct*Ts/20,hbar);
end


close(hbar);

