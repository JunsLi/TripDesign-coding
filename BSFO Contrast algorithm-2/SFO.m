%_________________________________________________________________________%
%SFO  Sailfish optimizer算法             %
%_________________________________________________________________________%
function [Best_pos,Best_score,curve,Ave1,Std1]=SFO(pop,Max_iter,lb,ub,dim,fobj)
A = 4;
e = 0.001;
P=0.5;%参数
SFpercent = 0.3;
Run_no=30;
SFNumber = round(pop*0.3);
SNumber = pop - SFNumber;
 for irun=1:Run_no
   ub = ub.*ones(1,dim);
   lb = lb.*ones(1,dim);  
%种群初始化
XSF0 = initialization(SFNumber,dim,ub,lb);%sailfish 初始化
XS0 = initialization(SNumber,dim,ub,lb);%sardines 初始化

XSF = XSF0;
XS = XS0;
%计算初始适应度值
fitnessSF = zeros(1,SFNumber);
fitnessS = zeros(1,SNumber);
for i = 1:size(XSF,1)
   fitnessSF(i) =  fobj(XSF(i,:));
end
for i = 1:size(XS,1)
   fitnessS(i) = fobj(XS(i,:));
end


 [fitnessSF, indexSF]= sort(fitnessSF);%排序
 Xelite = XSF(indexSF(1),:);%sailfish 最优值
 [fitnessS, indexS]= sort(fitnessS);%排序
 Xinjured = XS(indexS(1),:);%sardines 最优值
 %根据适应度排序
 XSF = XSF(indexSF,:);
 XS = XS(indexS,:);
 %记录全局最优位置
 if(fitnessSF(1)<fitnessS(1))
    GBestX = XSF(1,:);
    GBestF = fitnessSF(1);
 else
     GBestX = XS(1,:);
     GBestF = fitnessS(1);
 end
curve=zeros(1,Max_iter);
XSFnew = XSF;
XSnew = XS;
for t = 1: Max_iter
   %% 更新XSF
     AP=A*(1-t/Max_iter)^2;
    PD = 1 - (size(XSF,1)/(size(XSF,1) + size(XS,1)));
    lamda = 2*rand()*PD - PD;

    for i = 1:size(XSFnew,1)
       XSFnew(i,:) =  Xelite - lamda.*(rand().*((Xelite + Xinjured)./2)-XSF(i,:));
    end

     %% 更新XS

    AP = A*(1-(2*t*e));
    if(AP<0.5)
        alpha = max(round(size(XS,1)*AP),1);
        beta = max(round(dim*AP),1);
        indexRandom = randperm(size(XS,1),alpha);%随机选择alpha个鱼
        for i = 1:alpha
         XSnew(indexRandom(i),1:beta) = rand().*(Xelite(1:beta) - XS(indexRandom(i),1:beta) + AP);
        end
    else
         for i = 1:size(XSnew,1)
         XSnew(i,:) = rand().*(Xelite - XS(i,:) + AP);
         end
    end

     %边界控制
   for j = 1:size(XSFnew,1)
       for a = 1: dim
           if(XSFnew(j,a)>ub(a))
               XSFnew(j,a) =ub(a);
           end
           if(XSFnew(j,a)<lb(a))
               XSFnew(j,a) =lb(a);
           end
       end
   end 
    for j = 1:size(XSnew,1)
       for a = 1: dim
           if(XSnew(j,a)>ub)
               XSnew(j,a) =ub(a);
           end
           if(XSnew(j,a)<lb)
               XSnew(j,a) =lb(a);
           end
       end
   end 
    %计算当前适应度值
    for i = 1:size(XSF,1)
     fitnessSF(i) =  fobj(XSFnew(i,:));
    end
    for i = 1:size(XS,1)
     fitnessS(i) = fobj(XSnew(i,:));
    end
    %更据适应度替换
    deleteIndex = zeros(1,size(XSnew,1));%用来记录需要移除的sardines的位置
    for i = 1:min(size(XSFnew,1),size(XSnew,1))
        if(fitnessS(i)<fitnessSF(i))
           XSFnew(i,:) = XSnew(i,:);
           deleteIndex(i) = 1;
        end
    end
    %更新移除的sardine位置,利用其他位置代替
    for i = 1:size(XSnew,1)
       if(deleteIndex(i) == 1)
           XSnew(i,:) = rand(1,dim).*(ub-lb)+lb;
       end
    end
    for i = 1:size(XS,1)
     fitnessS(i) = fobj(XSnew(i,:));
    end
    XSF = XSFnew;
    XS  = XSnew;
  [fitnessSF, indexSF]= sort(fitnessSF);%排序
 Xelite = XSF(indexSF(1),:);%sailfish 最优值
 [fitnessS, indexS]= sort(fitnessS);%排序
 Xinjured = XS(indexS(1),:);%sardines 最优值
 %根据适应度排序
 XSF = XSF(indexSF,:);
 XS = XS(indexS,:);
 
 
 
 %记录全局最优位置
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
 
   curve(t) = GBestF;
end


Best_pos = GBestX;
Best_score = curve(end);

Arry_Fitness(irun)=Best_score;
display(['Run num : ', num2str(irun)]);
display(['The best solution obtained by SFO is : ', num2str(Best_pos),10]);
display(['The best optimal value of the objective funciton found by SFO is : ', num2str(Best_score),10]);
display(sprintf('==============================='));
 end 
 Ave1=mean(Arry_Fitness);
Std1=std(Arry_Fitness);
 
end



