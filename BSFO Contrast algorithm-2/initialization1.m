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

% This function initialize the first population of search agents
function Positions=initialization1(SearchAgents_no,dim,ub,lb)

Boundary_no= size(ub,2); % numnber of boundaries

% If the boundaries of all variables are equal and user enter a signle
% number for both ub and lb
if Boundary_no==1
     Positions=rand(SearchAgents_no,dim).*(ub-lb)+lb;
end

% If each variable has a different lb and ub
if Boundary_no>1
    for i=1:dim
        ub_i=ub(i);
        lb_i=lb(i);
         Positions(:,i)=rand(SearchAgents_no,1).*(ub_i-lb_i)+lb_i; 
         
    end
    for j= size(Positions,1)
        for n=size(Positions,2)
          Positions1(j,n)=lb+ub-Positions(j,n);
         C1=((lb+ub)/2);
         if Positions1(j,n)<C1
           Positions2(j,n)= C1+(Positions1(j,n)-C1)*rand();
         else
             Positions2(j,n)= Positions1(j,n)+(C1-Positions1(j,n))*rand();  
         end  
%         lb1=lb(1,1)*ones(1,dim);
%         ub1=ub(1,1)*ones(1,dim);
%         m=chaos(6,1,1);
%         Positions1(j,:)=lb1+ub1- Positions(j,:).*m;
        end
    end
    Positions=[Positions;Positions2];

         for m=1:size(Positions,1)
% % %         % Check boundries
          
           fitness(1,m)=fobj( Positions(m,:));
         end
         [~,index]=sort(fitness);
          Positions3= Positions(index,:);
          Positions= Positions3(1:SearchAgents_no,:);
     
    
 end