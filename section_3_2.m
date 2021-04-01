% Non Parametric Estimation 2-D Case
% Loading the data
load('lab2_2.mat');

% Initailizing given parameters 
mu = [200 200];
covar = [400 0; 0 400];
stepsize = 1;

% Setting up the meshgrid and the parzen window
[x1_a, x2_a] = meshgrid(0:1:400);
pzn_win = mvnpdf([x1_a(:) x2_a(:)], mu, covar);
pzn_win = reshape(pzn_win,length(x2_a),length(x1_a));
res = [stepsize x_min y_min x_max  y_max]; % resolution

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
title('Non-Parametric Estimation for 2D case');
xlabel('x1');
ylabel('x2');
scatter(al(:, 1), al(:, 2));
scatter(bl(:, 1), bl(:, 2));
scatter(cl(:, 1), cl(:, 2));
contour(X1, X2, nonparam_grid, 'color', 'black');
legend('Class A', 'Class B', 'Class C', 'ML Decision Boundary');
hold off;
