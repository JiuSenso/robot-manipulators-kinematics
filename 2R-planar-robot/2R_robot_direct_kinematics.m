%% 2R planar robot DIRECT KINEMATICS

%% define symbolic variables
syms a alpha d theta

%% number of joint
N = 2;

%% DH table of parameters of 2R, same for each joint
% assign these parameters in order to compute specific values
%          | a | alpha | d | theta |
DHTABLE = [ 100   0   0   30;
            80   0   0   20];
        
%% Build the general Denavit-Hartenberg trasformation matrix
TDH = [ cosd(theta) -sind(theta)  0   a*cosd(theta);
        sind(theta)  cosd(theta)  0   a*sind(theta);
          0             0       1       d;
          0             0       0       1           ];

%% Build transformation matrices for each link
A = cell(1,N);

% For every row in 'DHTABLE' we substitute the right value inside
% the general DH matrix
for i = 1:N
    a = DHTABLE(i,1);
    alpha = DHTABLE(i,2);
    d = DHTABLE(i,3);
    theta = DHTABLE(i,4);
    A{i} = subs(TDH);
end

%% Direct kinematics
disp('Direct kinematics of 2R robot in symbolic form')
disp(['Number of joints N = ',num2str(N)])
T = eye(4);

for i = 1:N 
    T = T*A{i};
    T = simplify(T);
end

% output direct kinematics matrix
T

% output end-effector position
p = T(1:3,4)

% output xN axis
n = T(1:3,1)

% output yN axis
s = T(1:3,2)

% output zN axis
a = T(1:3,3)

%% end
