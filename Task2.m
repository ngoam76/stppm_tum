% Prepare system variables (2-dim)

% Number of iterations
n = 10;

% Values Q
Q = [1 1];

% Change values dQ1, dQ2
dQ = [0 0];

% Scenario 1: Singular node feeding itself with positive coefficient
C1 = [1.1 0; 0 1];

% Scenario 2: Singular node feeding itself with negative coefficient
C2 = [0.9, 0; 0, 1];

% Scenario 3: Two nodes impacting each other positively
C3 = [1, 0.1; 0.1, 1];

% Scenario 4: Two nodes impacting each other negatively
C4 = [1, -0.1; -0.1, 1];

% Array to collect development Q(1)
Show1 = zeros(1,n);

% Array to collect development Q(2)
Show2 = zeros(1,n);

% Store initial values
Show1(1) = Q(1);
Show2(1) = Q(2);

% Iterate system
for i = 1:n
    % Compute change values
    dQ = Q * C1;
    % Update value
    Q = Q + dQ;
    % Store updated values as array
    Show1(i) = Q(1);
    Show2(i) = Q(2);
end

% Plot the results
figure;
plot(1:n, Show1, 'r', 'DisplayName', 'Q1');
hold on;
plot(1:n, Show2, 'b', 'DisplayName', 'Q2');
xlabel('Time step');
ylabel('State values');
title('Development of q1 and q2 over time');
legend;
grid on;
hold off;