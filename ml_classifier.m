function [c] = ml_classifier(x, y, c_12, c_23, c_13)
    % Classifying the sample points using the ML estimated distribution
	c = zeros(size(x,1), size(y,2));    
	for i = 1:size(x,1)
        	for j = 1:size(y,2)
			if c_12(i,j) >= 0 && c_23(i,j) <= 0
				c(i,j) = 1;
			elseif c_23(i,j) >= 0 && c_13(i,j) <= 0
				c(i,j) = 2;
			elseif c_13(i,j) >= 0 && c_12(i,j) <= 0
				c(i,j) = 3;
			end
		end
	end
end
