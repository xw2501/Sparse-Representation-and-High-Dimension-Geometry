function im_rec = resconstruction(im, theta, rotation_angle, sample_method, wavelet_level, filter_type)

points_tobe_sampled = round(size(im,1)*size(im,2)*theta);

%%

if(strcmp(sample_method, 'bernoulli'))
    mask = zeros(size(im));
    indx = linspace(1, size(im,1)*size(im,2), size(im,1)*size(im,2));
    indx = randsample(indx, points_tobe_sampled);
    mask(indx) = 1;
elseif(strcmp(sample_method, 'variable_density'))
    map = zeros(size(im));
    map(1,1) = 1;
    map(size(im,1),1) = 1;
    map(1,size(im,2)) = 1;
    map(size(im,1),size(im,2)) = 1;
    map = bwdist(map)+1;
    map = ones(size(map))./map;
    indx = linspace(1, size(im,1)*size(im,2), size(im,1)*size(im,2));
    indx = randsample(indx, points_tobe_sampled, true, reshape(map, [size(im,1)*size(im,2), 1]));
    mask = zeros(size(im));
    mask(indx) = 1;
elseif(strcmp(sample_method, 'radial'))
    mask = zeros(size(im));
    start_y = round(size(im, 1)/2);
    start_x = round(size(im, 2)/2);
    for i = rotation_angle:rotation_angle:2*pi
        offset = 0;
        while(1)
            indx_x = start_x+round(offset*cos(i));
            indx_y = start_y-round(offset*sin(i));
            if(indx_x>size(im,2) || indx_x<1 || indx_y>size(im,1) || indx_y<1)
                break;
            end
            mask(indx_y, indx_x) = 1;
            offset = offset + 1;
        end
    end
    indx = find(mask==1);
    indx = randsample(indx, points_tobe_sampled);
    mask = zeros(size(im));
    mask(indx) = 1;
    mask = ifftshift(mask);
else
    error('sample method does not exist');
end


indx = find(mask==1);
y = reshape(fft2(im), [size(im,1)*size(im,2), 1]);
y = y(indx);

%% ifft2 test
% y = fft2(im).*mask;
% im_rec = ifft2(y);

%% main loop
w = minimize_L1_proj_subgrad( mask, y, wavelet_level, filter_type, size(im, 1), size(im, 2) );

im_rec = reconstruct_image(w,filter_type,wavelet_level);

%% generate operator
% u = rand(size(im));
% u(u>=theta) = 1;
% u(u<theta) = 0;
% u = 1-u;
% indx = find(u==1);
% dist_map = zeros(size(im));
% dist_map(size(im,1)/2:size(im,1)/2+1, size(im,1)/2:size(im,1)/2+1) = 1;
% dist_map = bwdist(dist_map);
% dist_map = dist_map / max(max(dist_map));
% u = dist_map; %rand(size(im)).*dist_map;
% u(u>(1-theta)) = 1;
% u(u~=1) = 0;
% indx = find(u==1);
% 
% 
% y = zeros(length(indx), 1);
% a = zeros(length(indx), length(X));
% fft_x = fft2(im);
% fprintf('total length: %d \n', length(indx));
% 
% for i = 1:length(indx)
%     m = mod(indx(i)-1, size(im, 1));
%     n = floor((indx(i)-1)/size(im, 1));
%     for u = 1:size(im, 1)
%         for v = 1:size(im, 1)
%             a(i, (u-1)*size(im, 1)+v) = exp(-j*2*pi/size(im, 1)*(m*(u-1)+n*(v-1)));
%         end
%     end
% end
% 
% y = a*X;
% fprintf('preprocessing done!\n');
