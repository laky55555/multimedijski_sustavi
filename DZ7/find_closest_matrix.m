
function close_matrix = find_closest_matrix(matrix)
% find_closest_match For each column in matrix finds losest by norm 2 column,
%                    and write those data in txt file matrix.txt.
%                    matrix -> matrix on which we will find closest columns.
%                    close_matrix -> 0/1 matrix that mark positions of closest columns.


  fileID = fopen('matrix.txt', 'w');
  
  close_matrix = zeros(size(matrix, 2));
  
  for i = 1 : size(close_matrix, 2)
    fprintf(fileID,'\t%d', i);
  end
  fprintf(fileID,'\n');


  for i = 1 : size(close_matrix, 2)
    closest = find_closest_match(matrix, i);
    close_matrix(i, closest) = 1;
    
    fprintf(fileID,'%d', i);
    for j = 1 : size(close_matrix, 2)
      if j == closest
        fprintf(fileID,'\t1');
      else
        fprintf(fileID,'\t0');
      end      
    end
    fprintf(fileID,'\n');
    
    
  end

  fclose(fileID);

end



function closest = find_closest_match(matrix, position)
% Finding second minimal element in a row

  
  target = matrix(:, position);
  matrix = matrix - target;
  
  % Norm for each column.
  matrix = sqrt(sum(abs(matrix).^2,1));
  
  matrix(position) = max(matrix);
  
  % Finding min value and position.
  [min, closest] = min(matrix);
  
  
end