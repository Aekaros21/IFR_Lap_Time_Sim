classdef carFsAWD

    properties
        
        wheel_rad
        mass
        cog_height
        cog_split
        cog_LR_split
        cop_height
        cop_split
        cop_LR_split
        wheelbase
        trackF
        trackR
        track
        CLA
        CDA
        stiffnesses
        K
        F
        unloadedGroundClearance
        K_max_roll
        F_max_roll
        K_Fz
        motor_power
        motor_ratio
        motor_torque
        motor_RPM_Limit
        motor_model
        ratios
        tyre_pressure
        IA
        brakeSystem
        type
       

    end

    methods

        function obj = carFsAWD()

            obj.wheel_rad = 0.232;
            obj.mass = 278;
            obj.cog_height = 0.3;
            obj.cog_split = 0.5;        
            obj.cog_LR_split = 0.5;     
            obj.cop_height = 0.3;       
            obj.cop_split = 0.5;        
            obj.cop_LR_split = 0.5;     
            obj.wheelbase = 1.55;       
            obj.trackF = 1.245;           
            obj.trackR = 1.235;           
            obj.track = (obj.trackF + obj.trackR)/2; 
            obj.CLA = -2.25;            
            obj.CDA = 0.675; 
            obj.stiffnesses = [26500,26500,1400*180/pi, 1260*180/pi];

            K_FL = obj.stiffnesses(1);    %wheel rate front left (N/m)
            K_FR = K_FL;        %wheel rate front right (N/m)
            K_RL = obj.stiffnesses(2);    %wheel rate rear left (N/m)
            K_RR = K_RL;        %wheel rate rear right (N/m)
            K_RollF = obj.stiffnesses(3); %roll rate front (Nm/rad)
            K_RollR = obj.stiffnesses(4); %roll rate rear (Nm/rad)
            wBase = obj.wheelbase;
            trackF = obj.trackF;
            trackR = obj.trackR;

            obj.K = [   (K_RollF+K_RollR)   ,0                                              ,0;
            0                   ,wBase^2/4*(K_FL + K_FR + K_RL +K_RR)   ,wBase/2*(-K_FL - K_FR + K_RL + K_RR);
            0                   ,wBase/2 *(K_RL +K_RR - K_FL -K_FR)     ,(K_FL +K_FR +K_RL +K_RR)];
            obj.F = inv(obj.K);

            U = obj.F * [0; 0; obj.mass*9.81]; 
            obj.unloadedGroundClearance = 0.04 + U(3);

            obj.K_max_roll = [  -K_RollF/trackF                ,-wBase*K_FL/2          ,- K_FL;
                                -K_RollR/trackR                ,+wBase*K_RL/2          ,- K_RL;
                                +K_RollF/trackF+K_RollR/trackR ,wBase*(K_FR - K_RR)    ,-(K_FR + K_RR)];

            obj.F_max_roll = inv(obj.K_max_roll);

         obj.K_Fz = [   -K_RollF/trackF,    -wBase*K_FL/2, -K_FL;
        -K_RollR/trackR,    +wBase*K_RL/2, -K_RL;
        +K_RollF/trackF,    -wBase*K_FR/2, -K_FR;
        +K_RollR/trackR,    +wBase*K_RR/2, -K_RR];
    

            obj.motor_power = 80000;       
            obj.motor_ratio = 4;        
            obj.motor_torque = 230;     
            obj.motor_RPM_Limit = 5900;    
            obj.ratios = obj.motor_ratio ;
            obj.motor_model = [0,	0;
                               286.684830937120,	918.367346938769;
                               738.053909467948,	2500.95918367346;
                               1293.14429212700,	5500.63265306123;
                               1823.79827700275,	7000;
                               2372.76355384189,	8000;
                               2854.64078139561,	9183.67346938774;
                               3269.42995966394,	10459.1836734694;
                               3653.73233074149,	11581.6326530612;
                               4092.93656496098,	12857.1428571429;
                               4452.87723466767,	13724.4897959184;
                               4776.25934594399,	14285.7142857143;
                               5087.48728382503,	14591.8367346939;
                               5900            ,	15000           ;
                               8500            ,    15100           ;          ] ;

            obj.tyre_pressure = 10;    
            obj.IA = 0;   
            obj.brakeSystem = car_brakes();

            obj.type = "electricAWD" ;
            
        end

    end


    

end