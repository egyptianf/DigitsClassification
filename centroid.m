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
size(images{2})
blocks = divide(images{3}, 3, 3);
