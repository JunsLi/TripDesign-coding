
function  flag = CTC_TCTcontent (candidate)
py = size(candidate,2);
count = 0;
for i = 1:py-3
    
    if candidate(i) ==2 && candidate(i+1)==3 && candidate(i+2)==2 && candidate(i+3)==3
           count = count +1;
           break;
    elseif candidate(i) ==3 && candidate(i+1)==2 && candidate(i+2)==3  && candidate(i+3)==2
               count = count +1;
               break;
    end
end

if count>0
    flag = 1;
else
    flag =0;
   
end
  %A=0
  %G=1
  %C=2
  %T=3
%%Torsional stress    CTC_TCTcontent
