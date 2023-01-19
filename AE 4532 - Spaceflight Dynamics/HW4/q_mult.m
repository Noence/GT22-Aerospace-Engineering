%% AE 4532 Quaternion multiplier
% By: Noe Lepez Da Silva Duarte
% Created: 08 March 2022

function quaternion_out = q_mult(q1, q2)

q1s = q1(1);
q2s = q2(1);
q1v = q1(2:4);
q2v = q2(2:4);

quaternion_out = [q1s*q2s-dot(q1v,q2v);
                  q1s*q2v+q2s*q1v-cross(q1v, q2v)];

end