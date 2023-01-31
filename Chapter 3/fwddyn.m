function [Q, Q_d, Q_dd, t, tau] = fwddyn(Rob, q0, dt, T)
    
    t = 0:dt:T;
    Q(:,1)= q0;
    Q_d(:,1) = [0;0;0];
    Q_dd = zeros(3,length(t));
    tau = zeros(3,length(t));
    % see accel and gravload code
    tau(:,1) = Rob.gravload(Q(:,1)');
    Q_dd(:,1) = Rob.accel(Q(:,1)', Q_d(:,1)',[0,0,0]);
    
    for i = 2:length(t)
        Q_d(:,i) = Q_d(:,i-1) + Q_dd(:,i-1)*dt;
        Q(:,i) = Q(:,i-1) + Q_d(:,i-1)*dt + Q_dd(:,i-1)*(dt).^2/2;
        Q_dd(:,i) = Rob.accel(Q(:,i)', Q_d(:,i)',[0,0,0]);
        tau(:,i) = Rob.gravload(Q(:,i)');
    end
    %{
    Q
    Q_d
    Q_dd
    tau
    %}
    Q(:,[1,51])
    Q_d(:,[1,51])
    Q_dd(:,[1,51])
    tau(:,[1,51])
    
end