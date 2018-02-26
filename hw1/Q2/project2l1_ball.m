function w = project2l1_ball(v, l)
    w = zeros(size(v));
    if(norm(v, 1)<=l)
        w = v;
        return;
    end
    %%  nlog(n)
%     u = abs(v);
%     sort_u = sort(u, 'descend');
%     rho = 0;
%     for i = 1:length(sort_u)
%         temp = sort_u(i) - (sum(sort_u(1:i))-l)/i;
%         if(temp>0)
%             rho = i;
%         else
%             break;
%         end
%     end
%     theta = (sum(sort_u(1:rho))-l)/rho;
%     for i = 1:length(w)
%         w(i) = sign(v(i))*max([(u(i)-theta) 0]);
%     end
    %% n
    sgn_v = sign(v);
    v = abs(v);
    U = linspace(1, length(v), length(v));
    s = 0;
    rho = 0;
    while(~isempty(U))
        k = randsample(U, 1);
        G = U(find(v(U)>=v(k)));
        L = setdiff(U, G);
        delt_rho = length(find(v(G)==v(k)));
        delt_s = sum(v(G));
        if((s+delt_s-(rho+delt_rho)*v(k))<l)
            s = s + delt_s;
            rho = rho + delt_rho;
            U = L;
        else
            G(find(G==k)) = [];
            U = G;
        end
    end
    theta = (s - l) / rho;
    for i = 1:length(w)
        w(i) = sgn_v(i)*max([v(i)-theta 0]);
    end
    %% a third one
%     sgn_v = sign(v);
%     v = abs(v);
%     U = linspace(1, length(v), length(v));
%     rho = (sum(v)-l)/length(v);
%     while(1)
%         pre_length = length(U);
%         U = U(find(v(U)>rho));
%         rho = (sum(v(U))-l)/length(U);
%         if(length(U)==pre_length)
%             break;
%         end
%     end
%     for i = 1:length(w)
%         w(i) = sgn_v(i)*max([v(i)-rho 0]);
%     end
end