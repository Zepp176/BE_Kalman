function [paramEST,initEST] = modele_ESTIMATEUR(nom,paramENG,paramODO,paramIMU,paramGPS)

% [paramEST,initEST] = modele_ESTIMATEUR(nom,paramENG,paramODO,paramIMU,paramGPS);
%--------------------------------------------------------------------------
% Modele de l'ESTIMATEUR
%--------------------------------------------------------------------------
%   nom :       Nom du modele a utiliser
%   paramENG :  parametres de l'engin
%   paramODO :  parametres des odometres
%   paramIMU :  parametres de l'IMU
%   paramGPS :  parametres du GPS
%
%	paramEST :	structure contenant les parametres de l'estimateur
%	initEST :   structure contenant les initialisations de l'estimateur
%--------------------------------------------------------------------------

if nargin==0
    nom = 'model_EST_1';
end

%--------------------------------------------------------------------------
% Recuperation des parametres des elements de modelisation
%--------------------------------------------------------------------------

% Parametres geometriques du vehicule
H = paramENG.H;      % Demi-longueur de l'essieu arriere
L = paramENG.L;      % Distance inter-essieux

% Parametres du controle du vehicule
tauVIT = paramENG.tauVIT;   % Constante de temps sur la vitesse
tauPHI = paramENG.tauPHI;	% Constante de temps sur la braquage
maxVIT = paramENG.maxVIT;	% Vitesse maximale
maxPHI = paramENG.maxPHI;   % Braquage maximal

% Parametres des odometres
dt_ODO      = paramODO.dt;          % Pas d'echantillonnage [s]
sig_vitODO	= paramODO.sig_vit;     % Ecart-type du bruit [m/s]

% Parametres du gyromètre
dt_IMU      = paramIMU.dt;      % Pas d'echantillonnage [s]
sig_omeIMU  = paramIMU.sig_ome;	% Ecart-type du bruit [°/s]

% Parametres du GPS
dt_GPS      = paramGPS.dt;      % Pas d'echantillonnage [s]
sig_posGPS  = paramGPS.sig_pos;	% Ecart-type du bruit [m]

% Enregistrement
paramEST.dt_ODO     = dt_ODO;
paramEST.dt_IMU     = dt_IMU;
paramEST.dt_GPS     = dt_GPS;
paramEST.tauVIT     = tauVIT;
paramEST.tauPHI     = tauPHI;
paramEST.H_eng      = H;
paramEST.L_eng      = L;

error_max_pos = maxVIT*dt_IMU;
error_max_the = dt_IMU * maxVIT/L * tan(maxPHI*pi/180);

