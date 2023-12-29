# TCC

:brazil: Este repositório contém o trabalho de conclusão de curso em Engenharia Mecânica desenvolvido por Wallace Matias Felix de Paiva em dezembro de 2023, intitulado "Desenvolvimento, Fabricação e Controle de um Manipulador Robótico".

O arquivo em PDF do trabalho está disponível neste repositório. No entanto, para acessá-lo pelo sistema Maxwell da Pontifícia Universidade Católica do Rio de Janeiro (PUC-Rio).
Link: https://www.maxwell.vrac.puc-rio.br/colecao.php?strSecao=resultado&nrSeq=65644@1

:uk: This repository contains the final project in Mechanical Engineering developed by Wallace Matias Felix de Paiva in December 2023, titled "Development, Manufacturing, and Control of a Robotic Manipulator."

The PDF file of the project is available in this repository. However, it can also be accessed through the Maxwell system of the Pontifical Catholic University of Rio de Janeiro (PUC-Rio).
Link: https://www.maxwell.vrac.puc-rio.br/colecao.php?strSecao=resultado&nrSeq=65644@2


# Resumo simples

:brazil: Este trabalho propõe um manipulador robótico de 3 graus de liberdade a partir de um manipulador fora de uso do Laboratório de Robótica, o MA2000. O objetivo é contribuir academicamente introduzindo conceitos fundamentais de robótica ao longo do processo de concepção, fabricação e controle. O projeto incluiu a modelagem do manipulador, a escolha de componentes eletrônicos, a fabricação de peças por manufatura aditiva e a implementação de um controle proporcional-derivativo (PD) utilizando a biblioteca de Peter Corke. Os resultados obtidos demonstraram um acoplamento satisfatório com as respostas desejadas, contribuindo para o desenvolvimento acadêmico e compreensão aprofundada da robótica.

:uk: This project proposes a 3-degree-of-freedom robotic manipulator using an out-of-use manipulator from the Robotics Laboratory, the MA2000. The aim is to contribute academically by introducing fundamental robotics concepts throughout the design, manufacturing, and control processes. The project involved modeling the manipulator, selecting electronic components, manufacturing parts using additive manufacturing, and implementing a proportional-derivative (PD) control using Peter Corke's library. The obtained results demonstrated satisfactory coupling with the desired responses, contributing to academic development and a deeper understanding of robotics.

# Manipulador (Braço robotico)

:brazil: O resultado final é uma reestruturação do MA2000, um manipulador antigo em desuso na instituição, com ausência de manutenção e eletrônica. A manipulador foi cedido e se encontra no Laboratório de Robótica (LabRob), no Tecgraf, localizado na PUC-Rio.

:uk: The final result is a restructuring of the MA2000, an old manipulator that was out of use in the institution, lacking maintenance and electronics. The manipulator was provided and is located in the Robotics Laboratory (LabRob), at Tecgraf, within PUC-Rio.

![image](https://github.com/wallace-matias/TCC_manipulador/assets/150620617/974988e9-249c-4552-97ba-ab9495f53c43)

:brazil: Antes da construção, o modelo CAD foi desenvolvido no SolidWorks, disponível na pasta CAD.  

:uk: Before construction, the CAD model was developed in SolidWorks, available in folde CAD. 

<img src="https://github.com/wallace-matias/TCC_manipulador/assets/150620617/23c9f2e6-8448-4bee-b7c9-7f842f5e4e57" width="600px"/>

:brazil: Além da utilização de partes do MA2000 original, foram impressas peças, usando impressora 3D (tecnologia FDM), incluindo uma garra funcional.

:uk: In addition to using parts from the original MA2000, parts were 3D printed using Fused Deposition Modeling (FDM) technology, including a functional gripper.

<img src="https://github.com/wallace-matias/TCC_manipulador/assets/150620617/c557dd4f-d49e-4992-b60e-7fd01cc50ab4" width="600px"/>

:brazil: Um esquemático eletrônico para os motores DC das juntas também é apresentado. Embora o código completo para o funcionamento dos motores não esteja disponível devido à falta de testes práticos, o código para a operação da garra, que utiliza um servo motor, está incluído.

:uk: An electronic schematic for the DC motors of the joints is also presented. While the complete code for the motor operation is not available due to a lack of practical tests, the code for the gripper operation, which uses a servo motor, is included.

<img src="https://github.com/wallace-matias/TCC_manipulador/assets/150620617/c431c156-b17e-4811-97ae-6fd6c6ce8600" width="600px"/>


# Controle

:brazil: O controle do manipulador envolveu a modelagem cinemática e dinâmica, com a definição do espaço de trabalho máximo baseado nas limitações das juntas. O controlador PD foi simulado no MATLAB com a Robotics Toolbox de Peter Corke. 

:uk: The control of the manipulator involved kinematic and dynamic modeling, defining the maximum workspace based on joint limitations. The PD controller was simulated in MATLAB using Peter Corke's Robotics Toolbox.

<img src="https://github.com/wallace-matias/TCC_manipulador/assets/150620617/e2f038ad-3bab-4992-adce-522be763d9a0" width="600px"/>

:brazil: Três trajetórias foram definidas, e os resultados de posição da terceira trajetória, que envolve o movimento de todas as juntas, são apresentados em um gráfico. Os arquivos de plotagem e simulação estão na pasta MATLAB.

:uk: Three trajectories were defined, and the position results of the third trajectory, involving the movement of all joints, are presented in a graph. Plotting and simulation files are in folder MATLAB.

<img src="https://github.com/wallace-matias/TCC_manipulador/assets/150620617/0de4d7ea-4310-420d-b9f6-98b1a7db3a01" width="600px"/>
