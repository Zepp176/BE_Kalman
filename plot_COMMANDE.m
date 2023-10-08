function [] = plot_COMMANDE(OUT_consVIT,OUT_VIT,OUT_consPHI,OUT_PHI)

% plot_COMMANDE(OUT_consVIT,OUT_VIT,OUT_consPHI,OUT_PHI);
%--------------------------------------------------------------------------
% Traces des commandes ENGIN
%--------------------------------------------------------------------------

figure;

subplot(2,1,1);hold on; grid on;
plot(OUT_consVIT.time,OUT_consVIT.signals.values,'b--','Linewidth',1.0);
plot(OUT_VIT.time,OUT_VIT.signals.values,'b-','Linewidth',1.5);
legend('Consigne','Valeur','Location','Best');
title('Actionneur: Vitesse [m/s]');

subplot(2,1,2);hold on; grid on;
plot(OUT_consPHI.time,OUT_consPHI.signals.values,'b--','Linewidth',1.0);
plot(OUT_PHI.time,OUT_PHI.signals.values,'b-','Linewidth',1.5);
legend('Consigne','Valeur','Location','Best');
title('Actionneur: Braquage [°]');

end

