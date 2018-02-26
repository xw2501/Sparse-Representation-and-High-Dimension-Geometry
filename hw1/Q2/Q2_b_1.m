%% 
clc;
clear all;

%% specify parameters
% when setting parameters, you need to make sure there is inter section
% between affine set and cross-polytope, otherwise the function will go
% into an infinite loop.
v = rand(3, 1)*10 + 50;
affine_A = rand(1, 3)*5;
affine_y = rand(1, 1)*5 + 5;
l = 6;

% uncomment this part for visualization, only works when dim is lower or equal to 3 
% visualization(l, affine_A, affine_y);

%% initialize start point on affine set
v = project2affine(v, affine_A, affine_y);

%% POCS
w = POCS(v, affine_A, affine_y, l);

%% show results
fprintf('******************************************\n');
fprintf('computing results:\n');
display(w);
fprintf('l1 norm of result is %d. (This value is supposed to be less than %d).\n', norm(w, 1), l+1e-5);
fprintf('l2 norm of (Aw-y) is %d. (This value is supposed to be less than %d).\n', norm(affine_A*w-affine_y, 2), 1e-5);