%% parameters
m = 100;
n = 60;
non_empty_entry = 24;

A = rand(m, n);
x = zeros(n, 1);

indxs = randsample(linspace(1, n, n), non_empty_entry);
x(indxs) = rand(non_empty_entry, 1);
y = A*x;

%% demo
fprintf('results given by demo.\n');
tic
x_lecture = minimize_L1_proj_subgrad(A, y);
toc

figure,
title('demo result');

subplot(1,3,1);
stem(x_lecture);
title('prediction');
xlabel('entry');
ylabel('value');

subplot(1,3,2);
stem(x);
title('ground truth');
xlabel('entry');
ylabel('value');

subplot(1,3,3);
stem(abs(x_lecture-x));
title('diff');
xlabel('entry');
ylabel('value');


%% b. iii

tol = 1e-5;
v = rand(size(x));
l = 0;
upt_step = 1;

fprintf('results given by new algorithm.\n');
tic
while(1)
    
    w = POCS_upt(v, A, y, l);
    
    if((norm(w, 1)-l)<tol)
        break;
    else
        l = l + upt_step*(norm(w, 1)-l);
    end
    
end

w = POCS(v, A, y, l);
toc

figure,
title('b. iii. result');

subplot(1,3,1);
stem(w);
title('prediction');
xlabel('entry');
ylabel('value');

subplot(1,3,2);
stem(x);
title('ground truth');
xlabel('entry');
ylabel('value');

subplot(1,3,3);
stem(abs(w-x));
title('diff');
xlabel('entry');
ylabel('value');