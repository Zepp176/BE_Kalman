function [paramENG,initENG] = modele_VEHICULE(nom)

% [paramENG,initENG] = modele_VEHICULE(nom);
%--------------------------------------------------------------------------
% Modele de SIMULATION du VEHICULE
%--------------------------------------------------------------------------
%   nom :   Nom du modele a utiliser
%
%	paramENG :	structure contenant les parametres
%	initENG :   structure contenant les initialisations
%--------------------------------------------------------------------------

if nargin==0
    nom = 'model_ENG_1';
end

switch nom
    
    case 'model_ENG_1'
        %------------------------------------------------------------------
        % Modele d'un vehicule lent
        %------------------------------------------------------------------
        
        % Parametres geometriques du vehicule
        paramENG.H	= 0.8;      % Demi-longueur de l'essieu arriere
        paramENG.L	= 2.0;      % Distance inter-essieux
        
        % Parametres du controle de vitesse
        paramENG.tauVIT     =  3;   % Constante de temps sur la vitesse
        paramENG.maxVIT     = 10;	% Vitesse maximale [m/s]
        paramENG.minVIT     =  0;	% Vitesse minimale [m/s]
        paramENG.maxVITP	=  1;	% Acceleration maximale [m/s^2]
        
        % Parametres du controle de braquage des roues
        paramENG.tauPHI     =  1;	% Constante de temps sur la braquage
        paramENG.maxPHI     =  5;	% Braquage maximal [°]
        paramENG.maxPHIP	= 10;	% Vitesse de braquage maximale [°/s]
        
        % Etat initial
        initENG.POS	= [0 ; 0];	% Position du vehicule
        initENG.ATT	= 0;        % Direction du vehicule [°]
        initENG.VIT	= 0;        % Vitesse du vehicule
        initENG.PHI	= 0;        % Angle de braquage des roues [°]
        
        % Enregistrement
        initENG.x	= [initENG.POS;initENG.ATT*pi/180];
        initENG.nx	= length(initENG.x);
        
    
    case 'model_ENG_2'
        %------------------------------------------------------------------
        % Modele d'un vehicule rapide
        %------------------------------------------------------------------
        
        % Parametres geometriques du vehicule
        paramENG.H	= 0.6;      % Demi-longueur de l'essieu arriere
        paramENG.L	= 1.5;      % Distance inter-essieux
        
        % Parametres du controle de vitesse
        paramENG.tauVIT     =  1;   % Constante de temps sur la vitesse
        paramENG.maxVIT     = 10;	% Vitesse maximale [m/s]
        paramENG.minVIT     =  0;	% Vitesse minimale [m/s]
        paramENG.maxVITP	=  1;	% Acceleration maximale [m/s^2]
        
        % Parametres du controle de braquage des roues
        paramENG.tauPHI     = 0.3;	% Constante de temps sur la braquage
        paramENG.maxPHI     =  5;	% Braquage maximal [°]
        paramENG.maxPHIP	= 15;	% Vitesse de braquage maximale [°/s]
        
        % Etat initial
        initENG.POS	= [0 ; 0];	% Position du vehicule
        initENG.ATT	= 0;        % Direction du vehicule [°]
        initENG.VIT	= 0;        % Vitesse du vehicule
        initENG.PHI	= 0;        % Angle de braquage des roues [°]
        
        % Enregistrement
        initENG.x	= [initENG.POS;initENG.ATT*pi/180];
        initENG.nx	= length(initENG.x);

    otherwise
        error('Modele VEHICULE inconnu');
        
end

