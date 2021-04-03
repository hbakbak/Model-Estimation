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

%% 2.1 Parametric estimation - Gaussian
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
title('1D Parametric Estimation Gaussian dataset a');
xlabel('x'); 
ylabel('p(x)');
grid on;
hold off;

%% 2.2 Parametric estimation - Exponential
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
title('1D Parametric Estimation Exponential dataset b');
xlabel('x'); 
ylabel('p(x)');
grid on;
hold off;

%% 2.3 Parametric estimation - Uniform (a)
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
title('1D Parametric Estimation Uniform dataset a');
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
title('1D Parametric Estimation Uniform dataset b');
xlabel('x'); 
ylabel('p(x)');
grid on;
hold off;

%% 2.4 Non-Parametric estimation - Parzen
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


%% Section 3.1 - Parametric Estimation 2D Case
% Loading the data
load('lab2_2.mat');

% Calculating mean and covariance for the datasets
mu_a = mean(al);
cov_a = cov(al); 
mu_b = mean(bl);
cov_b = cov(bl);
mu_c = mean(cl);
cov_c = cov(cl);

% Setting up the meshgrid
x_min = min([al(:,1); bl(:,1); cl(:,1)]);
y_min = min([al(:,2); bl(:,2); cl(:,2)]);
x_max = max([al(:,1); bl(:,1); cl(:,1)]);
y_max = max([al(:,2); bl(:,2); cl(:,2)]);

x_range = x_min-2:1:x_max+2;
y_range = y_min-2:1:y_max+2;

[x1, x2] = meshgrid(x_range, y_range);

% ML Parametric estimation
class_ab = ml_estimate(mu_a, cov_a, mu_b, cov_b, x1, x2);
class_bc = ml_estimate(mu_b, cov_b, mu_c, cov_c, x1, x2);
class_ac = ml_estimate(mu_a, cov_a, mu_c, cov_c, x1, x2);

param_estim = ml_classifier(x1, x2, class_ab, class_bc, class_ac);

% Plotting parametric estimate
figure(); %change figure name accordingly
hold on;
title('Parametric Estimation - 2D');
xlabel('x1');
ylabel('x2');
scatter(al(:, 1), al(:, 2));
scatter(bl(:, 1), bl(:, 2));
scatter(cl(:, 1), cl(:, 2));
contour(x1, x2, param_estim ,'color', 'black');
legend('al', 'bl', 'cl', 'ML Decision Boundary');
hold off;

%% Section 3.2 - Non Parametric Estimation 2-D Case
% Loading the data
load('lab2_2.mat');

% Initailizing given parameters 
mu = [200 200];
covar = [400 0; 0 400];

% Setting up the meshgrid and the parzen window
[x1, x2] = meshgrid(0:1:400);

x_min = min([al(:,1); bl(:,1); cl(:,1)]);
y_min = min([al(:,2); bl(:,2); cl(:,2)]);
x_max = max([al(:,1); bl(:,1); cl(:,1)]);
y_max = max([al(:,2); bl(:,2); cl(:,2)]);

pzn_win = mvnpdf([x1(:) x2(:)], mu, covar);
pzn_win = reshape(pzn_win,length(x2),length(x1));
res = [1 x_min y_min x_max  y_max]; % resolution

% Non-parametric estimate (Parzen code)
[p_a, x_a, y_a] = parzen(al, res, pzn_win);
[p_b, x_b, y_b] = parzen(bl, res, pzn_win);
[p_c, x_c, y_c] = parzen(cl, res, pzn_win);

% Adjusting meshgrid size according to the estimate
[X1, X2] = meshgrid(x_a, y_a);

nonparam_grid = ml_parzen(p_a, p_b, p_c, X1, X2);

% plotting non-parametric estimate
figure(); %change the figure number accordingly
hold on;
title('Non-Parametric Estimation - 2D');
xlabel('x1');
ylabel('x2');
scatter(al(:, 1), al(:, 2));
scatter(bl(:, 1), bl(:, 2));
scatter(cl(:, 1), cl(:, 2));
contour(X1, X2, nonparam_grid, 'color', 'black');
legend('al', 'bl', 'cl', 'ML Decision Boundary');
hold off;

