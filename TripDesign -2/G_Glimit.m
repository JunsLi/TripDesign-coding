%第三条链的起始都是C
function  flag = G_Glimit(candidate,dim)
dim=18; 
py = size(candidate,2);
count = 0;

    if candidate(1) ==1 && candidate(dim) ==1
%     if  candidate(1) ==1 
           count = count + 1;
    end

if count >0
    flag = 1;
else
    flag =0;
end
   
