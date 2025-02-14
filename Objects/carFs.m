classdef carFs

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
        CSA
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
        toe
        slip_matrix
        
       

    end

    methods

        function obj = carFs()

            load CDA.mat CDA;
            load CLA.mat CLA;
            load CSA.mat CSA;

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
            obj.CLA = -CLA;            
            obj.CDA = CDA; 
            obj.CSA = CSA;
            obj.stiffnesses = [26500,26500,1400*180/pi, 1260*180/pi];
            obj.toe = 0;

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
            obj.motor_model = [ 0	, 0;
                                286.684830937120	, 3776.22377622375;
                                738.053909467948	, 9860.13986013984;
                                1293.14429212700	, 16783.2167832168;
                                1823.79827700275	, 24125.8741258741;
                                2372.76355384189	, 31468.5314685315;
                                2854.64078139561	, 37762.2377622377;
                                3269.42995966394	, 43006.9930069930;
                                ] ;

            obj.tyre_pressure = 10;    
            obj.IA = 0;   %degrees
            obj.brakeSystem = car_brakes();
            obj.type = "electric" ;
            obj.slip_matrix = [0        ,        0;
                               0.018    ,   0.2160;
                               0.033    ,   0.4200;
                               0.045    ,   0.5784;
                               0.062    ,   0.7548;
                               0.082    ,   0.8768;
                               0.108    ,   0.9524;
                               0.150    ,   1.0000;];
        end

    end


    

end
