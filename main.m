clear all;
close all;
load('lab2_1.mat');

%Part 2: Model Estimation 1-D Case
x_a = 0:0.01:(max(a)+1.5) 
x_b = 0:0.01:(max(b)+1.5)
mean_a = 5;
var_a = 1;
lambda_b = 1; 
mean_b = 1/lambda_b;

%2.1 Parametric estimation - Gaussian
[gaus1D_mean_a, gaus1D_std_a] = gaussian1D(a)

%Use matlab function normpdf to find gaussian normal distribution as p(x)
%true vale
p_a_true = normpdf(x_a, mean_a, var_a);

%Now calclulate distributions using estimated values 
p_a_est = normpdf(x_a, gaus1D_mean_a, gaus1D_std_a);

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

%2.2 Parametric estimation - Exponential
[lambda_b_est] = exponential1D(b);

%Use matlab function exppdf to find exponential distribution as p(x) true
%value
p_b_true = exppdf(x_b, mean_b);

%Now calclulate distributions using estimated values 
mean_b_est = 1/lambda_b_est;
p_b_est = exppdf(x_b, mean_b_est);

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

%2.3 Parametric estimation - Uniform (a)
[unif1D_a, unif1D_b] = uniform1D(a);

%Use matlab function unifpdf to find uniform distribution estimated value
%(a)
p_a_est_unif = unifpdf(x_a, unif1D_a, unif1D_b);

%repeat for dataset b
[unif1D_a, unif1D_b] = uniform1D(b);

%Use matlab function unifpdf to find uniform distribution estimated value
%(b)
p_b_est_unif = unifpdf(x_b, unif1D_a, unif1D_b);

%Plot function for dataset 'a'
figure;
hold on;
plot(x_a, p_a_true);
plot(x_a, p_a_est_unif, 'Color', 'm');
legend('Estimated p(x)','True p(x)');
title('1D Exponential Parametric Estimation Uniform dataset a');
xlabel('x'); 
ylabel('p(x)');
grid on;
hold off;

%Plot function for dataset 'b'
figure;
hold on;
plot(x_b, p_b_true);
plot(x_b, p_b_est_unif, 'Color', 'm');
legend('Estimated p(x)','True p(x)');
title('1D Exponential Parametric Estimation Uniform dataset b');
xlabel('x'); 
ylabel('p(x)');
grid on;
hold off;

%2.4 Non-Parametric estimation - Parzen
std1 = 0.1;
std2 = 0.4; 

%Solve for densities using parzen window estimation 
[density1_a] = parzen1D(a,std1);
[density2_a] = parzen1D(a,std2);

[density1_b] = parzen1D(b,std1);
[density2_b] = parzen1D(b,std2);

%Plot function for std = 0.1
figure;
title('Non Parametric Estimation (std = 0.1)');
hold on;
plot(x_a, density1_a);
plot(x_b, density1_b);
plot(x_a,p_a_true, 'Color', 'm');
plot(x_b, p_b_true, 'Color', 'b');
legend('Estimated p(x) - a','Estimated p(x) - b','True p(x) - a', 'True p(x) - b');
xlabel('x'); 
ylabel('p(x)');
grid on;
hold off;

%Plot function for std = 0.4
figure;
title('Non Parametric Estimation (std = 0.4)');
hold on;
plot(x_a, density2_a);
plot(x_b, density2_b);
plot(x_a,p_a_true, 'Color', 'm');
plot(x_b, p_b_true, 'Color', 'b');
legend('Estimated p(x) - a','Estimated p(x) - b','True p(x) - a', 'True p(x) - b');
xlabel('x'); 
ylabel('p(x)');
grid on;
hold off;
