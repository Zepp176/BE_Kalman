function [paramGPS] = modele_GPS(nom)

% [paramGPS] = modele_GPS(nom);
%--------------------------------------------------------------------------
% Modèle GPS
%--------------------------------------------------------------------------
%   nom :   Nom du modele a utiliser
%
%	paramGPS :	structure contenant les parametres du modele
%--------------------------------------------------------------------------

if nargin==0
    nom = 'model_GPS_1';
end

switch nom
    
    case 'model_GPS_1'
        %------------------------------------------------------------------
        % Modele GPS parfait
        %------------------------------------------------------------------

        % Parametres
        paramGPS.dt         = 1.0;	% Pas d'echantillonnage [s]
        paramGPS.sig_pos    = 0;	% Ecart-type du bruit [m]
        paramGPS.per_sau    = 30;	% Periode moyenne entre sauts [s]
        paramGPS.amp_sau    = 0;	% Amplitude maximale du cumul des sauts [s]
    
    case 'model_GPS_2'
        %------------------------------------------------------------------
        % Modele GPS sans sauts
        %------------------------------------------------------------------

        % Parametres
        paramGPS.dt         = 1.0;	% Pas d'echantillonnage [s]
        paramGPS.sig_pos    = 2/3;	% Ecart-type du bruit [m]
        paramGPS.per_sau    = 30;	% Periode moyenne entre sauts [s]
        paramGPS.amp_sau    = 0;	% Amplitude maximale du cumul des sauts [s]

    case 'model_GPS_3'
        %------------------------------------------------------------------
        % Modele GPS réaliste
        %------------------------------------------------------------------

        % Parametres
        paramGPS.dt         = 1.0;	% Pas d'echantillonnage [s]
        paramGPS.sig_pos    = 2/3;	% Ecart-type du bruit [m]
        paramGPS.per_sau    = 30;	% Periode moyenne entre sauts [s]
        paramGPS.amp_sau    = 10;	% Amplitude maximale du cumul des sauts [s]
    
    otherwise
        error('Modele GPS inconnu');
        
end
