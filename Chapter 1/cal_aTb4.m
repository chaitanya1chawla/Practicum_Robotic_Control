% 1g
function [aTb4] = cal_aTb4(u,v,w,psb)
    yy = trotz(u*180/pi)*troty(v*180/pi)*trotz(w*180/pi);
    aTb4 = [yy(1:3,1:3) psb; 0.0 0.0 0.0 1.0];
end