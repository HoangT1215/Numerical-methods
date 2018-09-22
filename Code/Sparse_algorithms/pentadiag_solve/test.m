% penta solve example

clc;
clear;

% initialize matrices
tSetup = tic;
N = 10000;
L4 = -(6*diag(ones(N-4,1)) - 4*diag(ones(N-5,1),-1) - 4*diag(ones(N-5,1),1) + diag(ones(N-6,1),-2) + diag(ones(N-6,1),2));
y = [1:1:N-4];
timesetup = toc(tSetup);

tInverse = tic;
x1 = inv(L4)*y'
timeinv = toc(tInverse);

tSlash = tic;
x2 = L4\y';
timeslash = toc(tSlash);

tPenta = tic;
x3 = pentsolve(L4,y');
timepenta = toc(tPenta);


