function C = wavelet_coeffs(I,wavelet,levels)

if levels == 0,
    C = I;
    return;
end

[A,H,V,D] = dwt2(I,wavelet);

C = [ wavelet_coeffs(A,wavelet,levels-1), H; V, D ];

