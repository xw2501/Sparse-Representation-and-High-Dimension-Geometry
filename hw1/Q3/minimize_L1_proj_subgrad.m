function x = minimize_L1_proj_subgrad( mask, y, wavelet_level, filter_type, m, n ) 

BETA = 1/50;
MAX_ITER = 800;

indx = find(mask==1);
H = 1/m/n;

done = false;

x = zeros(m, n);
k = 1;

allObj = zeros(MAX_ITER,1);

while ~done
    
    x_til = x - (BETA/sqrt(k)) * sign(x);            
    
    temp = mapping_A(wavelet_level, filter_type, x_til, indx);
    temp = temp - y;
    temp = temp / m / n;
    temp = adj_mapping_A(wavelet_level, filter_type, temp, indx, m, n);
    
    x     = x_til - temp;
    
    obj = norm(x,1);    
    allObj(k) = obj;    
        
    k = k + 1;
    
    if k > MAX_ITER
        done = true; 
    end    
end

% function x = minimize_L1_proj_subgrad( mask, y, wavelet_level, filter_type, m, n ) 
% 
% weight = 0.05;
% MAX_ITER = 300;
% 
% indx = find(mask==1);
% H = 1/m/n;
% 
% done = false;
% 
% x = zeros(m, n);
% k = 1;
% 
% allObj = zeros(MAX_ITER,1);
% 
% while ~done
%     
%     x_til = (1-weight) * x - weight * sign(x);            
%     
%     temp = mapping_A(wavelet_level, filter_type, x_til, indx);
%     temp = temp - y;
%     temp = temp / m / n;
%     temp = adj_mapping_A(wavelet_level, filter_type, temp, indx, m, n);
%     
%     x     = x_til - temp;
%     
%     obj = norm(x,1);    
%     allObj(k) = obj;    
%         
%     k = k + 1;
%     
%     if k > MAX_ITER
%         done = true; 
%     end    
% end
% 
% 
% subplot(1,3,1);
% plot(allObj);
% pause;