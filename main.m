if ~mpcchecktoolboxinstalled('optim')
    disp('Optimization Toolbox is required to run this example.')
    return
end

%% main script

%initialize parameters
init;

%get optimal trajectory
[x_optimal_History, u_optimal_History]= get_optimal_trajectory();

%plot_trajectory(x_optimal_History, u_optimal_History);

%get Matrices for lifted representation x=F*u+d0
[F,d0]=get_lifted_repr(x_optimal_History,u_optimal_History,[0;0;0;0]);