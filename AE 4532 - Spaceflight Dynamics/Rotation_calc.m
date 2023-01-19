%% Rotation matrices AE 4532

clc
close all 
clearvars

rots = [2 3 2];
initial = [6.235;-4.872;10.614];
total_rot = initial;
ps = deg2rad(60);
th = deg2rad(45);
ph = deg2rad(45);
angle_vec = [ps th ph];

i=1;
for j=rots
    if j == 1
        inter_rot = Rx(angle_vec(i));
    elseif j == 2
        inter_rot = Ry(angle_vec(i));
    elseif j == 3
        inter_rot = Rz(angle_vec(i));
    end
    total_rot = inter_rot*total_rot;
    i = i+1;
end

final_vec = total_rot

function R1=Rx(ph)
    R1 = [1 0 0;
          0 cos(ph) sin(ph);
          0 -sin(ph) cos(ph)];
end

function R2=Ry(th)
    R2 = [cos(th) 0 -sin(th);
          0 1 0;
          sin(th) 0 cos(th)];
end

function R3=Rz(ps)
    R3 = [cos(ps) sin(ps) 0;
         -sin(ps) cos(ps) 0;
         0 0 1];
end
