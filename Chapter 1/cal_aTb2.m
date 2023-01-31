% 1e
function [aTb2] = cal_aTb2(a,b,c ,psb)
    xx = trotx(a*180/pi)*troty(b*180/pi)*trotz(c*180/pi);
    aTb2 = [xx(1:3,1:3) psb; 0.0 0.0 0.0 1.0];
end
