clc;
clear all;
close all;          
            
for load_file = 1:2
    %% initializing variables
    %% to load file
    switch load_file
     
		case 1
            file = 'ecoli-0-1_vs_5';
            test_start =121;
            cvs1=10^-5;
			cvs2=10^-2;
            eps1=0.2;
            mus=16;
			
		case 2
			file = 'ecoli-0-1-4-7_vs_5-6';
            test_start =151;
			cvs1=1;
			cvs2=10^-2;
            eps1=0.6;
            mus=32;
            
        otherwise
            continue;
    end
         uvs1=[0.1];
%Data file call from folder   
filename = strcat('./newd/',file,'.txt');
    A = load(filename);
    [m,n] = size(A);
%define the class level +1 or -1    
    for i=1:m
        if A(i,n)==0
            A(i,n)=-1;
        end
    end
% Dividing the data in training and testing   
test_start=m/2;
    test = A(test_start:m,:);
    train = A(1:test_start-1,:);

    [no_input,no_col] = size(train);
  
    x1 = train(:,1:no_col-1);
    y1 = train(:,no_col);
	    
    [no_test,no_col] = size(test);
    xtest0 = test(:,1:no_col-1);
    ytest0 = test(:,no_col);

%Combining all the column in one variable
    A=[x1 y1];    %training data
    A_test=[xtest0,ytest0];    %testing data

%%%%%%%%%%%%%%Universum genearation    
     [no_input,no_col]=size(A);
  obs = A(:,no_col);   
    C=A;
    A = [];
 B = [];
 u=ceil(uvs1*(test_start-1));
for i = 1:no_input
    if(obs(i) == 1)
        A = [A;C(i,1:no_col-1)];
    else
        B = [B;C(i,1:no_col-1)];
    end;
end;

sb1=size(A,1);
sb=size(B,1);
ptb1=sb1/u;
ptb=sb/u;
Au=A(1:ptb1:sb1,:);
Bu=B(1:ptb:sb,:);
di=size(Au,1)-size(Bu,1);
if(di>0)
Bu=[Bu ;Bu(1:abs(di),:)];
elseif(di<0)
Au=[Au ;Au(1:abs(di),:)];
end   
 U=(Au+Bu)/2;   
   A=C;
    
 [accuracy,ytest,yprediction,time] = FULSTSVM(A,A_test,U,csv1, cvs2, eps1, mus);
 
 
end
 