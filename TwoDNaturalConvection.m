% Parameters
Lx = 0.1;  % Length of cup in meters
Ly = 0.1;  % Width of cup in meters
Nx = 50;   % Number of grid points along x
Ny = 50;   % Number of grid points along y
T_hot = 80;  % Temperature of coffee in Celsius
T_cold = 20; % Room temperature in Celsius
alpha = 2.5e-5;  % Thermal diffusivity of coffee in m^2/s

% Grid
x = linspace(0, Lx, Nx);
y = linspace(0, Ly, Ny);
dx = x(2) - x(1);
dy = y(2) - y(1);
[X, Y] = meshgrid(x, y);

% Initial conditions
T = T_cold * ones(Nx, Ny);
T(end,:) = T_hot;  % Setting the boundary temperature

% Simulation parameters
dt = 0.01;  % Time step in seconds
t_end = 60; % Simulation time in seconds

% Main loop
for t = 0:dt:t_end
    T_old = T;
    for i = 2:Nx-1
        for j = 2:Ny-1
            % Discretized heat equation
            T(i,j) = T_old(i,j) + alpha * dt * ((T_old(i+1,j) - 2*T_old(i,j) + T_old(i-1,j)) / dx^2 + ...
                                                  (T_old(i,j+1) - 2*T_old(i,j) + T_old(i,j-1)) / dy^2);
        end
    end
end

% Plotting
figure;
contourf(X, Y, T', 'LineWidth', 1.5);
colorbar;
xlabel('Length (m)');
ylabel('Width (m)');
title('Temperature Distribution in a Cup of Coffee');
