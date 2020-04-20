if ~mpcchecktoolboxinstalled('optim')
    disp('Optimization Toolbox is required to run this example.')
    return
end

%% main script

%initialize parameters
init;

%get optimal trajectory
[x_optimal_History, u_optimal_History]= get_optimal_trajectory();

%initial deviation of state
x0dev=[0;0;-0.00001;0];

%get Matrices for lifted representation x=F*u+d0
[F,d0]=get_lifted_repr(x_optimal_History,u_optimal_History,x0dev);

%deviation of input u trajectory
udev_History=zeros(size(u_optimal_History));

%get xdev_History
xdev_History=reshape(F*transpose(udev_History)+d0,size(x_optimal_History));
plot_trajectory(x_optimal_History, u_optimal_History);
plot_trajectory(xdev_History, udev_History);