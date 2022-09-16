%_________________________________________________________________________%
%SFO  Sailfish optimizer�㷨             %
%_________________________________________________________________________%
function [Best_pos1,Best_score1,BSFO_curve,Ave,Std]=BSFO(pop,Max_iter,lb,ub,dim,fobj)
A = 4;
e = 0.001;
P=0.5;%����
SFpercent = 0.3;
Run_no=5;
SFNumber = round(pop*0.3);
SNumber = pop - SFNumber;
% Function_name='F14'; 
x=10;
% for m=1:5000
    
    
 for irun=1:Run_no
   ub = ub.*ones(1,dim);
   lb = lb.*ones(1,dim);  
%��Ⱥ��ʼ��
XSF0 = initialization(SFNumber,dim,ub,lb);%sailfish ��ʼ��
XS0 = initialization(SNumber,dim,ub,lb);%sardines ��ʼ��

XSF = XSF0;
XS = XS0;
%�����ʼ��Ӧ��ֵ
fitnessSF = inf(1,SFNumber);
fitnessS =inf(1,SNumber);
for i = 1:size(XSF,1)
   fitnessSF(i) =  fobj(XSF(i,:));
end
for i = 1:size(XS,1)
   fitnessS(i) = fobj(XS(i,:));
end


 [fitnessSF, indexSF]= sort(fitnessSF);%����
 Xelite = XSF(indexSF(1),:);%sailfish ����ֵ
 [fitnessS, indexS]= sort(fitnessS);%����
 Xinjured = XS(indexS(1),:);%sardines ����ֵ
 %������Ӧ������
 XSF = XSF(indexSF,:);
 XS = XS(indexS,:);
 %��¼ȫ������λ��
 if(fitnessSF(1)<fitnessS(1))
    GBestX = XSF(1,:);
    GBestF = fitnessSF(1);
 else
     GBestX = XS(1,:);
     GBestF = fitnessS(1);
 end
BSFO_curve=zeros(1,Max_iter);
for t = 1: Max_iter

    %% ����XSF
%     AP = A*((1-(2*t*e))^2);
    AP = A*sqrt(1-(2*t*e));
% AP = A*(1-(2*t*e))^(t/Max_iter);
%      AP = A*((1-(2*t*e))^2);
    PD = 1 - (size(XSF,1)/(size(XSF,1) + size(XS,1)));
    lamda = 2*rand()*PD - PD;
%   RL=0.05*levy(pop,dim,1.5);   %Levy random number vector

    Elite=repmat(Xelite,pop,1); 
    RB=randn(SFNumber,dim);          %Brownian random number vector 
  for i=1:size(XSF,1)
     for j=1:size(XSF,2)        
       R=rand();
%           ------------------ Phase 1 (Eq.12) �����˶� ------------------- 
%        if t<Max_iter.*3/4    
        if AP>=0.5
           stepsize(i,:)=RB(i,j)*(Elite(i,j)-RB(i,j)*XSF(i,:));    
%              stepsize(i,:)=RB(i,j)*(RB(i,j)*Elite(i,j)-XSF(i,:));
            XSF(i,:)=Elite(i,:)+P*R*stepsize(i,:); 
       else          

       XSF(i,:) =  Xelite - lamda.*(rand().*((Xelite + Xinjured)./2)-XSF(i,:));                              
     end 
 end
  end

     %% ����XS
     Elite1=repmat(Xinjured,pop,1); 
    RB1=randn(SNumber,dim); 
    for i=1:size(XS,1)
     for j=1:size(XS,2)        
       R=rand();
       
        if(AP<1)
            if AP<0.5      
        stepsize(i,:)=RB1(i,j)*(Elite(i,j)-RB1(i,j)*XS(i,:));      
%             stepsize(i,:)=RB1(i,j)*(RB1(i,j)*Elite(i,j)-XS(i,:));   
            XS(i,:)=Elite1(i,:)+P*R*stepsize(i,:); 
%             stepsize(i,j)=RL(i,j)*(Elite(i,j)-RL(i,j)*XS(i,j));
%             XS(i,j)=XS(i,j)+P*R*stepsize(i,j);
            else
        alpha = max(round(size(XS,1)*AP),1);
        beta = max(round(dim*AP),1);
        indexRandom = randperm(size(XS,1),alpha);%���ѡ��alpha����
        for i = 1:alpha
         XS(indexRandom(i),1:beta) = rand().*(Xelite(1:beta) - XS(indexRandom(i),1:beta) + AP);
        end
            end
           else   
         XS(i,:) = rand().*(Xelite - XS(i,:) + AP);     
        end
    end 
   
    end
