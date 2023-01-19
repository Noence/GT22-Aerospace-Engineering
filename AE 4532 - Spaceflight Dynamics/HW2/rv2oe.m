%% Radius & velocity to Orbital elements
% By: Noe Lepez Da Silva Duarte
% Date: 08 Feb. 2022

function [a,e,i,RAAN,omega,nu] = rv2oe(r_vec,v_vec,mu)
% This function computes the orbital elements for a given set radius and
% velocity vectors in the ECI france
% - r_vec = radius vector [km]
% - v_vec = velocity vector [km/s]
%
% The function output 6 orbital elements
%

r = norm(r_vec);
v = norm(v_vec);

h_vec = cross(r_vec,v_vec);
h = norm(h_vec);
n_vec = cross([0;0;1],h_vec);
n = norm (n_vec);
% e_vec = (1/mu)*(((v^2-(mu/r))*r_vec)-(dot(r_vec,v_vec)*v_vec));
e_vec = (1/mu)*((cross(v_vec,h_vec))-((mu/r)*r_vec));
e_norm = norm(e_vec);
e = [e_vec;e_norm];

a = h^2/(mu*(1-e_norm^2));

i = rad2deg(acos(h_vec(3)/h));


if n_vec(2) >= 0
    RAAN = rad2deg(acos(n_vec(1)/n));
elseif n_vec(2) < 0
    RAAN = 360 - rad2deg(acos(n_vec(1)/n));
end

if e_vec(3) >= 0
    omega = rad2deg(acos((dot(n_vec,e_vec)/(n*e_norm))));
elseif e_vec(3) < 0
    omega = 360 - rad2deg(acos((dot(n_vec,e_vec)/(n*e_norm))));
end

if dot(r_vec,v_vec)>=0 
    nu = rad2deg(acos((dot(e_vec,r_vec))/(e_norm*r)));
elseif dot(r_vec,v_vec)<0 
    nu = 360 - rad2deg(acos((dot(e_vec,r_vec))/(e_norm*r)));
end

end