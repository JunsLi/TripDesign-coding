%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This function initialize the first population 
function X=InitDNASet(nP,dim,ub,lb)
Boundary_no= size(ub,2); % numnber of boundaries

% If the boundaries of all variables are equal and user enter a signle
% number for both ub and lb

if Boundary_no==1
  DNASet=round(rand(nP,dim).*(ub-lb))+lb;
end

% If each variable has a different lb and ub
if Boundary_no>1
    for i=1:dim
      DNASet(:,i)=round(rand(nP,1).*(ub(i)-lb(i)))+lb(i);
    end
end
for i=1:size(DNASet,1)
        % Check if solutions go outside the search space and bring them back
        Flag4ub=DNASet(i,:)>ub;
        Flag4lb=DNASet(i,:)<lb;
        DNASet(i,:)=(DNASet(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;       
end
%%保证相邻数字不一样
 for p = 1:size(DNASet,1)
     for q = 1:size(DNASet,2)-1
         if DNASet(p,q) == DNASet(p,q+1)
             del_idx(p,:) = p;
         end
     end
 end
 del_idx(del_idx(:,end)==0) = [];
 DNASet(del_idx,:) = [];
DNASet = unique(DNASet,'rows','stable');
px = size(DNASet,1);
index = 1;
temp=[];
for q = 1:px
    if   GCContent(DNASet(q,:))~=1
        temp(index) =q;
        index = index + 1;
    end
end
if length(temp)~=0
    DNASet(temp,:)=[];
end
X = DNASet;