%% AE 4361 Reference position solver
% By: Noe Lepez Da Silva Duarte
% Created: 20 Feb. 2022

function [position_user] = pos_sol(rho_1,pos1, rho_2, pos2, rho_3,pos3, rho_4, pos4, error)
% This function solves a user's position from a set of 4 pseudorange
% measurements
% - rho_1 to rho_4 - Pseudorange measurements [km]
% - pos1 to pos4 - ECEF position of satellites [km]
% - error - error in referenced position to end iterative solution [km]
%
% The function outputs r = [x,y,z,t] in [km, km, km, s]

% Constants
r_E = 6371;                                            % [km]
c = 299792;                                            % [km/s]

% Inital conditions
xu = 0;
yu = 0;
zu = 0;
tu = 0;
pos_old = [xu;yu;zu;tu];
pos_err = 10000;

% Solver
while pos_err>error

    % Find rho_e, the expected rho
    rho_e = [rho_find(pos1(1), pos_old(1), pos1(2), pos_old(2), pos1(3), pos_old(3), pos_old(4));
             rho_find(pos2(1), pos_old(1), pos2(2), pos_old(2), pos2(3), pos_old(3), pos_old(4));
             rho_find(pos3(1), pos_old(1), pos3(2), pos_old(2), pos3(3), pos_old(3), pos_old(4));
             rho_find(pos4(1), pos_old(1), pos4(2), pos_old(2), pos4(3), pos_old(3), pos_old(4))];

    % Find d_rho = measured - expected = rho_i - rho_e
    d_rho = [rho_1;rho_2;rho_3;rho_4]-rho_e;
    
    % Calculate H
    H = [LOS(pos1(1), pos_old(1), pos1(2), pos_old(2), pos1(3), pos_old(3)), c;
         LOS(pos2(1), pos_old(1), pos2(2), pos_old(2), pos2(3), pos_old(3)), c;
         LOS(pos3(1), pos_old(1), pos3(2), pos_old(2), pos3(3), pos_old(3)), c;
         LOS(pos4(1), pos_old(1), pos4(2), pos_old(2), pos4(3), pos_old(3)), c];
    
    dpos_u = H\d_rho;
   
    pos_new = pos_old+dpos_u;
    
    pos_err = abs(abs_pos_finder(pos_old)-abs_pos_finder(pos_new));
    pos_old = pos_new;

end

position_user = pos_new;

    function [rho] = rho_find(x_s, x_u, y_s, y_u, z_s, z_u, tu)
        rho = sqrt((x_s-x_u)^(2)+(y_s-y_u)^(2)+(z_s-z_u)^(2))+c*tu;
    end

    function [pos] = abs_pos_finder(pos_arr)
        pos = sqrt(pos_arr(1)^(2)+pos_arr(2)^(2)+ pos_arr(3)^(2)) +c*pos_arr(4);

    end

    function [sol] = LOS(x_s, x_u, y_s, y_u, z_s, z_u)
        r_i = sqrt((x_s-x_u)^(2)+(y_s-y_u)^(2)+(z_s-z_u)^(2));
        ax = -(x_s-x_u)/(r_i);
        ay = -(y_s-y_u)/(r_i);
        az = -(z_s-z_u)/(r_i);
        sol = [ax, ay, az];

    end

end