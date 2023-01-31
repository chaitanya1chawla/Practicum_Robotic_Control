% 1c
function [ap] = cal_ap(bp)
    ap_temp = transl(0.5, 0.0, 0.0)*troty(90)*trotz(-90)*[bp;1];
    ap = ap_temp(1:3);
end