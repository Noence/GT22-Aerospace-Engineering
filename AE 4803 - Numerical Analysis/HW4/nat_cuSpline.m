%% Natural cubic spline calculator
% By: Noe Lepez Da Silva Duarte
% Created: 07 March 2022

function [coeffs, soln] = nat_cuSpline(x_list,y_list, x)

mat_size = ((length(x_list)-1)*4);
spline_mat = [0 0 2 6*x_list(1) zeros(1,mat_size-4)];
y_vec = [0];
i = 1;

while i < length(x_list)
    if i == 1
        spline_mat = [spline_mat;
                      1, x_list(i), x_list(i)^2, x_list(i)^3, zeros(1, mat_size-4*(i-1)-4);
                      1, x_list(i+1), x_list(i+1)^2, x_list(i+1)^3, zeros(1, mat_size-4*(i-1)-4);
                      0, 1, 2*x_list(i+1), 3*x_list(i+1)^2, 0, -1, -2*x_list(i+1), -3*x_list(i+1)^2, zeros(1, mat_size-4*(i-1)-8);
                      0, 0, 2, 6*x_list(i+1), 0, 0, -2, -6*x_list(i+1), zeros(1, mat_size-4*(i-1)-8)];
        y_vec = [y_vec;
             y_list(i);
             y_list(i+1);
             0;
             0];
    elseif i == length(x_list)-1
        spline_mat = [spline_mat;
                      zeros(1, 4*(i-1)), 1, x_list(i), x_list(i)^2, x_list(i)^3, zeros(1, mat_size-4*(i-1)-4);
                      zeros(1, 4*(i-1)), 1, x_list(i+1), x_list(i+1)^2, x_list(i+1)^3, zeros(1, mat_size-4*(i-1)-4)];
        y_vec = [y_vec;
             y_list(i);
             y_list(i+1)];
    else
        spline_mat = [spline_mat;
                      zeros(1, 4*(i-1)), 1, x_list(i), x_list(i)^2, x_list(i)^3, zeros(1, mat_size-4*(i-1)-4);
                      zeros(1, 4*(i-1)), 1, x_list(i+1), x_list(i+1)^2, x_list(i+1)^3, zeros(1, mat_size-4*(i-1)-4);
                      zeros(1, 4*(i-1)), 0, 1, 2*x_list(i+1), 3*x_list(i+1)^2, 0, -1, -2*x_list(i+1), -3*x_list(i+1)^2, zeros(1, mat_size-4*(i-1)-8);
                      zeros(1, 4*(i-1)), 0, 0, 2, 6*x_list(i+1), 0, 0, -2, -6*x_list(i+1), zeros(1, mat_size-4*(i-1)-8)];
        y_vec = [y_vec;
             y_list(i)
             y_list(i+1);
             0;
             0];
    end
    i = i+1;

end

spline_mat = [spline_mat;
              zeros(1, 4*(i-2)), 0, 0, 2, 6*x_list(end)];

y_vec = [y_vec;
         0];

coeffs = spline_mat\y_vec;

% SOLVER

i=1;
while x>x_list(i)
    i = i+1;
end

soln_c = coeffs(((i-2)*4)+1:(i-1)*4);

soln = soln_c(1) + soln_c(2)*x+soln_c(3)*x^2+ soln_c(4)*x^3;

end