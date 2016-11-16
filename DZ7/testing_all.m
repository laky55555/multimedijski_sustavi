
function testing_all(training_dir, training_file, num_dir, num_file)
% testing_all Makes training set from first 2 arguments and then tests all data from
%             second 2 arguments on training set.
%             training_dir -> number of training directories (different people signatures).
%             training_file -> number of signatures per person for training set.
%             num_dir -> number of directories in which we will look for signatures.
%             num_file -> number of files from each directories on which we will test data.


  for i = 1:num_dir
    for j = 1:num_file
     
      [mat, targ, numb] = load_data('potpisi', training_dir, training_file, strcat('potpisi/name', int2str(i), '/koordinate', int2str(j), '.txt'));
      [mat, dir] = do_svd(mat, targ, numb);
      
      fprintf('Signature from (map, file), closest match from (map, file). (%d, %d) -> (%d, %d).\n', i, j, mat, dir);

    end

  end
end