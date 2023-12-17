clc;
clear all;
close all;
%startup_rvc

L(1)=Link('revolute','d', 242.9/1000, 'a', 0, 'alpha', pi/2,'qlim',deg2rad([0, 240]));
L(2)=Link('revolute','d', 0, 'a', 230/1000 , 'alpha', 0,'qlim',deg2rad([-45, 150]));
L(3)=Link('revolute','d', 0, 'a', 250/1000, 'alpha', 0,'qlim',deg2rad([-65, 90]));

Robot = SerialLink(L);
Robot.name="MA2000";

q=[0 0 0];
% 
figure
hold on
Robot.plot(q)
%Robot.teach

%% Verificar area de trabalho
% Parâmetros
R = 0.480;  % Raio da esfera
theta_start = deg2rad(0);    % Ângulo inicial em radianos
theta_end = deg2rad(240);    % Ângulo final em radianos
phi_start = deg2rad(-45);    % Ângulo inicial em radianos
phi_end = deg2rad(150);      % Ângulo final em radianos

centroz= 242.9/1000; %Altura

% Geração de malha esférica
theta = linspace(theta_start, theta_end, 100);
phi = linspace(phi_start, phi_end, 100);
[theta, phi] = meshgrid(theta, phi);

% Coordenadas esféricas para cartesianas
x = R * sin(phi) .* cos(theta);
y = R * sin(phi) .* sin(theta);
z = centroz + R * cos(phi);

% Plotagem da superfície usando surf
%figure;
surf(x, y, z, 'EdgeColor', 'none');
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Área de trabalho');
axis equal;

%% Verificação de ponto

% Função para verificar se um ponto está dentro da esfera
pointInsideSphere = @(x, y, z) (x^2 + y^2 + (z - centroz)^2) <= R^2;

% Pontos para verificar
point1 = [0.2, 0.3, 0.5];
point2 = [0.1, 0.2, 0.7];

% Verifica se os pontos estão dentro da esfera
isPoint1InsideSphere = pointInsideSphere(point1(1), point1(2), point1(3));
isPoint2InsideSphere = pointInsideSphere(point2(1), point2(2), point2(3));

% Exibe os resultados
disp(['O ponto 1 está dentro da esfera: ' num2str(isPoint1InsideSphere)]);
disp(['O ponto 2 está dentro da esfera: ' num2str(isPoint2InsideSphere)]);

%% Trajetoria desejada 
% (- Estabelecer angulos
% - Pegar coordenadas
% - Singularidade final e inicial
% - Formar trajetoria
% - Singularidade Geral)

% Fixando os ultimos 2 elos
t1_11= deg2rad(0); t2_11=deg2rad(30); t3_11=deg2rad(10);
t1_12= deg2rad(30); t2_12=deg2rad(100); t3_12=deg2rad(10);

% % Fixando primeiro elo
% t1_11= deg2rad(10); t2_11=deg2rad(30); t3_11=deg2rad(10);
% t1_12= deg2rad(10); t2_12=deg2rad(90); t3_12=deg2rad(60);

% % Sem fixação

% t1_11= deg2rad(20); t2_11=deg2rad(40); t3_11=deg2rad(10);
% t1_12= deg2rad(50); t2_12=deg2rad(100); t3_12=deg2rad(45);

%Etapas

thetas1=[t1_11 t2_11 t3_11];
thetas2=[t1_12 t2_12 t3_12];

[Trajeto1,qd,qdd]=jtraj(thetas1,thetas2,15);

[Traje1_sin,teste1]=deter(Trajeto1(:,1),Trajeto1(:,2),Trajeto1(:,3));

% x11=cos(t1_11).*(L1.*cos(t2_11)+L2.*cos(t2_11+t3_11));
% y11=sin(t1_11).*(L1.*cos(t2_11)+L2.*cos(t2_11+t3_11));
% z11=L0+L1.*sin(t2_11)+L2.*sin(t2_11+t3_11);
% p_i1=[x11,y11,z11];
% x12=cos(t1_11)*(L1*cos(t2_11)+L2*cos(t2_11+t3_11));
% y12=sin(t1_11)*(L1*cos(t2_11)+L2*cos(t2_11+t3_11));
% z12=L0+L1*sin(t2_11)+L2*sin(t2_11+t3_11);
% p_f1=[x12,y12,z12];
%Trajeto1=jtraj(Robot,p_i1,p_f1,5);

% verificar singularidade 

function [determinante,teste] = deter(t1,t2,t3)
L0=242.9/1000;
L1=230/1000;
L2=250/1000;
determinante= sin(t2)*L1^2*L2.*cos(t2 + t3).*cos(t1).^2.*cos(t2) + sin(t2).*L1^2*L2.*cos(t2 + t3).*cos(t2).*sin(t1).^2 - sin(t2 + t3)*L1^2*L2.*cos(t1).^2.*cos(t2).^2 - sin(t2 + t3)*L1^2*L2.*cos(t2).^2.*sin(t1).^2 + sin(t2)*L1*L2^2.*cos(t2 + t3).^2.*cos(t1).^2 + sin(t2)*L1*L2^2.*cos(t2 + t3).^2.*sin(t1).^2 - sin(t2 + t3).*L1*L2^2.*cos(t2 + t3).*cos(t1).^2.*cos(t2) - sin(t2 + t3).*L1*L2^2.*cos(t2 + t3).*cos(t2).*sin(t1).^2;
teste = all(determinante~=0); % Se 1, não há singularidade 
end