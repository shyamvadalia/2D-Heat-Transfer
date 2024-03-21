% Explicit method for 2D heat equation in flat plate
% Input Parameters
L = 0.75; %(m)
dx = 0.05; %(m)
dy = 0.05; %(m)
N = L/dx+1; %Number of Nodes
tol = 1e-4;
dt = 0.00015;

% Domain Discretisation
T_new = zeros(N,N); %Initialising the Domain

x = linspace(0,dx,N); %x-coordinate
y = linspace(0,dy,N); %y-coordinate

% Boundary Condition
for i=1:N
    for j=1:N
        T_new(1,j) =150; 
        T_new(i,1) =200;
        T_new(N,j)=100;
        T_new(i,N)=250;
    end
end

%Main Loop - Logic
error =1;iter=0;
while(error > tol)
     iter=iter+1;
        T = T_new;
    for i=2:N-1
        for j =2:N-1
            T_new(i,j) = dt*((T(i+1,j)-2*T(i,j)+T(i-1,j))/dx^2 +(T(i,j+1)-2*T(i,j)+T(i,j-1))/dy^2) + T(i,j);
        end
    end
    error = max(max(abs(T-T_new)));
figure(2);
%plotting
     contourf(T_new); shading flat;colorbar;
xlabel('x');ylabel('y')
pause(0.1);
end