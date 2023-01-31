%1i

function [k,theta] = cal_ax(T)

    co = 0.5*(T(1,1) + T(2,2) + T(3,3) -1);
    si = 0.5*sqrt((T(3,2)-T(2,3))^2+(T(1,3)-T(3,1))^2+(T(2,1)-T(1,2))^2);

    if(co > 0)
        theta = atan(si/co);
    elseif((co==0)&&(si>0))
        theta = pi/2;
    elseif((co==0)&&(si<0))
        theta = -pi/2;
    elseif((co<0)&&(si>=0))
        theta = atan(si/co) + pi;
    else
        theta = atan(si/co) - pi;
    end

    k = 1/(2*sin(theta)) * [T(3,2)-T(2,3);T(1,3)-T(3,1);T(2,1)-T(1,2)];
    if(theta==0)
        k = [1;0;0];
    elseif((theta==pi)||(theta==-pi))  
        k = [sqrt((T(1,1)+1)/2);sqrt((T(2,2)+1)/2);sqrt((T(3,3)+1)/2)];
    end
end
