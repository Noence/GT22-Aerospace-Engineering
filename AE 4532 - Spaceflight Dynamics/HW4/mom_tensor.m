%% AE 4532 Moment of inertia tensor finder
% By: Noe Lepez Da Silva Duarte
% Created: 10 March 2022

function I = mom_tensor(r)

x = r(1);
y = r(2);
z = r(3);

I = [(y^2)+(z^2), -x*y, -x*z;
     -x*y, (x^2)+(z^2), -y*z;
     -z*x, -y*z, (x^2)+(y^2)];

end