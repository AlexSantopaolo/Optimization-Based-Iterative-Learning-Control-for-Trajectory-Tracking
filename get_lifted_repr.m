function [F,d0,G] = get_lifted_repr(xHistory,uHistory,x0_dev)

N=size(xHistory,2);      %number of timesteps

%get jacobians
A=zeros(4,4,N);
B=zeros(4,N);
for ct=1:N
    [nA,nB]=get_jacobians(xHistory(:,ct),uHistory(:,ct));
    A(:,:,ct)=nA;
    B(:,ct)=nB;
end

global Ts;

%compute F
F=zeros(N*4,N);
for m=1:N
    for l=1:N
        if m<l-1
            A_product=eye(4);
            for k=(l-1):-1:(m+1)
                Ad=eye([4,4])+Ts*A(:,:,k);
                A_product=A_product*Ad;
            end
            Bd=Ts*B(:,m);
            F(l*4-3:l*4,m)=A_product*Bd;
        elseif m==l-1
            Bd=Ts*B(:,m);
            F(l*4-3:l*4,m)=Bd;
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
        Ad=eye([4,4])+Ts*A(:,:,i);
        A_product=A_product*Ad;
    end
    d0(k*4-3:k*4,1)=A_product*x0_dev;
end

%compute G
G=zeros(N*4);
for k=1:N*4
    G(k,k)=1;
end

% %compute G
% G=zeros([N,N*4]);
% for k=1:N
%     G(k,k*4-1)=1;
% end
