syms x0;
x0=sym('x0',[4,1]);
x1=sym('x1',[4,1]);
x2=sym('x2',[4,1]);
x3=sym('x3',[4,1]);
A0=sym('A0',[4,4]);
A1=sym('A1',[4,4]);
A2=sym('A2',[4,4]);
A3=sym('A3',[4,4]);
B0=sym('B0',[4,1]);
B1=sym('B1',[4,1]);
B2=sym('B2',[4,1]);
B3=sym('B3',[4,1]);

xHistory=[x0, x1, x2, x3];
N=length(xHistory);      %number of timesteps

A=sym('A',[4,4,N]);
B=sym('B',[4,N]);
A(:,:,1)=A0;
A(:,:,2)=A1;
A(:,:,3)=A2;
A(:,:,4)=A3;
B(:,1)=B0;
B(:,2)=B1;
B(:,3)=B2;
B(:,4)=B3;

%compute F
F=sym('F',[N*4,N]);
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
d0=sym('d0',[N*4,1]);
for k=1:N
    A_product=eye(4);
    for i=k-1:-1:1
        A_product=A_product*A(:,:,i);
    end
    d0(k*4-3:k*4,1)=A_product*x0;
end
