%Code for extracting the feature vector from the images
run('load_images.m');
function blocks = divide(image, rows, cols)
  blocks = cell(rows*cols, 1);
  [imrows imcols] = size(image);
  block_rows = floor(imrows / rows);
  block_cols = floor(imcols / cols);
  for i=1:rows
    for j=1:cols
      if(i < rows & j < cols)
        block = image(((i-1)*block_rows)+1:block_rows*i, ((j-1)*block_cols)+1:block_cols*j);
      %To handle edge cases
      else
        if i==rows & j!=cols
          block = image(((i-1)*block_rows)+1:imrows, ((j-1)*block_cols)+1:block_cols*j);
        endif
        if j==cols & i!=rows
          block = image(((i-1)*block_rows)+1:block_rows*i, ((j-1)*block_cols)+1:imcols);
        endif
        if i==rows & j==cols
          block = image(((i-1)*block_rows)+1:imrows, ((j-1)*block_cols)+1:imcols);
        endif
      endif
      blocks(((i-1)*cols) + j) = block; 
    endfor
  endfor
endfunction

rows=3;
cols=3;
blocks = divide(images{1}, rows, cols);

function [x_bar y_bar] = get_block_centroid(block)
  denominator = sum(sum(block));
  [blk_rows blk_cols] = size(block);
  x_axis = (1:blk_cols)';
  x_numerator = sum(block*x_axis);
  x_bar = x_numerator/denominator;
  y_axis = (1:blk_rows);
  y_numerator = sum(y_axis*block);
  y_bar = y_numerator/denominator;
  %Normalization
  x_bar = x_bar / blk_cols;
  y_bar = y_bar / blk_rows;
endfunction

%Trying on each block of the first image
feature_matrix = zeros(rows*cols, 2);
for i=1:rows*cols
  [x_bar y_bar] = get_block_centroid(blocks{i});
  feature_matrix(i, :) = [x_bar y_bar]; 
endfor