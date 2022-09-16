function [Sd6,Ave6,Convergence_curve6]=DE(nP,Max_It,lb,ub,dim,fobj,F,Cr,Run_no)
tic
for irun=1:Run_no

%% Initialization
Convergence_curve6=zeros(Max_It,1);

X=zeros(nP,dim);
Cost=zeros(nP,1);

for i=1:nP
    
    X(i,:)=unifrnd(lb,ub,1,dim);
    Cost(i)=fobj(X(i,:));
        
end

[Best_Cost,ind] = min(Cost);
Best_X = X(ind,:);

%% Main Loop

for it=1:Max_It    
    
    for i=1:nP
                
        Rand_ind=randperm(nP);
        
        Rand_ind(Rand_ind==i)=[];
        
        a = Rand_ind(1);
        b = Rand_ind(2);
        c = Rand_ind(3);

        % Mutation
        y = X(a,:)+F.*(X(b,:)-X(c,:));

        % Crossover
        z=zeros(1,dim);
        j0=randi([1 dim]);
        for j=1:dim
            if j==j0 || rand<=Cr
                z(j)=y(j);
            else
                z(j)=X(i,j);
            end
        end
        
        New_X = min(max(z,lb),ub);
        New_Cost = fobj(New_X);

        if New_Cost<Cost(i)
            X(i,:) = New_X;
            Cost(i) = New_Cost;            
            if Cost(i)<Best_Cost
               Best_X = X(i,:);
               Best_Cost = Cost(i);
            end
        end
        
    end

    Convergence_curve6(it)=Best_Cost;
    Ceqfit_run(irun)=Best_Cost;
end
display(['Run no : ', num2str(irun)]);
display(['The best solution obtained by DE is : ', num2str(Best_Cost,10)]);
display(['The best optimal value of the objective funciton found by DE is : ', num2str(Best_Cost,10)]);
disp(sprintf('--------------------------------------'));  
end
%输出迭代最优值

Ave6=mean(Ceqfit_run);
Sd6=std(Ceqfit_run);
time=toc;
    % Show Information
   % disp(['Iteration ' num2str(it) ': BestCost = ' num2str(Convergence_curve(it))]);
    
    



