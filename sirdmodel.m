x0 = [1; 0; 0; 0];
xt = zeros(4, 200);
A = [
    0.95, 0.04, 0, 0; % Susceptible
    0.05, 0.85, 0, 0; % Infected
    0, .10, 1, 0; % Recovered and immune
    0, .01, 0, 1 % Dead
    ];

figure;
% for i = 1:200
%     xt(:, i) = (A^i) * x0;
% 
%     scatter(j, xt(1, j), 'r')
%     hold on;
%     scatter(j, xt(2, j), 'g')
%     hold on;
%     scatter(j, xt(3, j), 'b')
%     hold on;
%     scatter(j, xt(4, j), 'm')
%     hold on;
% end   

for i = 1:200
    xt(:, i) = (A^i) * x0;
end

for j = 1:200
    scatter(j, xt(1, j), 'r')
    hold on;
    scatter(j, xt(2, j), 'g')
    hold on;
    scatter(j, xt(3, j), 'b')
    hold on;
    scatter(j, xt(4, j), 'm')
    hold on;
end

hold off;
title('sim 200 t');