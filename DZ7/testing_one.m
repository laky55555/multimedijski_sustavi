
function testing_one(training_dir, training_file, target_path)
% testing_one Makes training set from first 2 arguments, and 
%             then find closest match between them for target file.
%             training_dir -> number of training directories (different people signatures).
%             training_file -> number of signatures per person for training set.
%             target_path -> path from current directory to target file.


  [mat, targ, numb] = load_data('potpisi', training_dir, training_file, target_path);
  [mat, dir] = do_svd(mat, targ, numb);
      
  fprintf('Closest match for signature from %s is in map %d, file %d.\n', target_path, mat, dir);

  
end