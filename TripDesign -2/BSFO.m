
function [GBestX,GBestF,curve,DNASet]=BSFO(pop,Max_iter,lb,ub,dim)
E = 4;
e = 0.001;
P=0.5;
dim=18;
nV=dim;
% H_target = 7;
% SFpercent = 0.3;
% % Run_no=30;
SFNumber = round(pop*0.3);
SNumber = pop - SFNumber;
%  for irun=1:Run_no
   ub = ub.*ones(1,dim);
   lb = lb.*ones(1,dim);  

%种群初始化
XSF = initialization0(SFNumber,nV,ub,lb);%sailfish Initialize the Sailfish random solution set
XS = initialization1(SNumber,nV,ub,lb);%sardines Initialize the sardine random solution set

X1=XSF(:,1:dim);
X2=XS(:,1:dim);
X3=XSF(:,2*dim+1:3*dim);
X4=XS(:,2*dim+1:3*dim);

SFfitness = zeros(size(XSF,1),1);
Sfitness = zeros(size(XS,1),1);

curve=zeros(1,Max_iter);

GBestF = 0;  % Determine the vale of Best Fitness

Best_XSF = zeros(1,dim);  % Determine the vale of SF Best Fitness
Best_XS = zeros(1,dim); % Determine the vale of S Best Fitness
NewDNA=[];

standard=(-7.065)*(dim-1);
 %========================================================   
 tic
  for t = 1: Max_iter
      NewDNA1=[];
      NewDNA2=[];
    %======================================================
     for i=1:size(XSF,1)

        SFfitness(i)=Stack(X1(i,:));
     end
        %Elitism
         [B,min_index] = min(SFfitness);
           SFBestF=B;
           Best_XSF= X1(min_index,:);%Pick out the best particles and their fitness functions
           NewDNA1=[];
     for i=1:size(XSF,1)
        if SFfitness(i)<=standard
            NewDNA1=[XSF(i,:);NewDNA1];
        end
     end  
%===================================
%   Add end constraint 
if size(NewDNA1,1)==0
    NewDNA1=[];
else
x = size(NewDNA1,1);
index = 1;
temp=[];
Xx1=NewDNA1(:,1:dim);
for q = 1:x
    if  G_Glimit(Xx1(q,:))==0
        temp(index) =q;
        index = index + 1;
    end
end
if length(temp)~=0
   NewDNA1(temp,:)=[];
end
end
%===========================================
% Add stacking constraint
if size(NewDNA1,1)==0
    NewDNA1=[];
else
pxx = size(NewDNA1,1);
index3=1;
temp=[];
XX1=NewDNA1(:,1:dim);
for q = 1:pxx
    if   Stack(XX1(q,:))>standard
        temp(index3) =q;
        index3 = index3 + 1;
    end
end
if length(temp)~=0
    NewDNA1(temp,:)=[];
end
end    
%============================================================    
%Add torsional stress constraint
if size(NewDNA1,1)==0
    NewDNA1=[];
else
x5 = size(NewDNA1,1);
index = 1;
temp=[];
XX3=NewDNA1(:,2*dim+1:3*dim);
for q = 1:x5
    if  CTC_TCTcontent(XX3(q,:))==1
        temp(index) =q;
        index = index + 1;
    end
end
if length(temp)~=0
   NewDNA1(temp,:)=[];
end   
end
% 
% % ===========================================    
%   %G-4motif free constraint 
 if size(NewDNA1,1)==0
    NewDNA1=[];
else
x = size(NewDNA1,1);
index = 1;
temp=[];
Xxn=NewDNA1(:,1:dim);
for q = 1:x
    if  G4(Xxn(q,:))==0
        temp(index) =q;
        index = index + 1;
    end
end
if length(temp)~=0
   NewDNA1(temp,:)=[];
end   
 end
% %================================
  NewDNA=[NewDNA;NewDNA1];
 %============================================================       
          for i=1:size(XS,1)
        %Calculate the inflation rate (fitness) of universes
%        A=find(RCHammingDist2(i,:)>=H_target);
       Sfitness(i)=Stack(X2(i,:));
         end
        %Elitism
         [B2,min_index2] = min(Sfitness);
           SBestF=B2;
           Best_XS= X2(min_index2,:);%Pick out the best particles and their fitness functions

           NewDNA2=[];
     for i=1:size(XS,1)
        %Calculate the inflation rate (fitness) of universes
%         AA=RCHamming(X4(i,:),Best_XS);
        if Sfitness(i)>=standard
            NewDNA2=[XS(i,:);NewDNA2];
        end
     end
     %============================================================================        
 if size(NewDNA2,1)==0
    NewDNA2=[];
 else
xx = size(NewDNA2,1);
index = 1;
temp=[];
Xx2=NewDNA2(:,1:dim);
for q = 1:xx
    if   G_Glimit(Xx2(q,:))==0
        temp(index) =q;
        index = index + 1;
    end
end
if length(temp)~=0
   NewDNA2(temp,:)=[];
end
 end
%============================================================
if size(NewDNA2,1)==0
    NewDNA2=[];
else
pxxx = size(NewDNA2,1);
index3=1;
temp=[];
XX2=NewDNA2(:,1:dim);
for q = 1:pxxx
    if   Stack(XX2(q,:))>standard
        temp(index3) =q;
        index3 = index3 + 1;
    end
end
if ~isempty(temp)
    NewDNA2(temp,:)=[];
end
end    
 %===============================================
 %%Add torsional stress constraint
if size(NewDNA2,1)==0
    NewDNA2=[];
else
x6 = size(NewDNA2,1);
index = 1;
temp=[];
XX4=NewDNA2(:,2*dim+1:3*dim);
for q = 1:x6
    if  CTC_TCTcontent(XX4(q,:))==1
        temp(index) =q;
        index = index + 1;
    end
