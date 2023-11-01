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

% Percentage of the St. Louis city/count for above data.
percent_cases_delta = cases_delta/POP_STL;
percent_cases_omicron = cases_omicron/POP_STL;
percent_deaths_delta = deaths_delta/ POP_STL;
percent_deaths_omicron = deaths_omicron/POP_STL;

% Cases and deaths on June 30, the start of delta
delta_start_cases = cases_STL(dates == "2021-6-30");
delta_start_deaths = deaths_STL(dates == "2021-6-30");

percent_delta_start_cases = delta_start_cases / POP_STL;
percent_delta_start_deaths = delta_start_deaths / POP_STL;

percent_recovered =  (delta_start_cases - delta_start_deaths) / POP_STL;
percent_susceptible = 1 - percent_recovered - percent_delta_start_deaths - percent_delta_start_cases;

% The following matrix implements the SIR dynamics example from Chapter 9.3
% of the textbook.
% A = [0.95 0.04 0 0; 0.05 0.85 0 0; 0 0.1 1 0; 0 0.01 0 1];

% Let's try and make it match the data. model_1 should match delta, and
% model_2 should match omicron.
A_model_1 = [
    0.95 0.44 0 0;
    0.05 0.45 0 0; 
    0 0.1 1 0; 
    0 0.01 0 1];
A_model_2 = [
    0.96 0.04 0 0;
    0.04 0.85 0 0;
    0 0.1 1 0;
    0 0.01 0 1];

% The following matrix is needed to use the lsim function to simulate the
% system in question
B = zeros(4,1);

% initial conditions (i.e., values of S, I, R, D at t=0).
% todo: find the initial percentage of the population at the onset of the
% delta variant? should I just do everything twice, just considering the
% relevant time ranges each time?
% x0 = [0.9 0.1 0 0];
x0 = [percent_susceptible percent_delta_start_cases percent_recovered percent_delta_start_deaths];

% Here is a compact way to simulate a linear dynamical system.
% Type 'help ss', 'help lsim', etc., to learn about how these functions work!!

% sys_sir_base = ss(A,B,eye(4),zeros(4,1),1);
% Y = lsim(sys_sir_base,zeros(1000,1),linspace(0,999,1000),x0);

sys_sir_base_m1 = ss(A_model_1,B,eye(4),zeros(4,1),1);
Y_m1 = lsim(sys_sir_base_m1,zeros(118,1),linspace(0,117,118),x0);

sys_sir_base_m2 = ss(A_model_2,B,eye(4),zeros(4,1),1);
Y_m2 = lsim(sys_sir_base_m2,zeros(146,1),linspace(0,145,146),Y_m1(end, :));

% The following selects the relevant columns of Y, the infected population (or cases) and the deaths. 
Y_m1_cases = cumsum(Y_m1(:, 2) * POP_STL);
Y_m1_deaths = cumsum(Y_m1(:, 4) * POP_STL);

Y_m2_cases = cumsum(Y_m2(:, 2) * POP_STL);
Y_m2_deaths = cumsum(Y_m2(:, 4) * POP_STL);

% The following uses logical indexing to select data for the relevant time periods. 
% Y_m1_delta_deaths = Y_m1_deaths(delta_range);
% Y_m2_omicron_deaths = Y_m2_deaths(omicron_range);
% Y_m1_delta_cases = Y_m1_cases(delta_range);
% Y_m2_omicron_cases = Y_m2_cases(omicron_range);

% % plot the output trajectory
% plot(Y);
% % legend('S','I','R','D');
% xlabel('Time')
% ylabel('Percentage Population');
% hold on;

% The following plots the actual death and case data for the two variants.
% The time values need to match up!!!

figure;
plot(Y_m1_cases);
hold on;
plot(Y_m1_deaths);
hold on;
legend('Y delta cases', 'Y delta deaths')

figure;
plot(percent_cases_delta * POP_STL)
hold on;
plot(percent_deaths_delta * POP_STL)
legend('cases delta', 'deaths delta')
hold off;

figure;
plot(Y_m2_cases);
hold on;
plot(Y_m2_deaths);
hold on;
legend('Y omicron cases', 'Y omicron deaths')

figure;
plot(percent_cases_omicron * POP_STL)
hold on;
plot(percent_deaths_omicron * POP_STL)
legend('cases omicron', 'deaths omicron')
hold off;