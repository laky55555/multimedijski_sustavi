
function matrix = testing_one(training_dir, training_file, target_path)
% testing_one Makes training set from first 2 arguments, and 
%             then find closest match between them for target file.
%             At the end program call function find_closest_matrix that make matrix.txt
%             in which is stored matrix that shows closest sign for each in traing set.
%             training_dir -> number of training directories (different people signatures).
%             training_file -> number of signatures per person for training set.
%             target_path -> path from current directory to target file.
%             Returns:
%             matrix -> NxM matrix where 

  [matrix, targ, numb] = load_data('potpisi', training_dir, training_file, target_path);
  [map, dir, matrix] = do_svd(matrix, targ, numb);
      
  fprintf('Closest match for signature from %s is in map %d, file %d.\n', target_path, map, dir);

  find_closest_matrix(matrix);  
  
end