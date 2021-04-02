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