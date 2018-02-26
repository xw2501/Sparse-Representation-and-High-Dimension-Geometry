%% init
l = 0;
A = 0;
B = 3;  % do not set this parameter to 0
C = 0;  
D = 24;
affine_A = [A B C];
affine_y = D;
figure,

tol = 1e-5;
v = rand(3, 1);
upt_step = 0.1;

%% main loop
while(1)
    
    w = POCS_upt(v, affine_A, affine_y, l);
    
    if((norm(w, 1)-l)<tol)
        break;
    else
        l = l + upt_step*(norm(w, 1)-l);
    end
    
    upt_show(l, affine_A, affine_y);
    pause(0.05);
    
end


function upt_show(l, affine_A, affine_y)
    
    clf;
    view(3);
    
    A = affine_A(1);
    B = affine_A(2);
    C = affine_A(3);
    D = affine_y;

%     % create a figure
%     figure,

    % plot the cross polytope

    pos_x = [l,0,0];
    pos_y = [0,l,0];
    pos_z = [0,0,l];
    neg_x = [-l,0,0];
    neg_y = [0,-l,0];
    neg_z = [0,0,-l];
    hold on;
    patch([pos_x(1) pos_y(1) pos_z(1) pos_x(1)], [pos_x(2) pos_y(2) pos_z(2) pos_x(2)], [pos_x(3) pos_y(3) pos_z(3) pos_x(3)], 'c');
    patch([pos_x(1) neg_y(1) pos_z(1) pos_x(1)], [pos_x(2) neg_y(2) pos_z(2) pos_x(2)], [pos_x(3) neg_y(3) pos_z(3) pos_x(3)], 'c');
    patch([neg_x(1) pos_y(1) pos_z(1) neg_x(1)], [neg_x(2) pos_y(2) pos_z(2) neg_x(2)], [neg_x(3) pos_y(3) pos_z(3) neg_x(3)], 'c');
    patch([neg_x(1) neg_y(1) pos_z(1) neg_x(1)], [neg_x(2) neg_y(2) pos_z(2) neg_x(2)], [neg_x(3) neg_y(3) pos_z(3) neg_x(3)], 'c');
    patch([pos_x(1) pos_y(1) neg_z(1) pos_x(1)], [pos_x(2) pos_y(2) neg_z(2) pos_x(2)], [pos_x(3) pos_y(3) neg_z(3) pos_x(3)], 'c');
    patch([pos_x(1) neg_y(1) neg_z(1) pos_x(1)], [pos_x(2) neg_y(2) neg_z(2) pos_x(2)], [pos_x(3) neg_y(3) neg_z(3) pos_x(3)], 'c');
    patch([neg_x(1) pos_y(1) neg_z(1) neg_x(1)], [neg_x(2) pos_y(2) neg_z(2) neg_x(2)], [neg_x(3) pos_y(3) neg_z(3) neg_x(3)], 'c');
    patch([neg_x(1) neg_y(1) neg_z(1) neg_x(1)], [neg_x(2) neg_y(2) neg_z(2) neg_x(2)], [neg_x(3) neg_y(3) neg_z(3) neg_x(3)], 'c');

    % plot the plane

    point_1 = [100,NaN,100];
    point_2 = [100,NaN,-100];
    point_3 = [-100,NaN,-100];
    point_4 = [-100,NaN,100];
    point_1(2) = (D - point_1(1)*A - point_1(3)*C) / B;
    point_2(2) = (D - point_2(1)*A - point_2(3)*C) / B;
    point_3(2) = (D - point_3(1)*A - point_3(3)*C) / B;
    point_4(2) = (D - point_4(1)*A - point_4(3)*C) / B;
    patch([point_1(1) point_2(1) point_3(1) point_4(1) point_1(1)], [point_1(2) point_2(2) point_3(2) point_4(2) point_1(2)],...
        [point_1(3) point_2(3) point_3(3) point_4(3) point_1(3)], 'y');

    axis([-10 10 -10 10 -10 10]);
    xlabel('x-axis');
    ylabel('y-axis');
    zlabel('z-axis');
    grid on;

end