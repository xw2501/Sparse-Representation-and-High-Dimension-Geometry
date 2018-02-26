function [res, hold_off] = mapping_A(wavelet_level, filter_type, X, indx)
    temp = reconstruct_image(X,filter_type,wavelet_level);
    temp = fft2(temp);
    temp = reshape(temp, [size(temp,1)*size(temp,2), 1]);
    res = temp(indx);
    hold_off = temp(setdiff(linspace(1, length(temp), length(temp)), indx));
end