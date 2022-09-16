%_________________________________________________________________________%
% 2019�����Ż��㷨             %
%_________________________________________________________________________%
% ʹ�÷���
%__________________________________________
% fobj = @YourCostFunction        �趨��Ӧ�Ⱥ���
% dim = number of your variables   �趨ά��
% Max_iteration = maximum number of generations �趨����������
% SearchAgents_no = number of search agents   ��Ⱥ����
% lb=[lb1,lb2,...,lbn] where lbn is the lower bound of variable n  �����±߽�
% ub=[ub1,ub2,...,ubn] where ubn is the upper bound of variable n   �����ϱ߽�
% If all the variables have equal lower bound you can just
% define lb and ub as two single number numbers

% To run SSA: [Best_pos,Best_score,curve]=EHO(pop,Max_iter,lb,ub,dim,fobj)
%__________________________________________

clear all 
clc
% rng('default');
SearchAgents_no=5000; % Number of search agents ��Ⱥ����
pop=SearchAgents_no;
% Function_name='F1'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper) �趨��Ӧ�Ⱥ���

Max_iteration=500; % Maximum numbef of iterations �趨����������
dim = 18;
H_target =5;
lb=0;
ub=3;
% Load details of the selected benchmark function
% [lb,ub,dim,fobj]=Get_Functions_details(Function_name);  %�趨�߽��Լ��Ż�����

% [Best_score,Best_pos,SFO_curve,Ave,Std]=BLSFO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj); %��ʼ�Ż�
[GBestX,GBestF,SFO_curve,DNASet] = BSFO(SearchAgents_no,Max_iteration,lb,ub,dim);
BestDNASet = DNAcode(DNASet);
[Tm,GC] = GCTmBioBox(BestDNASet);
std(Tm,0)
% figure('Position',[269   240   660   290])
% %Draw search space
% subplot(1,2,1);
% func_plot(Function_name);
% title('Parameter space')
% xlabel('x_1');
% ylabel('x_2');
% zlabel([Function_name,'( x_1 , x_2 )'])
%  
% %Draw objective space
% subplot(1,2,2);
% plot(SFO_curve,'Color','r')
% title('Objective space')
% xlabel('Iteration');
% ylabel('Best score obtained so far');
% 
% axis tight
% grid on
% box on
% legend('BLSFO')
% 
% display(['The Ave by BLSFO is : ', num2str(Ave,10)]);
% display(['TheStd by BSFO is : ', num2str(Std,10)]);

        



