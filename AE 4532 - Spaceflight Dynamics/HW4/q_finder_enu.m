%% AE 4532 Quaternion finder using e and nu
% By: Noe Lepez Da Silva Duarte
% Created: 08 March 2022

function quaternion = q_finder_enu(R)

tr_r = trace(R);
nu = acos((tr_r-1)/2);

e= (1/(2*sin(nu)))*[R(2,3)-R(3,2);
                    R(3,1)-R(1,3);
                    R(1,2)-R(2,1)];

quaternion = [cos(nu/2);e*sin(nu/2)];

end