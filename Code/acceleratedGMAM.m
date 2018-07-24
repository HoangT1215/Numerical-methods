%% (accelerated) gMAM 1 piece, applied to the 2D toy system
% great acceleration seen in gMAM
clear all

%% parameters
n = 100;       % total points on the path = n+1
h = 5e-5;      % evolution time step; this should be < 1/n^2

xA=[0;-1];
xB=[0;1];

MaxSteps=1000000;  % max steps for path evolution
TolErr=1e-6;    % termination tolerance
plotFrequency=100;

%% initialization
x=(xB-xA)*linspace(0,1,n+1)+xA*ones(1,n+1);

% initial plot
clf
subplot(1,2,1);
data=line(x(2,:),x(1,:));
hold on;
scatter(-1,0,'g');
scatter(1,0,'g');
axis([-1.2 1.2 -1.2 1.2]);
xlabel('z');    ylabel('r');
drawnow

%% accelerated gradient descent of gMAM functional
y=x;

lambda=zeros(1,n+1);
lambda_t=zeros(1,n+1);
drift=zeros(2,n+1);
gradb=zeros(2,2,n+1);

for i=1:MaxSteps
    x_ = x;

    % evolution
    vectorb=[1-x(2,:).^2-x(1,:); x(2,:)-x(2,:).^3];
    gradb(1,1,:)=-1;
    gradb(1,2,:)=-2*x(2,:);
    gradb(2,1,:)=0;
    gradb(2,2,:)=1-3*x(2,:).^2;

    x_t=(circshift(x,[0 -1])-circshift(x,[0 1]))/2*n;
    x_t(:,1)=0;   x_t(:,n+1)=0;
    x_tt=(circshift(x,[0 -1])-2*x+circshift(x,[0 1]))*n*n;
    x_tt(:,1)=0;  x_tt(:,n+1)=0;
    numerator=sqrt(sum(vectorb.^2));
    denominator=sqrt(sum(x_t.^2));
    lambda(2:n)=numerator(2:n)./denominator(2:n);
    lambda_t(2:n)=(lambda(3:n+1)-lambda(1:n-1))/2*n;
    lambda_t(2)=(lambda(3)-lambda(2))*n;
    lambda_t(n)=(lambda(n)-lambda(n-1))*n;

    inc=zeros(size(x));
    for j=2:n
        inc(:,j)=lambda(j)*(x(:,j+1)-2*x(:,j)+x(:,j-1))*n^2 - (gradb(:,:,j)-gradb(:,:,j)')*x_t(:,j) - gradb(:,:,j)'*vectorb(:,j)/lambda(j) + lambda_t(j)*x_t(:,j); % modified explicit
    end
    % accelerated gradient descent
    y_=y;
    y=x+h*inc;
    x=y+(i-1)/(i+2)*(y-y_);
    % regular gradient descent
%     x=x+h*inc;
    
    % reparametrization
    dx(:,2:n+1) = x(:,2:n+1)-x(:,1:n);
    dx(:,1) = 0;
    lxy = cumsum(sqrt(sum(dx.^2)));
    lxy = lxy/lxy(n+1);
    x = interp1(lxy,x',[0:1/n:1])';

    change = sqrt(sum(sum((x-x_).^2))/2/(n+1))/h;
    if change <= TolErr; break; end;

    % plot
    if mod(i, plotFrequency)==0
        subplot(1,2,1);
        set(data,'xdata',x(2,:),'ydata',x(1,:))
        title(['Steps=',num2str(i),' Change=',num2str(change)]);

        subplot(1,2,2);
        x_t=(circshift(x,[0 -1])-circshift(x,[0 1]))/2*n;
        x_t(:,1)=0;   x_t(:,n+1)=0;
        vectorb=[1-x(2,:).^2-x(1,:); x(2,:)-x(2,:).^3];
        integrand=(sqrt(sum(x_t.^2)).*sqrt(sum(vectorb.^2))-sum(x_t.*vectorb));
        action=(sum(integrand)-integrand(1)/2-integrand(end)/2)/n;
        plot(0:1/n:1,integrand);
        title(['Integrand of action (action=',num2str(action),')']);

        drawnow;
    end
end

%%
disp(['Steps=',num2str(i),' action=',num2str(action)]);

return;

%%
data=line(x(2,:),x(1,:));
set(gca,'FontSize',16);
hold on;
scatter(-1,0,'g','filled');
scatter(1,0,'g','filled');
scatter(0,1,'r','filled');
axis([-1.2 1.2 -0.5 1.2]);
xlabel('z','FontSize',16);
ylabel('r','FontSize',16);
title(['Action=',num2str(action)],'FontSize',16);
