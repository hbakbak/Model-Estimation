function [c] = ml_parzen(p1, p2, p3, X, Y)
    % Classifying the sample points using the parzen 2D pdf estimations
    c = zeros(size(X));  
    for i = 1:size(X,1)
        for j = 1:size(Y,2)
            [ml, labelled_class] = max([p1(i,j), p2(i,j), p3(i,j)]);
            c(i,j) = labelled_class;
        end
    end
end