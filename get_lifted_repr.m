function [F,d0] = get_lifted_repr(xHistory,uHistory,x0_dev)

N=size(xHistory,2);      %number of timesteps, number of column of that xHistory

%Computer jacobian at each step time instant 

A=zeros(4,4,N);
B=zeros(4,N);
for ct=1:N
    [nA,nB]=get_jacobians(xHistory(:,ct));
    A(:,:,ct)=nA;
    B(:,ct)=nB;
end

%compute F
F=zeros(N*4,N);    % Get a Istant time*4, instant time matrix
for m=1:N
    for l=1:N
        if m<l-1
            A_product=eye(4);
            for k=(l-1):-1:(m+1)
                A_product=A_product*A(:,:,k);
            end
            F(l*4-3:l*4,m)=A_product*B(:,m);
        elseif m==l-1
            F(l*4-3:l*4,m)=B(:,m);
        else
            F(l*4-3:l*4,m)=zeros(4,1);
        end
    end
end

%compute d0
d0=zeros(N*4,1);
for k=1:N
    A_product=eye(4);
    for i=k-1:-1:1
        A_product=A_product*A(:,:,i);
    end
    d0(k*4-3:k*4,1)=A_product*x0_dev;
end
