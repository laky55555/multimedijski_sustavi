

function [matrix, target, num_of_files_per_dir] = load_data(dir, num_of_subdir, num_of_files_per_dir, target_path)
% load_data Loading data from txt files to matrix, and preprocesing data for later SVD decomposition.
%           Needs input data to be in correct form. In parent directory needs directory potpisi,
%           who has directories name1, name2, ..., that have files koordinate1.txt, koordinate2.txt, ...
%           Each nameX directory needs to have at least num_of_files_per_dir files.
%           dir -> parent directory in which directory potpisi exist.
%           num_of_subdir -> number of different nameX directories. Each directory represent one person.
%           num_of_files_per_dir -> number of files (signs) with coordinates from each person we load to training set.
%           target_path -> path to file path with coordinates of sign for person we want to find.
%           Returns:
%           matrix -> loaded MxN matrix (training set) ready for SVD.
%           target -> vector Mx1 of sign we search closest match from matrix.
%           num_of_files_per_dir -> number of files (signs) with coordinates from each person we load to training set.

    % Importing data for target sign.
    target = importdata(target_path);
    
    % Calculating minimal column size for all signs. SVD needs all data to have same column dimension.
    num_of_input_rows = min(find_min_dim(dir, num_of_subdir, num_of_files_per_dir), size(target,1));
    
    % Preprocesing target vector for SVD.
    target = matrix_modification(target, num_of_input_rows);
    % From each vector we will use X coordinates, Y coordinates and time variable for comparison.
    target = cat(1, target(:,1), target(:,2), target(:,5));
    
    num_total_files = num_of_subdir * num_of_files_per_dir;
    % Preallocating space for matrix, needs 3x column size for X, Y coordinates and time.
    matrix = zeros(num_of_input_rows * 3, num_total_files);
  
    matrix = load_matrix(dir, num_of_subdir, num_of_files_per_dir, num_of_input_rows);

end


function matrix = load_matrix(dir, num_of_subdir, num_of_files_per_dir, num_of_input_rows)
% load_matrix Loading and preprocesing training set into matrix.
%             Returns loaded matrix ready for SVD.

    filename = '/koordinate';
    dirname = strcat(dir, '/name');
    appendix = '.txt';
    iterator = 1;
    for i = 1 : num_of_subdir
        for j = 1 : num_of_files_per_dir
            %strcat(dirname, int2str(i), filename, int2str(j), appendix)
            A = importdata(strcat(dirname, int2str(i), filename, int2str(j), appendix));
            A = matrix_modification(A, num_of_input_rows);
            matrix(:, iterator) = cat(1, A(:,1), A(:,2), A(:,5));
            iterator = iterator + 1;
        end
    end
end



function min = find_min_dim(dir, num_of_subdir, num_of_files_per_dir)
% find_min_dim Finding minimal column dimension for whole training set.
%              Returns minimal dimension.
    
    min = 999999;
    filename = '/koordinate';
    dirname = strcat(dir, '/name');
    appendix = '.txt';
    for i = 1 : num_of_subdir
        for j = 1 : num_of_files_per_dir
            %strcat(dirname, int2str(i), filename, int2str(j), appendix)
            dim = size(importdata(strcat(dirname, int2str(i), filename, int2str(j), appendix)));
            if min > dim(1)
                min = dim(1);
            end
        end
    end
end


function A = matrix_modification(A, dimension)
% matrix_modification Preprocesing matrix so SVD can be called on in.
%                     Preprocesing is done in following 3 steps.

    A = translate(A);
    A = normalize(A);
    A = equidistant(A, dimension);
end

function A = translate(A)
% translate Translate all coordinates that we will use to start from 0.
    A(:,1) = A(:,1) - min(A(:,1));
    A(:,2) = A(:,2) - min(A(:,2));
    A(:,5) = A(:,5) - min(A(:,5));
end

function A = normalize(A)
% normalize Normalize X and Y coordinates so all values are between 0 and 200,
%            and 0 and 100 for X and Y coordinates respectively.
    A(:,1) = A(:, 1) / (max(A(:,1))/200);
    A(:,2) = A(:, 2) / (max(A(:,2))/100);
end 

function A = equidistant(A, num)
% equidistant Remove rows from matrices that column dimension is higher then
%             lowest column dimension. Removing is done in a way so ejected rows 
%             are as far away from each other.             

    %size(A,1)
    diff = size(A,1) - num;
    if diff > 0
        % Preallocated memory in which is saved which rows are for removing.
        remove = zeros(1, diff);
        remove(1) = floor((size(A,1)/diff)/2);
        
        if remove(1) == 0
          %fprintf('WARNING! File has %d rows, and we need to remove %d rows. We are ejecting more then half rows.\n', size(A,1), diff);
          remove(1) = 1;
        end
        
        hop = floor(size(A,1)/diff);
        for i = 2 : diff
            remove(i) = remove(i-1) + hop; 
        end
        
        %A = removerows(A,'ind', remove);
        A(remove, :) = [];
        
    end
end


