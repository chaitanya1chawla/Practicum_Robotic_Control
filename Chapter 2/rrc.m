% 1c
function [Q, Q_dot, W, K_det, Tau] = rrc(q_0, w_0_dot, F_0, T)

    %robot
    L1 = Link('revolute', 'd', 0, 'a', 4, 'alpha', 0);
    L2 = Link('revolute', 'd', 0, 'a', 3, 'alpha', 0);
    L3 = Link('revolute', 'd', 0, 'a', 2, 'alpha', 0);
    robotarm = SerialLink([L1 L2 L3],'name','three link');
    

    t = 0 : 0.1 : T;
    n = length(t);
    Q = zeros(3, n);
    Q_dot = zeros(3, n);
    W = zeros(3, n);
    K_det = zeros(1, n);
    Tau = zeros(3, n);

    Q(:,1) = q_0;



    for i = 1:n-1
        J = robotarm.jacob0(Q(:,i)');
        J = J([1:2,6],:);
        if (det(J) == 0)
            J_inv = J.' /(J * J.');
        else
            J_inv = inv(J);
        end
        Q(:,i+1) = Q(:,i) + J_inv * w_0_dot * 0.1;
    end 
    

    for i = 1:n
        J = robotarm.jacob0(Q(:,i)');
        J = J([1:2,6],:);

        Tau(:,i) = J.' * F_0;

        if (det(J) == 0)
            %confirm this
            J_inv = J.' /(J * J.');
        else
            J_inv = inv(J);
        end

        Q_dot(:,i) = J_inv * w_0_dot;
        
        trafo = robotarm.fkine(Q(:,i)');
        trafo = double(trafo);
        W(1,i) = trafo(1,4);
        W(2,i) = trafo(2,4);
        W(3,i) = sum(Q(:,i));

       
        K_det(1,i) = det(J);
        
    end




end


% p = T.transl;
% subplot(3,1,1); plot(t, p(:,1)); xlabel('Time (s)'); ylabel('X (m)')
% subplot(3,1,2); plot(t, p(:,2)); xlabel('Time (s)');ylabel('Y (m)')
% subplot(3,1,3); plot(t, p(:,3)); xlabel('Time (s)');ylabel('Z (m)')