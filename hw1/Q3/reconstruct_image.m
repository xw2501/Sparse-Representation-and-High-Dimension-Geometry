function I = reconstruct_image(C,wavelet,levels)

if levels == 0
    I = C;
    return;
end

[m,n] = size(C);

CV = C((m/2)+1:m,1:(n/2));
CH = C(1:(m/2),(n/2)+1:n);
CD = C((m/2)+1:m,(n/2)+1:n);

CA = reconstruct_image( C(1:(m/2),1:(n/2) ), wavelet, levels-1);
I = idwt2(CA, CH, CV, CD, wavelet);
