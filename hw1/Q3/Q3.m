close all;

load image;
thetas = [0.05:0.05:0.2];
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
rotation_angles = [pi/30 pi/50 pi/80 pi/110];
wavelet_level = 5;
filter_type = 'db1';

for i = 1:length(thetas)
    
    theta = thetas(i);
    rotation_angle = rotation_angles(i);
    
    figure,
    subplot(3,3,4);
    imagesc(abs(im));
    title('origin image');
    axis off;
    
    sample_method = 'bernoulli';
    im_rec = resconstruction(im, theta, rotation_angle, sample_method, wavelet_level, filter_type);
    subplot(3,3,2);
    imagesc(abs(im_rec));
    title('bernoulli sampling');
    axis off;
    subplot(3,3,3);
    imagesc(abs(im_rec-im));
    title('difference');
    axis off;
    
    
    sample_method = 'variable_density';
    im_rec = resconstruction(im, theta, rotation_angle, sample_method, wavelet_level, filter_type);
    subplot(3,3,5);
    imagesc(abs(im_rec));
    title('variable density');
    axis off;
    subplot(3,3,6);
    imagesc(abs(im_rec-im));
    title('difference');
    axis off;
    
    sample_method = 'radial';
    im_rec = resconstruction(im, theta, rotation_angle, sample_method, wavelet_level, filter_type);
    subplot(3,3,8);
    imagesc(abs(im_rec));
    title('radial');
    axis off;
    subplot(3,3,9);
    imagesc(abs(im_rec-im));
    title('difference');
    axis off;
    
    % saveas(gcf, ['./compare/theta_' num2str(theta) '.png'], 'png');
    
end
