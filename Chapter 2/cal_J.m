% 1b
function [J] = cal_J(theta_1, theta_2, theta_3)
    J = [-4*sin(theta_1)-3*sin(theta_1+theta_2)-2*sin(theta_1+theta_2+theta_3), -3*sin(theta_1+theta_2)-2*sin(theta_1+theta_2+theta_3), -2*sin(theta_1+theta_2+theta_3);
        4*cos(theta_1)+3*cos(theta_1+theta_2)+2*cos(theta_1+theta_2+theta_3), 3*cos(theta_1+theta_2)+2*cos(theta_1+theta_2+theta_3), 2*cos(theta_1+theta_2+theta_3);
        1, 1, 1];
end
