function res = adj_mapping_A(wavelet_level, filter_type, X, indx, m, n)
    res = zeros(m*n, 1);
    res(indx) = X;
    res = reshape(res, [m, n]);
    res = ifft2(res)*m*n;
    res = wavelet_coeffs(res,filter_type,wavelet_level);
end
