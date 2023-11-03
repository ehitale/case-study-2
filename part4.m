load("mockdata2023.mat");

% The following matrix implements the SIR dynamics example from Chapter 9.3
% of the textbook.
A = [0.75 0.04 0 0 0 0; 0.05 0.85 0 0 0 0; 0 0.1 1 0 0 0; 0 0.01 0 1 0 0; .2 0 0 0 0 0; 0 0 0 0 .01 0];
% Vaccination rate: .2 of susceptible population.
% Breakthrough rate: .01 of vaccinated population.

% The following matrix is needed to use the lsim function to simulate the
% system in question
B = zeros(6,1);

% initial conditions (i.e., values of S, I, R, D at t=0).
x0 = [0.9 0.1 0 0 0 0];

% Here is a compact way to simulate a linear dynamical system.
% Type 'help ss', 'help lsim', etc., to learn about how these functions work!!
sys_sir_base = ss(A,B,eye(6),zeros(6,1),1);
Y = lsim(sys_sir_base,zeros(1000,1),linspace(0,999,1000),x0);

% plot the output trajectory
figure;
plot(Y);
legend('S','I','R','D', 'V', 'B');
xlabel('Time')
ylabel('Percentage Population');

figure;
plot(cumulativeDeaths);
xlabel('Time')
ylabel('Cumulative Deaths');