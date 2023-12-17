clc;
clear all;
close all;
%startup_rvc

global P D qt tau_all taug_all

L(1)=Link('revolute','d', 242.9/1000, 'a', 0, 'alpha', pi/2,'qlim',[-pi/2, pi]);
L(2)=Link('revolute','d', 0, 'a', 230/1000, 'alpha', 0,'qlim',[-pi/4, 5*pi/4]);
L(3)=Link('revolute','d', 0, 'a', 250/1000, 'alpha', 0,'qlim',[-pi/2,pi/2]);

% Massas [1x1]
L(1).m=3.259;
L(2).m=0.754;
L(3).m=0.582;

% Inercia [3x3]
L(1).I=[0.156,0.001,0.012;
    0.001,0.155,0.016;
    0.012,0.016,0.010];
L(2).I=[0.001,0.000,0.001;
    0.000,0.012,0.000;
    0.001,0.000,0.013];
L(3).I=[0.002,0,0;
    0,0.007,0;
    0,0,0.005];

% Centro de massa [1x3]
L(1).r=[0.015 0.023 0.209];
L(2).r=[0.081 0.000 0.006];
L(3).r=[0.020 -0.005 -0.045];

Robot = SerialLink(L);
Robot.name="MA2000";

% Fixando os ultimos 2 elos
% t1_11= deg2rad(0); t2_11=deg2rad(30); t3_11=deg2rad(10);
% t1_12= deg2rad(30); t2_12=deg2rad(100); t3_12=deg2rad(10);

% % Fixando primeiro elo
t1_11= deg2rad(10); t2_11=deg2rad(30); t3_11=deg2rad(10);
t1_12= deg2rad(10); t2_12=deg2rad(90); t3_12=deg2rad(60);

% % Sem fixação

% t1_11= deg2rad(20); t2_11=deg2rad(40); t3_11=deg2rad(10);
% t1_12= deg2rad(50); t2_12=deg2rad(100); t3_12=deg2rad(45);

thetas1=[t1_11 t2_11 t3_11]; % conjunto inicial
thetas2=[t1_12 t2_12 t3_12]; %conjunto final

tt=[0:0.01:5]';

[Trajeto1,qd1,qdd1]=jtraj(thetas1,thetas2,tt);
qt=[tt Trajeto1 qd1];

tau_all=[];
taug_all=[];

%%

P = [1 1 1]*350;%350; % set gains
D = [1 1 1]*40;%37;

[t,q,qd] = Robot.nofriction().fdyn(5, @mytorque,thetas1,[0,0,0]); %nofriction() desconsidera atrito das juntas
%[t,q,qd] = Robot.fdyn(1, @mytorque,thetas1,[0,0,0]);

%clf; Robot.plot(q);
%%
%
% figure
% XYZ=transl(Robot.fkine(Trajeto1));
% plot3(XYZ(:,1),XYZ(:,2),XYZ(:,3)) %plotar trajetória
% Robot.plot(Trajeto1(end,:))
% title("Trajetória 1")

% Do caminho realizado/desejado - angulos
% figure
% subplot(3,1,1); plot(t,q(:,1),tt,Trajeto1(:,1),"--"); xlabel('Time (s)'); ylabel('Junta 1 (rad)');legend("q1_{r}","q1_{d}")
% title("Grafico dos ângulos das juntas")
% subplot(3,1,2); plot(t,q(:,2),tt,Trajeto1(:,2),"--"); xlabel('Time (s)'); ylabel('Junta 2 (rad)');legend("q2_{r}","q2_{d}")
% subplot(3,1,3); plot(t,q(:,3),tt,Trajeto1(:,3),"--"); xlabel('Time (s)'); ylabel('Junta 3 (rad)');legend("q3_{r}","q3_{d}")
figure; plot(t,q(:,1),"-b",tt,Trajeto1(:,1),"--b",t,q(:,2),"-g",tt,Trajeto1(:,2),"--g",t,q(:,3),"-r",tt,Trajeto1(:,3),"--r"); xlabel('Tempo (s)'); ylabel('Posição (rad)'); legend("q1_{r}","q1_{d}","q2_{r}","q2_{d}","q3_{r}","q3_{d}")
% title("Ângulos das juntas - Trajetória 1")
title("Ângulos das juntas - Trajetória 2")
% title("Ângulos das juntas - Trajetória 3")

% Do caminho realizado/desejado - velocidades
% figure
% subplot(3,1,1); plot(t,qd(:,1),tt,qd1(:,1),"--"); xlabel('Time (s)'); ylabel('Junta 1 (rad/s)'); legend("qd1_{r}","qd1_{d}")
% title("Grafico das velocidades das juntas")
% subplot(3,1,2); plot(t,qd(:,2),tt,qd1(:,2),"--"); xlabel('Time (s)'); ylabel('Junta 2 (rad/s)'); legend("qd2_{r}","qd2_d")
% subplot(3,1,3); plot(t,qd(:,3),tt,qd1(:,3),"--"); xlabel('Time (s)'); ylabel('Junta 3 (rad/s/s)'); legend("qd3_{r}","qd3_d")
figure; plot(t,qd(:,1),"-b",tt,qd1(:,1),"--b",t,qd(:,2),"-g",tt,qd1(:,2),"--g",t,qd(:,3),"-r",tt,qd1(:,3),"--r"); xlabel('Tempo (s)'); ylabel('Velocidade (rad/s)'); legend("qd1_{r}","qd1_{d}","qd2_{r}","qd2_{d}","qd3_{r}","qd3_{d}")
% title("Velocidades das juntas - Trajetória 1")
title("Velocidades das juntas - Trajetória 2")
% title("Velocidades das juntas - Trajetória 3")

% Do caminho realizado - Torque Gerado
% figure
% plot(tau_all(:,1),tau_all(:,2),"-b",tau_all(:,1),tau_all(:,3),"-g",tau_all(:,1),tau_all(:,4),"-r"); xlabel('Time (s)'); ylabel('Torque N.m');legend("tau1","tau2","tau3")
% title("Torque das juntas - Trajetória 1")
% % title("Torque das juntas - Trajetória 2")
% % title("Torque das juntas - Trajetória 3")


% figure
% plot(taug_all(:,1),taug_all(:,2:4)); xlabel('Time (s)'); ylabel('Torque_g N.m')

%%
function tau = mytorque(robot,t,q,qd)
    global P D qt tau_all taug_all
    if t> qt(length(qt),1)
        t= qt(length(qt),1);
    end
    q_cd=interp1(qt(:,1),qt(:,2:4),t); %caminho desejado
    qd_cd=interp1(qt(:,1),qt(:,5:7),t); % velocidade desejada

    errop=q_cd-q;
    errov=qd_cd-qd;
    tau = errop*diag(P) + errov*diag(D);  % P, D are 3x3
    tau_all=[tau_all;t tau];
    %taug = robot.gravload(q);
    %taug_all=[taug_all;t tau];
end