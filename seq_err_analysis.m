function [min_err, max_err, avg_err, std_err] = seq_err_analysis(X,Y, A_data, B_data)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    min_err = double.empty;
    max_err = double.empty;
    avg_err = double.empty;
    std_err = double.empty;
    % For each value of J = 1:5...
    for j=1:5
        err_rates = double.empty;
        % ...learn a sequential classifier 20x to calculate...
        for i=1:20
            [Z, err] = sequential_classifier(X, Y, j, A_data, B_data);
            err_rates = horzcat(err_rates, err);
        end
        % ...the following:
        min_err = vertcat(min_err, [j min(err_rates)]);
        max_err = vertcat(max_err, [j max(err_rates)]);
        avg_err = vertcat(avg_err, [j mean(err_rates)]);
        std_err = vertcat(std_err, [j std(err_rates)]);
    end
end

