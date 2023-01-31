%1b
function [Tau] = invdyn(Q,Q_dot,Q_ddot)

    % length = 1 m
    % area = a^2 = (0.05m)^2 -> 0.0025 m^2 
    % volume = a^2 * L = 0.0025 m^3
    % mass = density * vol = 7806 kg/m^3 * 0.0025 m^3, therefore:

    m = 19.515;
    g = 9.81;
    l = 1;
    n = size(Q,2);
    
    Tau = zeros(2,n);

    for i = 1:n
    
        Tau(1,i) =  m *( ((5/3) + cos(Q(2,i)))*Q_ddot(1,i) + ...
            ((1/3) + 0.5*cos(Q(2,i)))*Q_ddot(2,i) ) + ...
            m*(-sin(Q(2,i))*Q_dot(1,i)*Q_dot(2,i) - 0.5*sin(Q(2,i))*(Q_dot(2,i))^2) + ...
            m*g*( (3/2)*cos(Q(1,i)) + 0.5*cos(Q(1,i) + Q(2,i)) );
    
        Tau(2,i) = m*( ((1/3) + 0.5*cos(Q(2,i)))*Q_ddot(1,i) + ...
            (1/3)*Q_ddot(2,i) ) + m*0.5*sin(Q(2,i))*(Q_dot(1,i))^2 + ...
            m*g*0.5*cos(Q(1,i) + Q(2,i));
    
    end
    

end
