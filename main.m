clear all;
close all;
load('lab2_1.mat');

%Part 2: Model Estimation 1-D Case

%2.1 Parametric estimation - Gaussian
[gaus1D_mean_a, gaus1D_std_a] = gaussian1D(a)
[lambda_b_est] = exponential1D(b)
x_a = 0:0.01:(max(a)+1.5) 
x_b = 0:0.01:(max(b)+1.5)
mean_a = 5;
var_a = 1;
lambda_b = 1; 
mean_b = 1/lambda_b;
mean_b_est = 1/lambda_b_est;

%Use matlab function normpdf to find gaussian normal distribution as p(x)
%true vale
p_a_true = normpdf(x_a, mean_a, var_a);
%Use matlab function exppdf to find exponential distribution as p(x) true
%value
p_b_true = exppdf(x_b, mean_b);

%Now calclulate distributions using estimated values 
p_a_est = normpdf(x_a, gaus1D_mean_a, gaus1D_std_a);
p_b_est = exppdf(x_b, mean_b_est);

%Plot function for dataset 'a'
figure;
hold on;
plot(x_a, p_a_true);
plot(x_a, p_a_est, 'Color', 'm');
legend('Estimated p(x)','True p(x)');
title('1D Exponential Parametric Estimation Exponential dataset a');
xlabel('x'); 
ylabel('p(x)');
grid on;
hold off;

%Plot function for dataset 'b'
figure;
hold on;
plot(x_b, p_b_true);
plot(x_b, p_b_est, 'Color', 'm');
legend('Estimated p(x)','True p(x)');
title('1D Exponential Parametric Estimation Exponential dataset b');
xlabel('x'); 
ylabel('p(x)');
grid on;
hold off;