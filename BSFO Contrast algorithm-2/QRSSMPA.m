 %_________________________________________________________________________
%  Marine Predators Algorithm source code (Developed in MATLAB R2015a)
%
%  programming: Afshin Faramarzi & Seyedali Mirjalili
%
% paper:
%  A. Faramarzi, M. Heidarinejad, S. Mirjalili, A.H. Gandomi,  mt
%  Marine Predators Algorithm: A Nature-inspired Metaheuristic
%  Expert Systems with Applications
%  DOI: doi.org/10.1016/j.eswa.2020.113377
%  
%  E-mails: afaramar@hawk.iit.edu            (Afshin Faramarzi)
%           muh182@iit.edu                   (Mohammad Heidarinejad)
%           ali.mirjalili@laureate.edu.au    (Seyedali Mirjalili) 
%           gandomi@uts.edu.au               (Amir H Gandomi)
%_________________________________________________________________________

function [Sd1,Ave1,Convergence_curve1]=QRSSMPA(SearchAgents_no,Max_iter,lb,ub,dim,fobj,Run_no)

tic
disp('MPA1 is now tackling your problem')
for irun=1:Run_no

Top_predator_pos=zeros(1,dim);
Top_predator_fit=inf; 
%position_history=zeros(SearchAgents_no,dim,Max_iter);
Convergence_curve1=zeros(1,Max_iter);
stepsize=zeros(SearchAgents_no,dim);
fitness=inf(SearchAgents_no,1);


Prey=initialization1(SearchAgents_no,dim,ub,lb);%��ʼȺ��25*30��

% X=Prey;
% for m=1:size(X,1)
%     for n=1:size(X,2)
%         X1(m,n)=lb+ub-X(m,n);
%         C1=((lb+ub)/2);
%         if X1(m,n)<C1
%           X2(m,n)= C1+(X1(m,n)-C1)*rand();
%         else
%             X2(m,n)= X1(m,n)+(C1-X1(m,n))*rand();  
%         end
%     end
% end
% X=[X;X2];
%  for o=1:size(X,1)
%  fitness(o,1)=fobj(X(o,:));
%  end
%  [~,index]=sort(fitness);
%   X2=X(index,:);
%  Prey=X2(1:25,:);
%  fitness=fitness(1:25,:);
 
Xmin=repmat(ones(1,dim).*lb,SearchAgents_no,1);
Xmax=repmat(ones(1,dim).*ub,SearchAgents_no,1);%�߽�
         

