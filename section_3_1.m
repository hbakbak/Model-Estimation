% FOR PARAMETRIC ESTIMATION - 2D Case
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
title('Parametric Estimation for 2D Case');
xlabel('x1');
ylabel('x2');
scatter(al(:, 1), al(:, 2));
scatter(bl(:, 1), bl(:, 2));
scatter(cl(:, 1), cl(:, 2));
contour(x1, x2, param_estim ,'color', 'black');
legend('Class A', 'Class B', 'Class C', 'ML Decision Boundary');
hold off;



