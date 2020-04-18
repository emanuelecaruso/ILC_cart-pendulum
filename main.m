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