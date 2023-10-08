function [paramODO] = modele_ODOMETRE(nom)

% [paramODO] = modele_ODOMETRE(nom);
%--------------------------------------------------------------------------
% Modele des ODOMETRES
%--------------------------------------------------------------------------
%   nom :   Nom du modele a utiliser
%
%	paramODO :	structure contenant les parametres du modele
%--------------------------------------------------------------------------

if nargin==0
    nom = 'model_ODO_1';
end

switch nom
        
    case 'model_ODO_1'
        %------------------------------------------------------------------
        % Modele d'odometre (presque) parfait
        %------------------------------------------------------------------
        
        % Parametres
        paramODO.dt         = 0.01; % Pas d'echantillonnage [s]
        paramODO.dx         = 0.00001; % Deplacement inter-tops [m]
        paramODO.sig_vit	= 0.0;    % Ecart-type du bruit [m/s]

    
    case 'model_ODO_2'
        %------------------------------------------------------------------
        % Modele d'odometre realiste
        %------------------------------------------------------------------
        
        % Parametres
        paramODO.dt         = 0.01; % Pas d'echantillonnage [s]
        paramODO.dx         = 0.06; % Deplacement inter-tops [m]
        paramODO.sig_vit	= 1;    % Ecart-type du bruit [m/s]

    otherwise
        error('Modele ODOMETRE inconnu');
        
end