%% Part 4: Sequential Discriminants
clear;
close all;
load('lab2_3.mat');
%% Load 2 classes of data: A, B
A_data4 = load('lab2_3','a');
B_data4 = load('lab2_3', 'b');
classA_part4 = A_data4.a;
classB_part4 = B_data4.b;
%% Define grid
resolution = 1;

min_x = min([min(a(:,1)) min(b(:,1))]) - resolution;
max_x = max([max(a(:,1)) max(b(:,1))]) + resolution;
min_y = min([min(a(:,2)) min(b(:,2))]) - resolution;
max_y = max([max(a(:,2)) max(b(:,2))]) + resolution;
x_range = min_x:resolution:max_x;
y_range = min_y:resolution:max_y;

[X, Y] = ndgrid(x_range, y_range);
%% Compute Sequential Classifiers
% [4.1, 4.2]
[G1, err1] = sequential_classifier(X, Y, 0, classA_part4, classB_part4);
[G2, err2] = sequential_classifier(X, Y, 0, classA_part4, classB_part4);
[G3, err3] = sequential_classifier(X, Y, 0, classA_part4, classB_part4);
%% 4.1: 3 sequential classifiers
% G1
figure(40);
scatter(classA_part4(:,1), classA_part4(:,2), 'ro');
hold on;
scatter(classB_part4(:,1), classB_part4(:,2), 'kx');
hold on;
contour(X,Y,G1,'c');
title('Sequential Classifier 1');
legend('Class A','Class B', 'Sequential Classifier');
% legend({'Class A','Class B', 'Sequential Classifier'},'location' , 'southeast');
xlabel('x1');
ylabel('x2');
hold off;

%% G2
figure(41);
scatter(classA_part4(:,1), classA_part4(:,2), 'ro');
hold on;
scatter(classB_part4(:,1),classB_part4(:,2), 'kx');
hold on;
contour(X,Y,G2,'c');
title('Sequential Classifier 2');
legend('Class A','Class B', 'Sequential Classifier');
xlabel('x1');
ylabel('x2');

%% G3
figure(42);
scatter(classA_part4(:,1), classA_part4(:,2), 'ro');
hold on;
scatter(classB_part4(:,1), classB_part4(:,2), 'kx');
hold on;
contour(X,Y,G3,'c');
title('Sequential Classifier 3');
legend('Class A','Class B', 'Sequential Classifier');
xlabel('x1');
ylabel('x2');
%% 4.2: Error of the 3 sequential classifiers
% If we test our classifier on the training data, what will its probability of error be? Discuss.
disp("Error for Sequential Classifier 1 (G1): " + err1 )
disp("Error for Sequential Classifier 2 (G2): " + err2 )
disp("Error for Sequential Classifier 3 (G3): " + err3 )
% We expect 0 error for all.
%% 4.3: Visualize how experimental error rate varies with J
[min, max, avg, std] = seq_err_analysis(X, Y, classA_part4, classB_part4);
%% Produce a plot showing ^these results as a function of J.
figure(43)

% Plot the points for: min, max, avg, std
scatter(avg(:,1), avg(:,2), 'r');
hold on;
scatter(min(:,1), min(:,2), 'b');
hold on;
scatter(max(:,1), max(:,2), 'c');
hold on;
scatter(std(:,1), std(:,2), 'm');
hold on;

% Fit a polynomial to the points to make analysis easier
% polyfit returns the coefficients for a polynomial

p1 = polyfit(avg(:,1), avg(:,2),3);
p2 = polyfit(min(:,1), min(:,2),3);
p3 = polyfit(max(:,1), max(:,2),3);
p4 = polyfit(std(:,1), std(:,2),3);

x_axis = linspace(1,5);

% evaluates the polynomial p at each point in x
y1 = polyval(p1, x_axis);
y2 = polyval(p2, x_axis);
y3 = polyval(p3, x_axis);
y4 = polyval(p4, x_axis);

% plot the polynomail
plot(x_axis, y1, 'r');
hold on;
plot(x_axis, y2, 'b');
hold on;
plot(x_axis, y3, 'c');
hold on;
plot(x_axis, y4, 'm');
hold on;

title('Experimental Error rates as a Function of J');
legend('Average Error Rate','Minimum Error Rate','Maximum Error Rate', 'Standard Deviation of the Error Rates');
xlabel('J');
ylabel('Error Rate');