Iter=0;
FADs=0.2;
%FADs=Iter/Max_iter;
P=0.5;%����
%P=(2-2*(Iter/Max_iter)^2)/2;
while Iter<Max_iter    
     %------------------- Detecting top predator ----------------- %Խ�紦����ѡ��Ӧ����õĲ�ʳ��   
 for i=1:size(Prey,1)  
        
    Flag4ub=Prey(i,:)>ub;
    Flag4lb=Prey(i,:)<lb;    
    Prey(i,:)=(Prey(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;                    
        
    fitness(i,1)=fobj(Prey(i,:));
     %position_history(i,:,1)=Prey(i,:);             
     if fitness(i,1)<Top_predator_fit 
       Top_predator_fit=fitness(i,1); 
       Top_predator_pos=Prey(i,:);
     end          
 end   
     %------------------- Marine Memory saving ------------------- %�洢����
    
 if Iter==0
   fit_old=fitness;    Prey_old=Prey;
 end
     
  Inx=(fit_old<fitness);
  Indx=repmat(Inx,1,dim);
  Prey=Indx.*Prey_old+~Indx.*Prey;
  fitness=Inx.*fit_old+~Inx.*fitness;
        
  fit_old=fitness;    Prey_old=Prey;

     %------------------------------------------------------------   
     
 Elite=repmat(Top_predator_pos,SearchAgents_no,1);  %(Eq. 10) 
 CF=(1-Iter/Max_iter)^(2*(Iter)/(Max_iter));
%CF=((2-2*(Iter/Max_iter)^3)/2);
%CF=(1-Iter/Max_iter)^(2*(Iter)/(Max_iter));
% P=chaos(6,1,1);  
 RL=0.05*levy(SearchAgents_no,dim,1.5);   %Levy random number vector
 RB=randn(SearchAgents_no,dim);          %Brownian random number vector
  b=1;  
  l=(CF-1)*rand+1;
  for i=1:size(Prey,1)
     for j=1:size(Prey,2)        
       R=rand();
          %------------------ Phase 1 (Eq.12) �����˶� ------------------- 
       if Iter<Max_iter/3 
           
%            
           stepsize(i,:)=RB(i,j)*(Elite(i,j)-RB(i,j)*Prey(i,:));                    
            Prey(i,:)=Elite(i,:)+P*R*stepsize(i,:); 

          %--------------- Phase 2 (Eqs. 13 & 14)һ�벼��һ����ά�˶�----------------
       elseif Iter>Max_iter/3 && Iter<2*Max_iter/3 
          
         if i>size(Prey,1)/2
            stepsize(i,j)=RB(i,j)*(RB(i,j)*Elite(i,j)-Prey(i,j));
            Prey(i,j)=Elite(i,j)+P*CF*stepsize(i,j); 
         else
            stepsize(i,j)=RL(i,j)*(Elite(i,j)-RL(i,j)*Prey(i,j));                      
            Prey(i,j)=Prey(i,j)+P*R*stepsize(i,j);  
         end  
         
         %----------------- Phase 3 (Eq. 15)-��ά�˶�------------------
       else 
           
%             stepsize(i,j)=RL(i,j)*Elite(i,j)-Prey(i,j); 
%            Prey(i,j)=Elite(i,j)+P*stepsize(i,j)*exp(b.*l).*cos(l.*2*pi);  
   if P>rand()
               stepsize(i,j)=RL(i,j)*(RL(i,j)*Elite(i,j)-Prey(i,j)); 
           Prey(i,j)=Elite(i,j)+P*CF*stepsize(i,j);  
           else
               stepsize(i,j)=abs(Elite(i,j)-Prey(i,j)); 
            Prey(i,j)=Elite(i,j)+P*stepsize(i,j)*exp(b.*l).*cos(l.*2*pi);
   end
    
       end  
      end                                         
  end    
        
     %------------------ Detecting top predator ------------------ ������Ⱥ��Խ�紦����ѡ������ʳ��       
  for i=1:size(Prey,1)  
        
    Flag4ub=Prey(i,:)>ub;  
    Flag4lb=Prey(i,:)<lb;  
    Prey(i,:)=(Prey(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
  
    fitness(i,1)=fobj(Prey(i,:));
        
      if fitness(i,1)<Top_predator_fit 
         Top_predator_fit=fitness(i,1);
         Top_predator_pos=Prey(i,:);
      end     
  end
        
     %---------------------- Marine Memory saving ----------------�洢����
    
 if Iter==0
    fit_old=fitness;    Prey_old=Prey;
 end
     
    Inx=(fit_old<fitness);
    Indx=repmat(Inx,1,dim);
    Prey=Indx.*Prey_old+~Indx.*Prey;
    fitness=Inx.*fit_old+~Inx.*fitness;
        
    fit_old=fitness;    Prey_old=Prey;

     %---------- Eddy formation and FADs? effect (Eq 16) -----------���ַ�ʽ�������оֲ����� 
                            
  if rand()<FADs
     U=rand(SearchAgents_no,dim)<FADs;                                                                                              
     Prey=Prey+CF*((Xmin+rand(SearchAgents_no,dim).*(Xmax-Xmin)).*U);

  else
           r=rand();  Rs=size(Prey,1);
          stepsize=(FADs*(1-r)+r)*(Prey(randperm(Rs),:)-Prey(randperm(Rs),:));
        Prey=Prey+stepsize;
%     S=2;
%          for i=1:SearchAgents_no          
%               Prey(i,:)=Prey(i,:)+S*(rand*Top_predator_pos-rand*Prey(i,:)); %Equation (8)
%          end
%          for j=1:SearchAgents_no 
%                lb1=lb(1,1)*ones(1,dim);
%              ub1=ub(1,1)*ones(1,dim);
%            Prey(j,:)=lb1+ub1-Prey(j,:)*rand();
%           end
   end
  

                                                
  Iter=Iter+1;  
  Convergence_curve1(Iter)=Top_predator_fit; 
  Ceqfit_run(irun)=Top_predator_fit;
end
display(['Run no : ', num2str(irun)]);
display(['The best solution obtained by QRSSMPA is : ', num2str(Top_predator_pos,10)]);
display(['The best optimal value of the objective funciton found by QRSSMPA is : ', num2str(Top_predator_fit,10)]);
disp(sprintf('--------------------------------------'));
end
%�����������ֵ

Ave1=mean(Ceqfit_run);
Sd1=std(Ceqfit_run);
time=toc;


