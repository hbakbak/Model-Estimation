function [discriminant] = ml_estimate(mu_1, cov_1, mu_2, cov_2, X, Y)
	% Using the discriminant function for the ML decision boundary
	% classifier
	discriminant = zeros(size(X, 1), size(Y,2));

	for i = 1:size(X, 1)
        for j = 1:size(Y,2)
			x = [X(i, j), Y(i, j)]; 
            discriminant(i,j) = x*(inv(cov_1) - inv(cov_2))* x' + (2*(mu_2*inv(cov_2) - mu_1*inv(cov_1)))*x' + (mu_1*inv(cov_1)*mu_1' - mu_2*inv(cov_2)*mu_2'); %ml estimate formula
        end
    end
end
