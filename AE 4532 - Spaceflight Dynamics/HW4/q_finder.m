%% AE 4532 Quaternion finder from R_bf
% By: Noe Lepez Da Silva Duarte
% Created: 08 March 2022

function quaternion = q_finder(R)

trace_r = trace(R);

op = [1+trace_r;R(2,3)-R(3,2);R(3,1)-R(1,3);R(1,2)-R(2,1)];
op2 = [R(2,3)-R(3,2);1+2*R(1,1)-trace_r;R(1,2)+R(2,1);R(1,3)+R(3,1)];
op3 = [R(3,1)-R(1,3);R(1,2)+R(2,1);1+2*R(2,2)-trace_r;R(2,3)+R(3,2)];
op4 = [R(1,2)-R(2,1);R(3,1)+R(1,3);R(3,2)+R(2,3);1+2*R(3,3)-trace_r];
op = [op, op2, op3, op4];

diag_r = [R(1,1);R(2,2);R(3,3)];

if trace_r> diag_r(1) && trace_r> diag_r(2) && trace_r> diag_r(2)
    q1 = op(:,1);
    q1_s = [q1(1);-q1(2:end)];
    norm_q = q_mult(q1, q1_s);
    quaternion = q1/sqrt(norm_q(1));
else
    max_idx = find(max(diag_r)==diag_r)+1;
    q1 = op(:, max_idx);
    q1_s = [q1(1);-q1(2:end)];
    norm_q = q_mult(q1, q1_s);
    quaternion = q1/sqrt(norm_q(1));

end



end