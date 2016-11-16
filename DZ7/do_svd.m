
function [map, file] = do_svd(matrix, target, number_of_subdir)
% do_svd  Finds column in matrix that is closest by norm 2 to target vector.
%         matrix -> matrix in which we search for closest match (MxN).
%         target -> vector for which we search closest match (Mx1).
%         number_of_subdir -> number of different people from which we chose match.
%         Returns from which map and which file the closest match come from.
%         Program assumes that training data (columns in matrix) has following struction:
%         m * n columns where m is number of training data from each person, and 
%         n is number of different people.
%         Inspiration for algorithm http://epubs.siam.org/doi/pdf/10.1137/S0036144501387517



    % Calculating mean for each row.
    average = mean(matrix, 2);
        
    
    % Subtracting mean from each coordinate (for why check article).
    matrix = matrix - average;
    target = target - average;
    
    % Calculating SVD
    [U, S, V] = svd(matrix);
        
    
    % Making representation of each signature in columns.
    % y = U^T * matrix
    matrix = transpose(U) * matrix;
    target = transpose(U) * target;
    
    % Searching for column closest by norm 2 to target vector.
    matrix = matrix - target;
    % Norm for each column.
    matrix = sqrt(sum(abs(matrix).^2,1));
    % Finding min value and position.
    [min, position] = min(matrix);
    
    % Calculating from which map and directory closest match come.
    map = ceil(position/ number_of_subdir);
    file = mod(position, number_of_subdir);
    if file == 0
        file = number_of_subdir;
    end 
    
end
