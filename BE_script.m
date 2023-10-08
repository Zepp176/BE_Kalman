%==========================================================================
%==========================================================================
% BE Navigation 
%==========================================================================
%==========================================================================

clearvars
close all

%--------------------------------------------------------------------------
% Modele de SIMULATION
%--------------------------------------------------------------------------

% Modele du VEHICULE
[paramENG,initENG] = modele_VEHICULE('model_ENG_1');

% Trajectoire de l'ENGIN (sequence des consignes)
[IN_consVIT,IN_consPHI] = modele_TRAJECTOIRE('model_TRA_2');

% Modele des ODOMETRES
[paramODO] = modele_ODOMETRE('model_ODO_1');

% Modele de l'IMU
[paramIMU] = modele_IMU('model_IMU_3');

% Modele de GPS
[paramGPS] = modele_GPS('model_GPS_3');


%--------------------------------------------------------------------------
% Estimateur
%--------------------------------------------------------------------------

[paramEST,initEST] = modele_ESTIMATEUR('model_EST_3',paramENG,paramODO,paramIMU,paramGPS);


%--------------------------------------------------------------------------
% Simulation
%--------------------------------------------------------------------------

% Parametres de simulation
paramSIM.T	= 180; %180;       % Duree

% Simulation
sim('schemaSIM');


%--------------------------------------------------------------------------
% Traces
%--------------------------------------------------------------------------

% Consignes et reponses des actionneurs
plot_COMMANDE(OUT_consVIT,OUT_VIT,OUT_consPHI,OUT_PHI);

% Trajectoire du VEHICULE
plot_VEHICULE(OUT_posENG,OUT_attENG);
% plot_VEHICULE(OUT_posEST,OUT_attEST);

% Les vitesses
plot_VITESSE(OUT_consVIT,OUT_VIT,OUT_vitENG,OUT_vitROUE);

% Les mesures
plot_ODOMETRE(OUT_vitROUE,OUT_vitODO);
plot_IMU(OUT_omeENG,OUT_omeIMU);
plot_GPS(OUT_posENG,OUT_posGPS);

% Les estimations
plot_ESTIMATEUR(OUT_posENG,OUT_posEST,OUT_covEST,OUT_attENG,OUT_attEST);


