function [Traj] = cal_traj(via, q0, tau, tbe, dt)
    
    
    %Traj = zeros(size(q0,1),tau/dt);
    Traj(:,1) = q0;
    [m,n] = size(via);
    
    for i = 1:n-1
        A = Traj(:,size(Traj,2)); %checking no. of columns, 
                                  %because we want last point of trajectory
                                  %after each iteration
        dc = via(:,i+1) - via(:,i);
        db = via(:,i) - A;
        
      
        for j = 0:2*tbe/dt -1
            t = -tbe + j*dt;
            dh = (tbe+t)/2*tbe;
            Traj_acc(:,j+1) = ((dc*tbe/tau - db).*dh + 2*db).*dh + A;
        end
        
        for k= 0:(tau-2*tbe)/dt
            t_constvel = tbe + k*dt;
            dh_constvel = t_constvel/tau;
            Traj_constvel(:,k+1) = dc.*dh_constvel + via(:,i);
        end    
        Traj = [Traj Traj_acc Traj_constvel];
    
    end    
    
end    
    %{
    for i = 0:2*tbe/dt
        db = via(:,i+1) - Traj(:,i+1)
        dc = via(:,i+2) - via(:,i+1)
        t = -tbe + i*dt;
        dh = (tbe+t)/2*tbe;
        
        Traj(:,i+2) = ((dc*tbe/tau - db)*dh + 2*db)*dh + Traj(:,i+1)
        
    end
    
    for k = 1:(tau-2*tbe)/dt
        db = via(:,i+1) - Traj(:,i+1)
        dc = via(:,i+2) - via(:,i+1)
        
    end
    %}