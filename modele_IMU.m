function [paramIMU] = modele_IMU(nom)

% [paramIMU] = modele_IMU(nom);
%--------------------------------------------------------------------------
% Modele des CAPTEURS INERTIELS
%--------------------------------------------------------------------------
%   nom :   Nom du modele a utiliser
%
%	paramIMU :	structure contenant les parametres du modele
%--------------------------------------------------------------------------

if nargin==0
    nom = 'model_IMU_1';
end

switch nom

    case 'model_IMU_1'
        %------------------------------------------------------------------
        % Mesure gyrometrique (presque) parfait
        %------------------------------------------------------------------
        
        % Parametres
        paramIMU.dt         = 0.01; % Pas d'echantillonnage [s]
        paramIMU.sig_ome    = 1.0e-10;	% Ecart-type du bruit [°/s]
        paramIMU.biais_ome	= 0.0;	% Amplitude maximale du biais [°/s]
        paramIMU.deriv_ome	= 0.0;	% Derive maximale du biais [°/s /s]

    case 'model_IMU_2'
        %------------------------------------------------------------------
        % Mesure gyrometrique sans biais
        %------------------------------------------------------------------
        
        % Parametres
        paramIMU.dt         = 0.01; % Pas d'echantillonnage [s]
        paramIMU.sig_ome    = 0.1;	% Ecart-type du bruit [°/s]
        paramIMU.biais_ome	= 0.0;	% Amplitude maximale du biais [°/s]
        paramIMU.deriv_ome	= 0.05;	% Derive maximale du biais [°/s /s]

    case 'model_IMU_3'
        %------------------------------------------------------------------
        % Mesure gyrometrique realiste
        %------------------------------------------------------------------
        
        % Parametres
        paramIMU.dt         = 0.01; % Pas d'echantillonnage [s]
        paramIMU.sig_ome    = 0.1;	% Ecart-type du bruit [°/s]
        paramIMU.biais_ome	= 5.0;	% Amplitude maximale du biais [°/s]
        paramIMU.deriv_ome	= 0.05;	% Derive maximale du biais [°/s /s]        
    
    otherwise
        error('Modele IMU inconnu');
        
end
