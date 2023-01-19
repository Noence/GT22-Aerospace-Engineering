%% Newton interpolating polynomial interpolator
% By: Noe Lepez Da Silva Duarte
% Created: 06 March 2022

function [soln, coeffs] = newt_inter(x_list,y_list, x)

newt_mat = [];
i = 1;

while i <= length(y_list)
    
    inter_coeffs = [1];
    k = 1;
    imm = 1;
    while i ~= k
        imm = imm * (x_list(i)-x_list(k));
        inter_coeffs = [inter_coeffs, imm];
        k = k+1;
    end
    inter_coeffs = [inter_coeffs, zeros(1,length(x_list)-i)];
    
    newt_mat = [newt_mat; inter_coeffs];
    i = i+1;

end

coeffs = newt_mat\transpose(y_list);


soln = 0;
for k = transpose(coeffs)
    k_pos = find(k==transpose(coeffs));
    i = 1;
    inter_soln = k;
    while i~=k_pos
        inter_soln = inter_soln*(x-x_list(i));
        i = i+1;
    end
    soln = soln +inter_soln;
    
end

end