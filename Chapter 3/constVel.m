% 1a
function [Q, Q_dot, Q_ddot, W, t] = constVel(q_0, w_0_dot, dt, T)

    %robot
    L1 = Link('revolute', 'd', 0, 'a', 1, 'alpha', 0);
    L2 = Link('revolute', 'd', 0, 'a', 1, 'alpha', 0);
    robotarm = SerialLink([L1 L2],'name','two link');
    

    t = 0 : dt : T;
    n = length(t);
    Q = zeros(2, n);
    Q_dot = zeros(2, n);
    Q_ddot = zeros(2, n);
    W = zeros(2, n);

    Q(:,1) = q_0;



    for i = 1:n-1
        J = robotarm.jacob0(Q(:,i)');
        J = J([1 2],:);
        if (det(J) == 0)
            J_inv = J.' /(J * J.');
        else
            J_inv = inv(J);
        end
        Q(:,i+1) = Q(:,i) + J_inv * w_0_dot * dt;
    end 
    

    for i = 1:n
        J = robotarm.jacob0(Q(:,i)');
        J = J([1 2],:);

        if (det(J) == 0)
            J_inv = J.' /(J * J.');
        else
            J_inv = inv(J);
        end

        Q_dot(:,i) = J_inv * w_0_dot;
        if (i>1)
            Q_ddot(:,i-1) = (Q_dot(:,i) - Q_dot(:,i-1)) / dt;
        end
        trafo = robotarm.fkine(Q(:,i)');
        trafo = double(trafo);
        W(1,i) = trafo(1,4);
        W(2,i) = trafo(2,4);
        
    end

    %calculating Q_ddot(:,n)
    J = robotarm.jacob0(Q(:,n)');
    J = J([1 2],:);
    if (det(J) == 0)
        J_inv = J.' /(J * J.');
    else
        J_inv = inv(J);
    end
    temp = Q(:,n) + J_inv * w_0_dot * dt
    
    J=robotarm.jacob0(temp');
    J=J([1 2],:)
    J_inv = J.' /(J * J.');
    
    Q_ddot(:,n) = (J_inv * w_0_dot - Q_dot(:,n)) / dt;
    Q
    Q_dot
    Q_ddot
    W
end


% p = T.transl;
% subplot(3,1,1); plot(t, p(:,1)); xlabel('Time (s)'); ylabel('X (m)')
% subplot(3,1,2); plot(t, p(:,2)); xlabel('Time (s)');ylabel('Y (m)')
% subplot(3,1,3); plot(t, p(:,3)); xlabel('Time (s)');ylabel('Z (m)')