% Results: 

plotModelCont(NodeTable, Node_U_V(:,1), ix, numel, nen, 1, 1, 2, 'Displacement Contour - u_x')
plotModelCont(NodeTable, Node_U_V(:,2), ix, numel, nen, 1, 2, 2, 'Displacement Contour - u_y')
plotModel(NodeTable2, ix, numel, nen, 2, 1, 1, 'Deformed Configuration', 'y', 'y')
plotModel(NodeTable, ix, numel, nen, 2, 1, 1, 'Un-Deformed Configuration', 'n', 'n')


figure(3)
plot(time,Stress(:,1),time,Stress(:,2),time,Stress(:,3),'LineWidth',1.2)
xl11 = xlabel('Time (t)','FontWeight','bold','FontSize',18);
set(xl11,'Interpreter','latex')
yl11=ylabel('Stress','FontWeight','bold','FontSize',18);
set(yl11,'Interpreter','latex')
legend({'\sigma_1_1','\sigma_2_2','\sigma_1_2'},'FontWeight','bold','FontSize',14);
title('Stress at each load step','FontWeight','bold','FontSize',22)
grid on

figure(4)
plot(Strain(:,1),Stress(:,1),Strain(:,2),Stress(:,2),Strain(:,3),Stress(:,3),'LineWidth',1.2)
xl2 = xlabel('Strain','FontWeight','bold','FontSize',22);
set(xl2,'Interpreter','latex')
yl2 = ylabel('Stress','FontWeight','bold','FontSize',22);
set(yl2,'Interpreter','latex')
legend({'\sigma_1_1','\sigma_2_2','\sigma_1_2'},'FontWeight','bold','FontSize',14)
title('Stress-Strain','FontWeight','bold','FontSize',22)
grid on

figure(5)
plot(time,dn(:,3),'--',time,dn(:,4),'LineWidth',1.8)
xl3 = xlabel('Time (t)','FontWeight','bold','FontSize',22);
set(xl3,'Interpreter','latex');
yl3 = ylabel('Displacement (d)','FontWeight','bold','FontSize',22);
set(yl3,'Interpreter','latex');
legend({'d_x','d_y'},'FontWeight','bold','FontSize',14)
title('Displacement of the Node ','FontWeight','bold','FontSize',22)
grid on

% Writing the Residual Values to the excel file 
filename = 'Residual_4d.xlsx';
xlswrite(filename,residual);

% Plotting the Residual - Values : 
t_res10 = 1:length(residual(500,:));
t_res50 = 1:length(residual(1000,:));

figure(6)
semilogy(t_res10,residual(10,:),t_res50,residual(50,:),'Linewidth',1.2)
xl4 = xlabel('Iteration (iter)','FontWeight','bold','FontSize',22);
set(xl4,'Interpreter','latex');
yl4 = ylabel('Norm of the Residual','FontWeight','bold','FontSize',22);
set(yl4,'Interpreter','latex');
legend({'N = 500','N = 1000'},'FontWeight','bold','FontSize',14)
title('Residual Reduction ','FontWeight','bold','FontSize',22)
grid on