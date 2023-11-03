% % The following matrix implements the SIR dynamics example from Chapter 9.3
% % of the textbook.
% A = [0.95 0.04 0 0; 0.05 0.85 0 0; 0 0.1 1 0; 0 0.01 0 1];
A_m = [0.95 0.04 0 0; 0.05 0.85 0 0; 0 0.1 1 0; 0 0.01 0 1];
A_g = [0.95 0.04 0 0; 0.05 0.85 0 0; 0 0.1 1 0; 0 0.01 0 1];

% The following matrix is needed to use the lsim function to simulate the
% system in question
B_m = Y_g(1:end, :)';
B_g = Y_m(1:end, :)';

% initial conditions (i.e., values of S, I, R, D at t=0).
x0_m = [0.9 0.1 0 0];
x0_g = [0.8 0.2 0 0];

% The two populations, Metropolis and Gotham City
% These figures will be used to convert between relative percents.
mPop = 11000000; % 11 million
gPop = 10000000; % 10 million

% The idea here that we ultimately didn't have enough time to implement is
% that the output of one linear dynamical system becomes the input of the
% other, and vice versa. Obviously, it wouldn't make sense for an entire
% population to move between two metros, so we wanted to implement a way o
% generate a random movement in both directions but we didn't manage to
% complete it. The problem that the code is currently running into is the
% fact that Y_m, the lds for Metropolis cannot access the info for Gotham,
% as it doesn't exist yet. The same problem would occur for Gotham, since
% it wouldn't be able to respond to the changes in Metropolis.

% Here is a compact way to simulate a linear dynamical system.
% Type 'help ss', 'help lsim', etc., to learn about how these functions work!!
sys_sir_base_m = ss(A_m,B_m(:, 1:end),eye(4),zeros(4,1),1);
Y_m = lsim(sys_sir_base_m,zeros(1000,1),linspace(0,999,1000),x0_m);

sys_sir_base_g = ss(A_g,B_g(:, 1:end),eye(4),zeros(4,1),1);
Y_g = lsim(sys_sir_base_g,zeros(1000,1),linspace(0,999,1000),x0_g);

% plot the output trajectory
plot(Y_m);
legend('S','I','R','D');
xlabel('Time')
ylabel('Percentage Population');

plot(Y_g);
legend('S','I','R','D');
xlabel('Time')
ylabel('Percentage Population');