end
if length(temp)~=0
   NewDNA2(temp,:)=[];
end  
    end
% ===========================================    
  %Add G-4motif free constraint  
 if size(NewDNA2,1)==0
    NewDNA2=[];
else
x = size(NewDNA2,1);
index = 1;
temp=[];
Xxn=NewDNA2(:,1:dim);
for q = 1:x
    if  G4(Xxn(q,:))==0
        temp(index) =q;
        index = index + 1;
    end
end
if length(temp)~=0
   NewDNA2(temp,:)=[];
end   
 end
% %======================================================
        NewDNA=[NewDNA;NewDNA2];
        NewDNA = unique( NewDNA,'rows','stable');
  %-----------------------------------------------------------------------------   
   %% Renew XSF
      AP = E*sqrt(1-(2*t*e));
    PD = 1 - (size(XSF,1)/(size(XSF,1) + size(XS,1)));
    lamda = 2*rand()*PD - PD;

       Elite1=repmat(Best_XSF,size(X1,1),1);  
       RB=randn(size(X1,1),dim); 
       Elite2=repmat(Best_XS,size(X2,1),1); 
 
       CF=(1-t/Max_iter)^(2*t/Max_iter);
   for i=1:size(XSF,1)     
       R=rand();
          %------------------ Brownian motion------------------- 
        if AP>=0.5
          stepsize(i,:)=RB(i,dim).*(Elite1(i,dim)-RB(i,dim).*X1(i,:));   
          X1(i,:)=Elite1(i,:)+P*R*stepsize(i,:);
       else
          X1(i,:) =  Best_XSF - lamda.*(rand().*((Best_XSF +Best_XS)./2)-X1(i,:));
       end
%      end
   end  
    X1=round(X1);
    %越界处理
    AX= initialization0(SNumber,nV,ub,lb);
    Ax=AX(:,1:dim);
     i=min(size(X1,1),size(AX,1));
%     w=randperm(i,1);
   for j = 1:size(X1,1)
        w=randperm(i,1);
       for a = 1: dim
           if(X1(j,a)>ub(a))
               XSF(j,:) =AX(w,:);
               break;
           end
           if(X1(j,a)<lb(a))
               XSF(j,:) =AX(w,:);
               break;
           end
           if CTC_TCTcontent(X1(j,:))~=1
           XSF(j,:)=AX(w,:);
           break;
            end
       end
   end 

    for i=1:size(XSF,1)
        for j=1:dim
            if XSF(i,j)==0 &&  XSF(i,2*dim+j)~=3
                XSF(i,2*dim+j)=3;
            end
            if XSF(i,j)==1 && XSF(i,2*dim+j)~=2
               XSF(i,2*dim+j)=2;
            end
        end
    end

    RB1=randn(SNumber,dim); 
    for i=1:size(X2,1)
     for j=1:size(X2,2)        
       R=rand();
       
        if(AP<1)
            if AP<0.5                
        stepsize(i,:)=RB1(i,j)*(Elite2(i,j)-RB1(i,j)*X2(i,:));                    
            X2(i,:)=Elite2(i,:)+P*R*stepsize(i,:); 
            else
        alpha = max(round(size(X2,1)*AP),1);
        beta = max(round(dim*AP),1);
        indexRandom = randperm(size(X2,1),alpha);%随机选择alpha个鱼
        for i = 1:alpha
         X2(indexRandom(i),1:beta) = rand().*(Best_XSF(1:beta) - X2(indexRandom(i),1:beta) + AP);
        end
            end
           else   
         X2(i,:) = rand().*(Best_XSF - X2(i,:) + AP);     
        end
    end 
    end
     %========================================================
    X2=round(X2);
    %越界处理
    BX= initialization1(SNumber,nV,ub,lb);
    Bx=BX(:,1:dim);
   i=min(size(X2,1),size(BX,1));
     for j = 1:size(X2,1)
         r=randperm(i,1);
       for a = 1: dim
           if(X2(j,a)>ub(a))
               XS(j,:) =BX(r,:);
               break;
           end
           if(X2(j,a)<lb(a))
               XS(j,:) =BX(r,:);
               break;
           end
           if CTC_TCTcontent(X2(j,:))~=1
           XS(j,:)=BX(r,:);
           break;
           end
       end
    end 
%     XS(:,1:dim)=X2;
    for i=1:size(XS,1)
        for j=1:dim
            if XS(i,j)==0  && XS(i,2*dim+j)~=3
                XS(i,2*dim+j)=3;
            end
            if XS(i,j)==1   && XS(i,2*dim+j)~=2
               XS(i,2*dim+j)=2;
            end
        end
    end
%  %=========================================================================   
%=========================================================================   
        for i=1:size(X1,1)
            tDNA=[];
                tDNA=initialization0(SNumber,nV,ub,lb);
                
            if Discontinuous(X1(i,:))==1 || CTC_TCTcontent(X1(i,:))==1
                XSF(i,:)=tDNA(1,:); 
            end
        end 
        for i=1:size(X2,1)
%              tDNA=[];
                tDNA=initialization1(SNumber,nV,ub,lb);
                
            if Discontinuous(X2(i,:))==1  || CTC_TCTcontent(X2(i,:))==1 
                XS(i,:)=tDNA(1,:);
            end
        end 
    X1=XSF(:,1:dim);
    X2=XS(:,1:dim);   
    X3=XSF(:,2*dim+1:3*dim);
    X4=XS(:,2*dim+1:3*dim);     
   DNASet = unique( NewDNA,'rows','stable');
    
    fprintf('进化第%d代, DNASet的大小为%d\n',t,size( DNASet,1));
%    if t==499
%        t=t+1;
%    end
   
 toc
    end





