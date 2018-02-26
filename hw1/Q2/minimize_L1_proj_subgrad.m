function x = minimize_L1_proj_subgrad( A, y ) 

% minimize_L1_proj_subgrad
%
%    Solve the L1 minimization problem 
%      
%       min ||x||_1  st A x = y 
%
%    Using a projected subgradient algorithm 
%
% Fall 2012, John Wright
%
%%%%

%%%% WARNING: This is one of the simplest algorithms you can write down for
%%%% this problem, but its convergence rate is not particularly good. 
%%%% 
%%%% Later in the class, we will look at alternatives with similar computational cost,
%%%% but much better rates of convergence. 

BETA = 1/50;
MAX_ITER = 50000;

[m,n] = size(A);

H = A' * pinv( A * A' );

numIter = 0;
done    = false;

x = zeros(n,1);
k = 1;

allObj = zeros(MAX_ITER,1);

while ~done, 
    
    x_til = x - (BETA/sqrt(k)) * sign(x);            
    x     = x_til - H * ( A * x_til - y );
    
    obj = norm(x,1);    
    allObj(k) = obj;    
        
    k = k + 1;
    
    if k > MAX_ITER, 
        done = true; 
    end    
end

%figure(1);
%plot(allObj);
%pause;