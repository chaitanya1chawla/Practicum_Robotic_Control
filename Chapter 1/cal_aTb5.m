% 1h
function [aTb5] = cal_aTb5(k,theta)
    v = k.*sin(theta);
    aa = skew(v');
    ver = 1-cos(theta);
    aTbt = [k(1)^2*ver+cos(theta) k(1)*k(2)*ver k(1)*k(3)*ver; k(1)*k(2)*ver k(2)*k(2)*ver+cos(theta) k(3)*k(2)*ver; k(3)*k(1)*ver k(3)*k(2)*ver k(3)*k(3)*ver+cos(theta)];
    aTbr = aTbt + aa;
    aTb5 = [aTbr zeros(3,1); zeros(1,3) 1.0];
end