%Code for extracting the feature vector from the images
run('load_images.m');
function blocks = divide(image, rows, cols)
  blocks = cell(rows*cols, 1);
  [imrows imcols] = size(image);
  block_rows = imrows / rows;
  block_cols = imcols / cols;
  for i=1:rows
    for j=1:cols
      %first block
      block = image(((i-1)*9)+1:block_rows*i, ((j-1)*9)+1:block_cols*j);
      blocks(((i-1)*cols) + j) = block;
    endfor
  endfor
endfunction
blocks = divide(images{1}, 3, 3);
