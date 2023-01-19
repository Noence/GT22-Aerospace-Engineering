%% AE 4342 - LAB 8

ans = []
for x=0:0.01:25
    y=0.08*x^2;
    ans = [ans y];
end

for x2=25.01:0.01:50
    y2=-0.08*x2^2+8*x2+0.08*25^2-150;
    ans = [ans y2];
end
x_tot = 0:0.01:50;

figure('color','white');
hold on
plot(x_tot,ans)
xlabel('Time (min)');
ylabel('Spacecraft angle (deg)');
title('Change in spacecraft angle relative to time');
grid on