switch nom
    
    case 'model_EST_1'
        %------------------------------------------------------------------
        % X = [pos;att]
        % U = [V^*,omeIMU]
        % Z = [posGPS]
        %------------------------------------------------------------------
                
        % Parametres de l'ESTIMATEUR
        paramEST.dt	= 0.01;     % Pas d'echantillonnage [s]
        paramEST.Q = diag([(error_max_pos/3)^2; (error_max_pos/3)^2; (paramIMU.sig_ome/3)^2]);
        paramEST.R = diag([sig_posGPS^2 ;sig_posGPS^2]);     

        % Etat initial
        initEST.POS	= [0 ; 0];	% Position du vehicule
        initEST.ATT	= 0;        % Direction du vehicule [°]

        % Enregistrement
        initEST.x	= [initEST.POS;initEST.ATT*pi/180];
        initEST.nx	= length(initEST.x);
                
        % Covariance initiale
        P = diag([0.001; 0.001; 0.001]);
        
        % Enregistrement
        initEST.P = P;
        
        
    case 'model_EST_2'
        %------------------------------------------------------------------
        % X = [pos;att;bias]
        % U = [V^*,omeIMU]
        % Z = [posGPS]
        %------------------------------------------------------------------
        
        sig_biais = paramIMU.deriv_ome * dt_IMU / paramIMU.biais_ome * (5*pi/(3*180))^2;

        % Parametres de l'ESTIMATEUR
        paramEST.dt	= 0.01;     % Pas d'echantillonnage [s]
        
        paramEST.Q = diag([(error_max_pos/3)^2; ...
                           (error_max_pos/3)^2; ...
                           paramIMU.sig_ome^2; ...
                           paramIMU.sig_ome^2 + sig_biais^2]);
        
        paramEST.R = diag([sig_posGPS^2; ...
                           sig_posGPS^2; ...
                           0.02]); % Bruit sur la mesure du biais
        
        % Etat initial
        initEST.POS	= [0 ; 0];	% Position du vehicule
        initEST.ATT	= 0;        % Direction du vehicule [°]
        initEST.BIAS = 0;       % Biais [°]

        % Enregistrement
        initEST.x	= [initEST.POS; initEST.ATT*pi/180; initEST.BIAS*pi/180];
        initEST.nx	= length(initEST.x);
                
        % Covariance initiale
        P = diag([0.001; 0.001; 0.001; (paramIMU.biais_ome/3)^2]);
        
        % Enregistrement
        initEST.P = P;
    
    
    case 'model_EST_3'
        %------------------------------------------------------------------
        % X = [pos;att;bias;VIT]
        % U = [V^*;omeIMU]
        % Z = [posGPS]
        %------------------------------------------------------------------
        
        sig_biais = paramIMU.deriv_ome * dt_IMU / paramIMU.biais_ome * (5*pi/(3*180))^2;

        % Parametres de l'ESTIMATEUR
        paramEST.dt	= 0.01;     % Pas d'echantillonnage [s]
        paramEST.Q = diag([(error_max_pos/3)^2; ...
                           (error_max_pos/3)^2; ...
                           paramIMU.sig_ome^2; ...
                           paramIMU.sig_ome^2 + sig_biais^2; ...
                           (maxVIT/3)^2]);
        paramEST.R = diag([((paramGPS.amp_sau+1)*sig_posGPS)^2; ...
                           ((paramGPS.amp_sau+1)*sig_posGPS)^2; ...
                           paramODO.sig_vit^2; ...
                           (paramODO.sig_vit + paramIMU.sig_ome)^2]);
        
        % Etat initial
        initEST.POS	= [0;0 ];	% Position du vehicule
        initEST.ATT	= 0;        % Direction du vehicule [°]
        initEST.BIAS = 0;       % Biais de l'IMU [°/s]
        initEST.VIT	= 0;        % Vitesse du vehicule

        % Enregistrement
        initEST.x	= [initEST.POS; initEST.ATT*pi/180; initEST.BIAS*pi/180; initEST.VIT];
        initEST.nx	= length(initEST.x);
                
        % Covariance initiale
        P = diag([0.001; 0.001; 0.001; (paramIMU.biais_ome/3)^2; 0.001]);
        
        % Enregistrement
        initEST.P = P;
    
    case 'model_EST_4'
        %------------------------------------------------------------------
        % X = [pos;att;bias;VIT;PHI]
        % U = [V^*;PHI^*;omeIMU]
        % Z = [posGPS;...]
        %------------------------------------------------------------------
        
        sig_biais = paramIMU.deriv_ome * dt_IMU / paramIMU.biais_ome * (5*pi/(3*180))^2;

        % Parametres de l'ESTIMATEUR
        paramEST.dt	= 0.01;     % Pas d'echantillonnage [s]
        paramEST.Q = diag([(error_max_pos/3)^2; ...
                           (error_max_pos/3)^2; ...
                           paramIMU.sig_ome^2; ...
                           paramIMU.sig_ome^2 + sig_biais^2; ...
                           (maxVIT/3)^2; ...
                           (maxPHI/3)^2]);
        paramEST.R = diag([((paramGPS.amp_sau+1)*sig_posGPS)^2; ...
                           ((paramGPS.amp_sau+1)*sig_posGPS)^2; ...
                           paramODO.sig_vit^2; ...
                           0.02]);
        
        % Etat initial
        initEST.POS	= [0; 0];	% Position du vehicule
        initEST.ATT	= 0;        % Direction du vehicule [°]
        initEST.BIAS = 0;       % Biais de l'IMU [°/s]
        initEST.VIT	= 0;        % Vitesse du vehicule
        initEST.PHI	= 0;        % Braquage des roues

        % Enregistrement
        initEST.x	= [initEST.POS; initEST.ATT*pi/180; initEST.BIAS*pi/180; initEST.VIT; initEST.PHI];
        initEST.nx	= length(initEST.x);
                
        % Covariance initiale
        P = diag([0.001; 0.001; 0.001; (paramIMU.biais_ome/3)^2; 0.001; 0.001]);
        
        % Enregistrement
        initEST.P = P;
        
    otherwise
        
        error('Modele ESTIMATEUR inconnu');
        
end

