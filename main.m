clear all; close all; clc
if ~mpcchecktoolboxinstalled('optim')
    disp('Optimization Toolbox is required to run this example.')
    return
end

%% main script

%initialize parameters
init;

%get optimal trajectory
[x_optimal_History, u_optimal_History]= get_optimal_trajectory();
plot_trajectory(x_optimal_History, u_optimal_History);
N=size(x_optimal_History,2);
%initial deviation of state
x0dev=[0;0;0;0];

%get Matrices for lifted representation x=F*u+d0
[F,d0]=get_lifted_repr(x_optimal_History,u_optimal_History,x0dev);

% xdev_History=reshape(F*transpose(u_optimal_History)+d0,size(x_optimal_History));
% 
% x_History=x0dev;
% x=x0dev;
% for ct=1:N
%     [nA,nB]=get_jacobians(x,u_optimal_History(1,ct));
%     x=nA*x'+nB*u_optimal_History(:,ct);
%     x_History=[x0dev x];
% end
% 
% isequal(x_History,xdev_History);

% % %deviation of input u trajectory
% % udev_History=zeros(size(u_optimal_History));
% % a=F*transpose(udev_History);
% % %get xdev_History
% % xdev_History=reshape(F*transpose(udev_History)+d0,size(x_optimal_History)); % from 
% % plot_trajectory(x_optimal_History, u_optimal_History);
% % figure('Name','Measured Data','NumberTitle','off');
% % plot_trajectory(xdev_History, u_optimal_History);