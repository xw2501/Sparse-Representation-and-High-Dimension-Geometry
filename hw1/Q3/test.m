j = sqrt(-1);

%% test of wavelet
x = rand(64,64) + j*rand(64,64);
wave_x = wavelet_coeffs(x,'db1',2);
y = rand(64,64) + j*rand(64,64);
iwave_y = reconstruct_image(y,'db1',2);
fprintf('results of wavelet decomposition:\n');
sum(sum(x'.*iwave_y))
sum(sum(wave_x'.*y))

%% test of fft2
x = rand(64,64) + j*rand(64,64);
fft_x = fft2(x);
y = rand(64,64) + j*rand(64,64);
ifft_y = ifft2(y)*64*64;
fprintf('results of fft2:\n');
sum(sum(x'.*ifft_y))
sum(sum(fft_x'.*y))

%% test of mapping
wavelet_level = 5;
filter_type = 'db1';
indx = linspace(1, 64*64, 64*64);
x = rand(64,64) + j*rand(64,64);
map_x = mapping_A(wavelet_level, filter_type, x, indx);
y = rand(64*64, 1) + j*rand(64*64, 1);
adj_map_y = adj_mapping_A(wavelet_level, filter_type, y, indx, 64, 64);
y = reshape(y, [64 64]);
map_x = reshape(map_x, [64 64]);
fprintf('results of mapping:\n');
sum(sum(x'.*adj_map_y))
sum(sum(map_x'.*y))