%==============================
%     
%     if(AP<0.5)
%         alpha = max(round(size(XS,1)*AP),1);
%         beta = max(round(dim*AP),1);
%         indexRandom = randperm(size(XS,1),alpha);%���ѡ��alpha����
%         for i = 1:alpha
%          XS(indexRandom(i),1:beta) = rand().*(Xelite(1:beta) - XS(indexRandom(i),1:beta) + AP);
%         end
%     else
%          for i = 1:size(XS,1)
%          XS(i,:) = rand().*(Xelite - XS(i,:) + AP);
%          end
%     end
%      end
%     end
%==============================  
%        else
%          for i = 1:size(XS,1)
%          XS(i,:) = rand().*(Xelite - XS(i,:) + AP);
%          end               
%        end                                         
%      end 
%     end
    
%     
    
    
    
    %���㵱ǰ��Ӧ��ֵ
    for i = 1:size(XSF,1)
     fitnessSF(i) =  fobj(XSF(i,:));
    end
    for i = 1:size(XS,1)
     fitnessS(i) = fobj(XS(i,:));
    end
    %������Ӧ���滻
    deleteIndex = zeros(1,size(XS,1));%������¼��Ҫ�Ƴ���sardines��λ��
    for i = 1:min(size(XSF,1),size(XS,1))
        if(fitnessS(i)<fitnessSF(i))
           XSF(i,:) = XS(i,:);
           deleteIndex(i) = 1;
        end
    end
    %�����Ƴ���sardineλ��,��������λ�ô���
    for i = 1:size(XS,1)
       if(deleteIndex(i) == 1)
           XS(i,:) = rand(1,dim).*(ub-lb)+lb;
       end
    end
    
     %�߽����
   for j = 1:size(XSF,1)
       for a = 1: dim
           if(XSF(j,a)>ub(a))
               XSF(j,a) =ub(a);
           end
           if(XSF(j,a)<lb(a))
               XSF(j,a) =lb(a);
           end
       end
   end 
    for j = 1:size(XS,1)
       for a = 1: dim
           if(XS(j,a)>ub(a))
               XS(j,a) =ub(a);
           end
           if(XS(j,a)<lb(a))
               XS(j,a) =lb(a);
           end
       end
   end 
    
    for i = 1:size(XS,1)
     fitnessS(i) = fobj(XS(i,:));
    end
    XSF = XSF;
    XS  = XS;
  [fitnessSF, indexSF]= sort(fitnessSF);%����
 Xelite = XSF(indexSF(1),:);%sailfish ����ֵ
 [fitnessS, indexS]= sort(fitnessS);%����
 Xinjured = XS(indexS(1),:);%sardines ����ֵ
 %������Ӧ������
 XSF = XSF(indexSF,:);
 XS = XS(indexS,:);
 
 
 
 %��¼ȫ������λ��
 if(fitnessSF(1)<fitnessS(1))
    LocalGBestX = XSF(1,:);
    LocalGBestF = fitnessSF(1);
 else
     LocalGBestX = XS(1,:);
     LocalGBestF = fitnessS(1);
 end
 if(LocalGBestF<GBestF)
     GBestF = LocalGBestF;
     GBestX = LocalGBestX;
 end
 
   BSFO_curve(t) = GBestF;
% end


Best_pos1 = GBestX;
% Best_score1 = BSFO_curve(end);
Best_score1 = GBestF;

Arry_Fitness(irun)=Best_score1;
end
display(['Run num : ', num2str(irun)]);
display(['The best solution obtained by BSFO is : ', num2str(Best_pos1),10]);
display(['The best optimal value of the objective funciton found by BSFO is : ', num2str(Best_score1),10]);
display(sprintf('==============================='));
 end 
Ave=mean(Arry_Fitness);
Std=std(Arry_Fitness);

if x>Ave
    x=Ave;
end
% display(['Run num M: ', num2str(m)]);
% display(['The Ave by BSFO is : ', num2str(Ave,10)]);
% display(['The Std by BSFO is : ', num2str(Std,10)])
% disp(sprintf('++++++++++++++++++++++++++++++++++++'));
% end
% i=5
% if i<2
%     i=i+1;
display(['��Сֵ��: ', num2str(x)]);
end

