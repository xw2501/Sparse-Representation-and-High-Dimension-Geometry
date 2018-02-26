% radial sampling

close all;

load image;
theta = [0.025:0.025:0.15];
% pi/20 -- 0.0401
% pi/30 -- 0.0614
% pi/40 -- 0.0804
% pi/50 -- 0.1014
% pi/60 -- 0.1199
% pi/70 -- 0.1404
% pi/80 -- 0.1587
% pi/90 -- 0.1783
% pi/100 -- 0.1962
% pi/110 -- 0.2148
rotation_angle = [pi/20 pi/30 pi/40 pi/50 pi/70 pi/80];
wavelet_level = 5;
filter_type = 'db1';

im_rec_set = cell(length(theta));

for i = 1:length(theta)
    figure,
    subplot(1,3,1);
    imagesc(abs(im));
    title('origin image');
    axis off;
    
    sample_method = 'radial';
    im_rec = resconstruction(im, theta(i), rotation_angle(i), sample_method, wavelet_level, filter_type);
    subplot(1,3,2);
    imagesc(abs(im_rec));
    title('radial');
    axis off;
    subplot(1,3,3);
    imagesc(abs(im_rec-im));
    title('difference');
    axis off;
    set(gcf, 'Position', [100 100 1500 400]);
    % saveas(gcf, ['./radial/theta_' num2str(theta(i)) '.png'], 'png');
    
    im_rec_set{i} = im_rec;
end
