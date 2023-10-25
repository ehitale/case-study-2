% initial population and pre-allocation
x0 = [1; 0; 0; 0];
xt = zeros(4, 200);
zt = zeros(4, 200);

% update matrices
A_no_reinfection = [
    0.95, 0.04, 0, 0; % Susceptible
    0.05, 0.85, 0, 0; % Infected
    0, .10, 1, 0; % Recovered and immune
    0, .01, 0, 1 % Dead
    ];

A_reinfection = [ 
    0.95, 0.04, 1, 0;
    0.05, 0.85, 0, 0;
    0, .10, 0, 0;
    0, .01, 0, 1
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

% these loops update xt (the sim with no re-infection) 
% and zt (the sim with re-infection).

for i = 1:200
    xt(:, i) = (A_no_reinfection^i) * x0;
end

for j = 1:200
    zt(:, j) = (A_reinfection^j) * x0;
end

% these loops scatter plot xt and zt.
for i = 1:200
    scatter(i, xt(1, i), '.r')
    hold on;
    scatter(i, xt(2, i), '.g')
    hold on;
    scatter(i, xt(3, i), '.b')
    hold on;
    scatter(i, xt(4, i), '.m')
    hold on;
end
hold off;
title('sim 200 t - no re-infection');
xlabel('State');
ylabel('Percent');
legend('Susceptible', 'Infected', 'Recovered', 'Dead');

figure;
for j = 1:200
    scatter(j, zt(1, j), '.r')
    hold on;
    scatter(j, zt(2, j), '.g')
    hold on;
    scatter(j, zt(3, j), '.b')
    hold on;
    scatter(j, zt(4, j), '.m')
    hold on;
end
hold off;
title('sim 200 t - re-infection');
xlabel('State');
ylabel('Percent');
legend('Susceptible', 'Infected', 'Recovered', 'Dead');