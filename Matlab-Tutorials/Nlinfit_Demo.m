% define model function - a exponential decay
modelfun = @(A,x) ( A(1) * exp(- 1/A(2)*x) + A(3) );

% Generate fake data with gaussian random error
A = [10,2,0];
X = 0:0.1:10;
Y = modelfun(A,X) + (normrnd(0,2,[1 length(X)]) - 0.5);

% Fit the data to model function
beta0 = [8,4,1];
[beta,R,J,CovB,MSE,ErrorModelInfo] = nlinfit(X,Y,modelfun,beta0);

% Get 95% error bars for the fit parameters
ci = nlparci(beta,R,'covar',CovB,'Alpha',0.05);
ci_upper = ci(:,2);
ci_lower = ci(:,1);
error_bars = (ci_upper - ci_lower) / 2;

% Get 99% error intervals for the Y
[Y_pred,delta] = nlpredci(modelfun,X,beta,R,'Covar',CovB,'Alpha',0.01);
Y_upper = Y_pred + delta;
Y_lower = Y_pred - delta;

% Output error bars for the fit parameters
disp(['1st parameter is ',num2str(beta(1)), ' with errors +- ', num2str(error_bars(1))]);
disp(['2nd parameter is ',num2str(beta(2)), ' with errors +- ', num2str(error_bars(2))]);
disp(['3rd parameter is ',num2str(beta(3)), ' with errors +- ', num2str(error_bars(3))]);

% Plot various things
figure;
subplot(2,2,1);
plot(X,Y,'b.'); 
title('Collected data');
xlabel('X'); ylabel('Y'); axis([0,10,-2,12]);
subplot(2,2,2);
plot(X,Y,'b.',X,Y_pred,'r-'); 
title('Collected data with best fit');
xlabel('X'); ylabel('Y'); axis([0,10,-2,12]);
subplot(2,2,3);
plot(X,Y,'b.',X,Y_pred,'r-',X,Y_upper,'g--',X,Y_lower,'g--');
title('upper and lower bounds, 99% Confidence levels');
xlabel('X'); ylabel('Y'); axis([0,10,-2,12]);
% For nice confidence level plots use the following function
% Note: this works only if the inputs "x, lower, and upper" have dimension 1 By N
plot_bounds = @(x,lower,upper,color) set(fill([x,x(end:-1:1)],[upper,lower(end:-1:1)],color),'EdgeColor',color);
subplot(2,2,4);
plot_bounds(X,Y_lower',Y_upper',[0.9 0.9 0.9]);
hold on;
plot(X,Y,'b.',X,Y_pred,'r-');
hold off;
title('upper and lower bounds, 99% Confidence levels');
xlabel('X'); ylabel('Y'); axis([0,10,-2,12]);