function w = project2affine(v, A, y)
    w = v - A'*pinv(A*A')*(A*v-y);
end