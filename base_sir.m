% todo: match up times and convert cases and deaths to percentages.

load("COVID_STL.mat")

% The following creates a range of dates for the Delta and Omicron
% variants.
delta_range = isbetween(dates, "2021-6-30", "2021-10-26");
omicron_range = isbetween(dates, "2021-10-27", "2022-3-22");

% The following are case and death data indexed using the ranges above. 
cases_delta = cases_STL(delta_range);
cases_omicron = cases_STL(omicron_range);
deaths_delta = deaths_STL(delta_range);
deaths_omicron = deaths_STL(omicron_range); 

% The following matrix implements the SIR dynamics example from Chapter 9.3
% of the textbook.
A = [0.95 0.04 0 0; 0.05 0.85 0 0; 0 0.1 1 0; 0 0.01 0 1];

% The following matrix is needed to use the lsim function to simulate the
% system in question
B = zeros(4,1);

% initial conditions (i.e., values of S, I, R, D at t=0).
x0 = [0.9 0.1 0 0];

% Here is a compact way to simulate a linear dynamical system.
% Type 'help ss', 'help lsim', etc., to learn about how these functions work!!
sys_sir_base = ss(A,B,eye(4),zeros(4,1),1);
Y = lsim(sys_sir_base,zeros(1000,1),linspace(0,999,1000),x0);

% plot the output trajectory
plot(Y);
% legend('S','I','R','D');
xlabel('Time')
ylabel('Percentage Population');
hold on;

% The following plots the actual death and case data for the two variants.
% The time values need to match up!!!
plot(deaths_delta)
hold on;
plot(cases_delta)
hold on;

plot(deaths_omicron)
hold on;
plot(cases_omicron)
hold on;
legend('S','I','R','D','deaths delta', 'cases delta', 'deaths omicron', 'cases omicron')