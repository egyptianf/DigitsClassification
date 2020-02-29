# Prevent Octave from thinking that this
# is a function file:

1;
function images = read_data()
  images = cell(100, 1);

  dir = "dataset/";
  for i=1:10
    for j=1:10
      img_loc = strcat(dir, num2str(i-1), "_", num2str(j), ".bmp");
      image = ! imread(img_loc);
      image_cell = mat2cell(image, size(image)(1), size(image)(2));
      images(((i-1)*10) + j) = image_cell;
    end
  end
endfunction
images = read_data();
save images.mat images;