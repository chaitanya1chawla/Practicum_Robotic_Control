%2a
function [Rob] = createRobot()
    L1 = Link('revolute', 'd', 0, 'a', 4, 'alpha', 0);
    L2 = Link('revolute', 'd', 0, 'a', 3, 'alpha', 0);
    L3 = Link('revolute', 'd', 0, 'a', 2, 'alpha', 0);
    
    
    L1.m = 20;
    L2.m = 15;
    L3.m = 10;

    L1.I = [0 0 0; 0 0 0; 0 0 0.5];
    L2.I = [0 0 0; 0 0 0; 0 0 0.2];
    L3.I = [0 0 0; 0 0 0; 0 0 0.1];

    L1.Jm = 0;
    L2.Jm = 0;
    L3.Jm = 0;

    L1.G = 1;
    L2.G = 1;
    L3.G = 1;

    L1.r = [-2 0 0]';
    L2.r = [-1.5 0 0]';
    L3.r = [-1 0 0]';
    
    
    Rob = SerialLink([L1 L2 L3],'name','robot');
    
    Rob.gravity = [0 9.81 0]';
end