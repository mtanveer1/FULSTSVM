function [accuracy,ytest0,predicted_class,train_Time]=FULSTSVM(A,A_test,U,c,c2,e,mu)
mew1=1/(2*mu*mu);
[m,n]=size(A);[m_test,n_test]=size(A_test);
x0=A(:,1:n-1);y0=A(:,n);
xtest0=A_test(:,1:n_test-1);ytest0=A_test(:,n_test);
Cf=[x0 y0];

[C memb membu time1]=cfuzz(Cf,U);

[no_input,no_col]=size(C);
  mem=memb;
 
  [no_input,no_col]=size(C);
  obs = C(:,no_col);    
  A = [];
 B = [];
 Amem = [];
 Bmem = [];
for i = 1:no_input
    if(obs(i) == 1)
        A = [A;C(i,1:no_col-1)];
        Amem=[Amem;mem(i)];
    else
        B = [B;C(i,1:no_col-1)];
        Bmem=[Bmem;mem(i)];
    end
end

S1=diag(Amem);
S2=diag(Bmem);
S3=diag(membu);



%----------------Training-------------
C=[A;B];
m1=size(A,1);
m2=size(B,1);
m3=size(U,1);
m4=size(C,1);
e1=ones(m1,1);
e2=ones(m2,1);
eu=ones(m3,1);
tic
K = zeros (m1,m4);

for i =1: m1
    for j =1: m4
        nom = norm( A(i ,:) - C(j ,:) );
        K(i,j)=exp(-mew1*nom*nom);
    end
end

H=[S1*K S1*e1];


K = zeros (m2,m4);
for i =1: m2
    for j =1: m4
        nom = norm( B(i ,:) - C(j ,:) );
        K(i,j)=exp(-mew1*nom*nom);
    end
end

G=[S2*K S2*e2];
% GTG=G'*G;


K = zeros (m3,m4);
for i =1: m3
    for j =1: m4
        nom = norm( U(i ,:) - C(j ,:) );
        K(i,j)=exp(-mew1*nom*nom);
    end
end

O=[S3*K S3*eu];


I=speye(m+1);

HTH=H'*H;
GTG=G'*G;
OTO=O'*O;
temp=(1-e)*O'*(S3*eu);

u1=-(1/c*HTH+GTG+c2/c*I+OTO)\(G'*(S2*e2)+temp);
u2=(1/c*GTG+HTH+c2/c*I+OTO)\(H'*(S1*e1)+temp);
train_Time=toc+time1;
%---------------Testing---------------
no_test=size(xtest0,1);
K = zeros(no_test,m4);
for i =1: no_test
    for j =1: m4

        nom = norm( xtest0(i ,:) - C(j ,:) );
        K(i,j )=exp(-mew1*nom*nom);
    end
end
K=[K ones(no_test,1)];
preY1=K*u1/norm(u1(1:size(u1,1)-1,:));
preY2=K*u2/norm(u2(1:size(u2,1)-1,:));
predicted_class=[];
for i=1:no_test
    if abs(preY1(i))< abs(preY2(i))
        predicted_class=[predicted_class;1];
    else
        predicted_class=[predicted_class;-1];
    end

end
err = sum(predicted_class ~= ytest0);
accuracy=(no_test-err)/(no_test)*100;
return
end
