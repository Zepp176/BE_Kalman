function [] = plot_ESTIMATEUR(OUT_posENG,OUT_posEST,OUT_covEST,OUT_attENG,OUT_attEST)

% plot_ESTIMATEUR(OUT_posENG,OUT_posEST,OUT_covEST,OUT_attENG,OUT_attEST);
%--------------------------------------------------------------------------
% Tracés de l'état estimé du VEHICULE
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
% FIGURE 1
%--------------------------------------------------------------------------
figure;

INT_posENG = interp1(OUT_posENG.time,OUT_posENG.signals.values,OUT_posEST.time,'pchip');
INT_attENG = interp1(OUT_attENG.time,OUT_attENG.signals.values,OUT_attEST.time,'pchip');

subplot(3,2,1);hold on; grid on;
plot(OUT_posEST.time,OUT_posEST.signals.values(:,1),'b-','Linewidth',1.0);
plot(OUT_posENG.time,OUT_posENG.signals.values(:,1),'r--','Linewidth',1.0);
legend('Estimee','Vraie','Location','Best');
xlabel('x [m]');

subplot(3,2,2);hold on; grid on;
plot(OUT_posEST.time,INT_posENG(:,1)-OUT_posEST.signals.values(:,1),'b-','Linewidth',1.0);
sig = real(sqrt(squeeze(OUT_covEST.signals.values(1,1,:))));
plot(OUT_posEST.time,3*sig,'g-','Linewidth',1.0); 
plot(OUT_posEST.time,-3*sig,'g-','Linewidth',1.0);
plot(OUT_posEST.time,INT_posENG(:,1)-OUT_posEST.signals.values(:,1),'b-','Linewidth',1.0);
legend('Erreur','Intervalle de confiance','Location','Best');
xlabel('x-xest [m]');

subplot(3,2,3);hold on; grid on;
plot(OUT_posEST.time,OUT_posEST.signals.values(:,2),'b-','Linewidth',1.0);
plot(OUT_posENG.time,OUT_posENG.signals.values(:,2),'r--','Linewidth',1.0);
legend('Estimee','Vraie','Location','Best');
xlabel('y [m]');
title('Trajectoire');

subplot(3,2,4);hold on; grid on;
plot(OUT_posEST.time,INT_posENG(:,2)-OUT_posEST.signals.values(:,2),'b-','Linewidth',1.0);
sig = real(sqrt(squeeze(OUT_covEST.signals.values(2,2,:))));
plot(OUT_posEST.time,3*sig,'g-','Linewidth',1.0); 
plot(OUT_posEST.time,-3*sig,'g-','Linewidth',1.0);
plot(OUT_posEST.time,INT_posENG(:,2)-OUT_posEST.signals.values(:,2),'b-','Linewidth',1.0);
legend('Erreur','Location','Best');
xlabel('y-yest [m]');

subplot(3,2,5);hold on; grid on;
plot(OUT_attEST.time,OUT_attEST.signals.values*180/pi,'b-','Linewidth',1.0);
plot(OUT_attENG.time,OUT_attENG.signals.values*180/pi,'r--','Linewidth',1.0);
legend('Estimee','Vraie','Location','Best');
xlabel('\theta [°]');

subplot(3,2,6);hold on; grid on;
err_theta = OUT_attEST.signals.values-INT_attENG;
err_theta = atan2(sin(err_theta),cos(err_theta));
plot(OUT_attEST.time,err_theta*180/pi,'b-','Linewidth',1.0);
sig = real(sqrt(squeeze(OUT_covEST.signals.values(3,3,:))));
plot(OUT_attEST.time,3*sig*180/pi,'g-','Linewidth',1.0); 
plot(OUT_attEST.time,-3*sig*180/pi,'g-','Linewidth',1.0);
plot(OUT_attEST.time,err_theta*180/pi,'b-','Linewidth',1.0);
legend('Erreur','Location','Best');
xlabel('\theta-\thetaest [°]');

%--------------------------------------------------------------------------
% FIGURE 2
%--------------------------------------------------------------------------
figure;

subplot(3,3,[1 8]);hold on; grid on;
plot(OUT_posEST.signals.values(:,1),OUT_posEST.signals.values(:,2),'b-','Linewidth',1.0);
plot(OUT_posENG.signals.values(:,1),OUT_posENG.signals.values(:,2),'r--','Linewidth',1.0);
axis equal
legend('Estimee','Vraie','Location','Best');
xlabel('x [m]');ylabel('y [m]');
title('Trajectoire');

INT_posENG=interp1(OUT_posENG.time,OUT_posENG.signals.values,OUT_posEST.time,'pchip');
INT_attENG=interp1(OUT_attENG.time,OUT_attENG.signals.values,OUT_attEST.time,'pchip');

subplot(3,3,3);hold on; grid on;
plot(OUT_posEST.time,OUT_posEST.signals.values(:,1)-INT_posENG(:,1),'Linewidth',1.5);
xlabel('t [s]');ylabel('x [m]');
title('ERREUR de POSITION [m]');

subplot(3,3,6);hold on; grid on;
plot(OUT_posEST.time,OUT_posEST.signals.values(:,2)-INT_posENG(:,2),'Linewidth',1.5);
xlabel('t [s]');ylabel('y [m]');

subplot(3,3,9);hold on; grid on;
err_theta = OUT_attEST.signals.values-INT_attENG;
err_theta = atan2(sin(err_theta),cos(err_theta));
plot(OUT_attEST.time,err_theta*180/pi,'Linewidth',1.5);
xlabel('t [s]');ylabel('\theta [°]');
title('ERREUR de CAP');

end

