%% specify parameters

m = 25;
n = 10;

v = rand(n, 1);
affine_A = rand(m, n);
affine_y = rand(m, 1);
l = rand(1, 1);

tol = 1e-5;
upt_step = 1e-2;
count = 0;

%% computing minimum l1-norm

while(1)
    count = count + 1;
    
    w = POCS_upt(v, affine_A, affine_y, l);
    
    if((norm(w, 1)-l)<tol)
        break;
    else
        l = l + upt_step*(norm(w, 1)-l);
    end
    
end

fprintf('******************************************\n');
fprintf('computation took %d loops.\n', count);
fprintf('norm computed by expanding l1-ball is %d.\n', l);


%% a simple test

v = rand(n, 1);
w = POCS(v, affine_A, affine_y, l);

fprintf('norm from test is %d. This value is supposed to be the same as %d.\n', norm(w, 1), l);
