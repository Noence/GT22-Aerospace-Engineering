%% Lagrange interpolating polynomial interpolator
% By: Noe Lepez Da Silva Duarte
% Created: 06 March 2022

function soln = lagrange_inter(x_list,y_list, x)

coeffs = [];
i = 1;

while i <= length(y_list)
    
    inter_coeffs = y_list(i);

    j = 1;
    while j<= length(x_list)
        if i ~= j
            inter_coeffs = inter_coeffs / (x_list(i) - x_list(j));
        end
        j = j+1;
    end
    
    coeffs = [coeffs inter_coeffs];
    i = i+1;

end

soln = 0;

k = 1;
while k<=length(coeffs)
    inter_soln = coeffs(k);
    for l = x_list
        
        if l ~= x_list(k)
            inter_soln = inter_soln*(x-l);
        end

    end
    k = k+1;
    soln = soln + inter_soln;
    
end


end