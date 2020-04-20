syms x0;

N=4;      %number of timesteps

%A=sym('A',[4,4,N]);
%B=sym('B',[4,N]);
%A(:,:,1)=A0;
%A(:,:,2)=A1;
%A(:,:,3)=A2;
%A(:,:,4)=A3;
%B(:,1)=B0;
%B(:,2)=B1;
%B(:,3)=B2;
%B(:,4)=B3;

A=sym('A',N);
B=sym('B',N);

%compute F
F=sym('F',[N,N]);
for m=1:N
    for l=1:N
        if m<l-1
            A_product=1;
            for k=(m+1):(l-1)
                A_product=A_product*A(k);
            end
            F(l,m)=A_product*B(m);
        elseif m==l-1
            F(l,m)=B(m);
        else
            F(l,m)=0;
        end
    end
end

%compute d0
d0=sym('d0',[N,1]);
for k=1:N
    A_product=1;
    for i=1:k-1
        A_product=A_product*A(i);
    end
    d0(k)=A_product*x0;
end
