%_________________________________________________________________________
%  Marine Predators Algorithm source code (Developed in MATLAB R2015a)
%
%  programming: Afshin Faramarzi & Seyedali Mirjalili
%
% paper:
%  A. Faramarzi, M. Heidarinejad, S. Mirjalili, A.H. Gandomi, 
%  Marine Predators Algorithm: A Nature-inspired Metaheuristic
%  Expert Systems with Applications
%  DOI: doi.org/10.1016/j.eswa.2020.113377
%  
%  E-mails: afaramar@hawk.iit.edu            (Afshin Faramarzi)
%           muh182@iit.edu                   (Mohammad Heidarinejad)
%           ali.mirjalili@laureate.edu.au    (Seyedali Mirjalili) 
%           gandomi@uts.edu.au               (Amir H Gandomi)
%_________________________________________________________________________

% --------------------------------------------
% fobj = @YourCostFunction
% dim = number of your variables
% Max_iteration = maximum number of iterations
% SearchAgents_no = number of search agents
% lb=[lb1,lb2,...,lbn] where lbn is the lower bound of variable n
% ub=[ub1,ub2,...,ubn] where ubn is the upper bound of variable n
% ---------------------------------------------------------

clear all
clc
tic;
format long
Run_no=5;
SearchAgents_no=30; 
nP=SearchAgents_no;% Number of search agents
Particles_no=SearchAgents_no;
N=SearchAgents_no;
F=0.5;           % Scale Factor
Cr=0.5;

Function_name='F1'; 
Max_iteration=500; % Maximum number of iterations
T=Max_iteration;
Max_It=Max_iteration;
Max_iter=Max_iteration;
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
[Best_pos1,Best_score1,BSFO_curve,Ave,Std]=BSFO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
[Best_score,Best_pos,SFO_curve,Ave1,Std1]=SFO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
% [Convergence_curve2,Ave2,Sd2]=EO(Particles_no,Max_iteration,lb,ub,dim,fobj,Run_no);
% [Sd3,Ave3,Convergence_curve3]=WOA(SearchAgents_no,Max_iter,lb,ub,dim,fobj,Run_no);
% [Sd4,Ave4,Convergence_curve4]=GWO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,Run_no);
% [Sd5,Ave5,Convergence_curve5]=PSO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,Run_no);
% [Sd6,Ave6,Convergence_curve6]=DE(nP,Max_It,lb,ub,dim,fobj,F,Cr,Run_no);

% % % function topology
% figure('Position',[500 400 700 290])
% subplot(1,2,1);
% func_plot(Function_name);
% title('Function Topology')
% xlabel('x_1');
% ylabel('x_2');
% zlabel([Function_name,'( x_1 , x_2 )'])
% box on
% axis tight
% % %绘制历史搜索空间
% %  subplot(1,4,2);
% %  hold on
% %  func_plot_contour(Function_name);
% % for k1 = 1: size(position_history,1)
% %     for k2 = 1: size(position_history,3) % ada tukar lain sikit dpd goa boleh compare
% %         plot(position_history(k1,1,k2),position_history(k1,2,k2),'.','markersize',10,'MarkerEdgeColor','k','markerfacecolor','k');
% %     end
% % end
% % plot(Target_pos(1),Target_pos(2),'.','markersize',10,'MarkerEdgeColor','r','markerfacecolor','r');
% % title('Search history (x1 and x2 only)')
% % xlabel('x1')
% % ylabel('x2')

% % % Convergence curve
subplot(1,2,2);
semilogy(BSFO_curve,'Color','k','LineWidth',1)
hold on
semilogy(SFO_curve,'Color','r','LineWidth',1)
% hold on
% semilogy(Convergence_curve2,'Color','b','LineWidth',1)
% hold on
% semilogy(Convergence_curve3,'Color','c','LineWidth',1)
% hold on
% semilogy(Convergence_curve4,'Color','g','LineWidth',1)
% hold on
% semilogy(Convergence_curve5,'Color','m','LineWidth',1)
% hold on
% semilogy(Convergence_curve6,'Color','y','LineWidth',1)
% 
% title('Covergence')
% xlabel('Iteration');
% ylabel('Function value');
% axis tight
% grid off
% box on
% legend('BSFO','SFO','EO','WOA','GWO','PSO','DE')
% legend('EO')

display(['The Ave by BSFO is : ', num2str(Ave,10)]);
display(['The Std by BSFO is : ', num2str(Std,10)])
disp(sprintf('--------------------------------------'));
display(['The Ave by SFO is : ', num2str(Ave1),10]);
display(['TheStd by SFO is : ', num2str(Std1),10]);
disp(sprintf('--------------------------------------'));
% 
% display(['The average objective function of EO is :', num2str(Ave2,10)]);
% display(['The standard deviation of EO is : ', num2str(Sd2,10)]);
% disp(sprintf('--------------------------------------'));
% % % 
%  display(['The average objective function of WOA is :', num2str(Ave3,10)]);
%  display(['The standard deviation of WOA is : ', num2str(Sd3,10)]);
%  disp(sprintf('--------------------------------------'));
% 
% display(['The average objective function of GWO is :', num2str(Ave4,10)]);
% display(['The standard deviation of GWO is : ', num2str(Sd4,10)]);
% disp(sprintf('--------------------------------------'));
% 
% display(['The average objective function of PSO is :', num2str(Ave5,10)]);
% display(['The standard deviation of PSO is : ', num2str(Sd5,10)]);
% disp(sprintf('--------------------------------------'));

% display(['The average objective function of DE is :', num2str(Ave6,10)]);
% display(['The standard deviation of DE is : ', num2str(Sd6,10)]);
% disp(sprintf('--------------------------------------'));
        
toc;
