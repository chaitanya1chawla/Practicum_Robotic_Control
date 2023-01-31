
%2d
function P = cal_ss()
    phi = 0:2*pi/100:2*pi;
    rad = 9;
    P = rad*[cos(phi);sin(phi)];
end