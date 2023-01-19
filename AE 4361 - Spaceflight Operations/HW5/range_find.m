%% AE 4803 Find range from inputs
% By: Noe Lepez Da Silva Duarte
% Created: 21 Feb. 2022

function [ranges] = range_find(pos1, pos2, pos3, pos4, pos_user)
tu = 1.25e-6;

ranges = [rho_finder(pos1, pos_user), rho_finder(pos2, pos_user), rho_finder(pos3, pos_user), rho_finder(pos4, pos_user)];

    function rho = rho_finder(pos , upos)
    
        rho = sqrt((pos(1)-upos(1))^2+(pos(2)-upos(2))^2+(pos(3)-upos(3))^2)+ 299792*tu;

    end

end