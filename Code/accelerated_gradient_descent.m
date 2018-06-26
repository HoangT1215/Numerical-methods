% Accelerated gradient descent
clc;
clear;

% initialize
syms x,y
f = (x-1)^2 + 100*(y-x^2)^2
step = 0.01
x0 = 0
y0 = 0

% algorithm
step = backtrackinglinesearch(f)

