%2b
function [q] = rwl(w, q0)

    
    q(:,1) = q0;

    %robot
    L1 = Link('revolute', 'd', 0, 'a', 4, 'alpha', 0);
    L2 = Link('revolute', 'd', 0, 'a', 3, 'alpha', 0);
    L3 = Link('revolute', 'd', 0, 'a', 2, 'alpha', 0);
    robotarm = SerialLink([L1 L2 L3],'name','three link');

for i=2:20
    
    J = robotarm.jacob0(q(:,i-1)');
    J = J([1,2,6],:);
    
    if (det(J) == 0)
        J_inv = J.' /(J * J.');
    else
        J_inv = inv(J);
    end
    
    trafo = robotarm.fkine(q(:,i-1)');
    trafo = double(trafo);
    x = trafo(1,4);
    y = trafo(2,4);

    rx = trafo(1,1);
    ry = trafo(2,1);
    phi = atan2(ry,rx);
    
    q(:,i) = q(:,i-1) - J_inv*([x;y;phi] - w);
    
    delta_q = q(:,i) - q(:,i-1);
    
    if (norm(delta_q) < 0.01)
        break
    end
    
end


q = q(:,end);


end

