%% preprocess
% compress image
% origin image size is too large

compress_rate = 1/4;

load image;

image_comp = zeros(size(im)*compress_rate);

for i = 1:size(image_comp, 1)
    for j = 1:size(image_comp, 2)
        block = im(((i-1)/compress_rate+1):(i/compress_rate), ((j-1)/compress_rate+1):(j/compress_rate));
        block = reshape(block, [1/compress_rate/compress_rate, 1]);
        [~,indx] = max(abs(block));
        image_comp(i, j) = block(indx);
    end
end

figure,
imagesc(abs(image_comp));
title('image after compress');

save('image_comp', 'image_comp');