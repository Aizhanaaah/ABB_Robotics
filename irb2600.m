% Joint angles (input)
j1 = 0; j2 = 0; j3 = 0;
j4 = 0; j5 = 0; j6 = 0;

% DH Parameters: [theta, d, a, alpha]
DH_params = [
    j1,      445, 150, -90;
    j2-90,   0,   700, 0;
    j3,      0,   115, -90;
    j4,      795, 0,   90;
    j5,      0,   0,   -90;
    j6,      85,  0,   0
];

% Calculate Transformation Matrix
res = full_transform(DH_params);

fprintf('Homogeneous Transformation Matrix for the Full Kinematic Chain:\n');
disp(res);

% Tool Position (MATLAB uses 1-based indexing)
x = res(1,4);
y = res(2,4);
z = res(3,4);

fprintf('Tool Position:\nx=%.2fmm\ny=%.2fmm\nz=%.2fmm\n\n', x, y, z);

% Check for Gimbal-Lock - res(3,1) close to 1
% Note: Python res[2,0] is MATLAB res(3,1)
if abs(1 - abs(res(3,1))) > 0.001
    % --- Solution for -pi/2 < Ry < pi/2 range ---
    R_x = atan2d(res(3,2), res(3,3));
    R_y = atan2d(-res(3,1), sqrt(1 - res(3,1)^2));
    R_z = atan2d(res(2,1), res(1,1));

    % --- Solution for pi/2 < Ry < 3pi/2 range ---
    R_x2 = round(atan2d(-res(3,2), -res(3,3)), 2);
    R_y2 = round(atan2d(-res(3,1), -sqrt(1 - res(3,1)^2)), 2);
    R_z2 = round(atan2d(-res(2,1), -res(1,1)), 2);
else
    % --- Gimbal Lock Case ---
    R_y = round(atan2d(-res(3,1), sqrt(1 - res(3,1)^2)), 2);
    
    if R_y == 90
        R_x = round(atan2d(-res(1,2), res(2,2)), 2);
    else
        R_x = round(atan2d(res(1,2), res(2,2)), 2);
    end
    
    R_z = 0; % Convention
    R_x2 = NaN;
    R_y2 = NaN;
    R_z2 = NaN;
end

fprintf('Tool Orientation with Euler Angles (RPY):\n');
fprintf('Solution 1:\nRx=%.2f°\nRy=%.2f°\nRz=%.2f°\n', R_x, R_y, R_z);
fprintf('Solution 2:\nRx=%.2f°\nRy=%.2f°\nRz=%.2f°\n', R_x2, R_y2, R_z2);

% --- HELPER FUNCTIONS ---

function full_DH = full_transform(DH_parameters)
    full_DH = eye(4);
    for i = 1:size(DH_parameters, 1)
        row = DH_parameters(i,:);
        T = DH_matrix(row(1), row(2), row(3), row(4));
        full_DH = full_DH * T; % Matrix multiplication
    end
end

function T = DH_matrix(theta, d, a, alpha)
    ct = cosd(theta); st = sind(theta);
    ca = cosd(alpha); sa = sind(alpha);
    
    T = [ ct, -st*ca,  st*sa, a*ct;
          st,  ct*ca, -ct*sa, a*st;
          0,   sa,     ca,    d;
          0,   0,      0,     1 ];
end
