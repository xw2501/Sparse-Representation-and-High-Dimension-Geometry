% variable density sampling

close all;

load image;
theta = [0.025:0.025:0.15];
rotation_angle = pi/60;
wavelet_level = 5;
filter_type = 'db1';

im_rec_set = cell(length(theta));

for i = 1:length(theta)
    figure,
    subplot(1,3,1);
    imagesc(abs(im));
    title('origin image');
    axis off;
    
    sample_method = 'variable_density';
    im_rec = resconstruction(im, theta(i), rotation_angle, sample_method, wavelet_level, filter_type);
    subplot(1,3,2);
    imagesc(abs(im_rec));
    title('variable density');
    axis off;
    subplot(1,3,3);
    imagesc(abs(im_rec-im));
    title('difference');
    axis off;
    set(gcf, 'Position', [100 100 1500 400]);
    % saveas(gcf, ['./variable density/test_theta_' num2str(theta(i)) '.png'], 'png');
    
    im_rec_set{i} = im_rec;
end
