function [C memb membu time_f]=cfuzz(C,U)

[no_input,no_col]=size(C); 
obs = C(:,no_col);    
A = [];
B = [];

for i = 1:no_input
    if(obs(i) == 1)
        A = [A;C(i,1:no_col-1)];
    else
        B = [B;C(i,1:no_col-1)];
    end
end
[x y]=size(A);
[x1 y1]=size(B);
[xu yu]=size(U);
tic
        s = sum(A,1)/x; %centroid
        h = sum(B,1)/x1;
		k = sum(U,1)/xu;

distancec=zeros(x,1);       
for i = 1:x
   diff = A(i,1:no_col-1) - s(1:no_col-1);
   distancec(i) = sqrt(diff * diff');
end

[val ind]=max(distancec);
rp=val;

distancec1=zeros(x1,1);    
for i = 1:x1
   diff = B(i,1:no_col-1) - h(1:no_col-1);
   distancec1(i) = sqrt(diff * diff');
end

[val ind]=max(distancec1);
rn=val;

distancec1=zeros(xu,1);    
for i = 1:xu
   diff = U(i,1:no_col-1) - k(1:no_col-1);
   distancec1(i) = sqrt(diff * diff');
end

[val ind]=max(distancec1);
ru=val;

del1=0.01;
%del2=0.01;
memb=[];
membu=[];
for i = 1:no_input
    if(obs(i) == 1)
        diff = C(i,1:no_col-1)-s ;
        dist= sqrt(diff * diff');
        memb(i,1)=1-(0.5*dist/(rp+del1));
    else
        diff = C(i,1:no_col-1)-h ;
        dist= sqrt(diff * diff');
        memb(i,1)=1-(0.5*dist/(rn+del1));
    end
end

for i = 1:xu
        diff = U(i,1:no_col-1)-k ;
        dist= sqrt(diff * diff');
        membu(i,1)=1-(0.5*dist/(ru+del1));
end
time_f=toc;

end
   