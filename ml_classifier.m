function [class] = ml_classifier(x, y, class12, class23, class13)
	class = zeros(size(x,1), size(y,2));    
	for i = 1:size(x,1)
        	for j = 1:size(y,2)
			if class12(i,j) >= 0 && class23(i,j) <= 0
				class(i,j) = 1;
			elseif class23(i,j) >= 0 && class13(i,j) <= 0
				class(i,j) = 2;
			elseif class13(i,j) >= 0 && class12(i,j) <= 0
				class(i,j) = 3;
			end
		end
	end
end
