% implicit method
% initialize
h1 = 1
h2 = 0.05

tau = 0
tau_limit = 10
t = 0

n = 1/h2
A = zeros(n-2,n-2)
q_old = zeros(1,n-2) % since we always have q(0) = 0 and q(1) = 1
q_new = zeros(1,n-2)
sol = zeros(1,n)
sol(1,n) = 1
aux = zeros(1,n-2)
aux(1,n-2) = h2/h1^2

for i = 1:(n-2)
  q_old(1,i) = (i*h2)^3
  A(j,j) = 1-2*h2/h1^2
    if j ~= n-2
      A(j,j+1) = -h2/h1^2
      A(j+1,j) = -h2/h1^2
    endif
endfor

% implicit method
for i = 1:h1:tau_limit
  q_new = linsolve(A, transpose(q_old.+aux))
  q_old = q_new
  q_new = zeros(1,n-2)
endfor

% plot
for i = 2:n-1
  sol(1,i) = q_old(i-1)
endfor
plot(sol)

