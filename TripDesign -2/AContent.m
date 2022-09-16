%双工设计
function  flag = AContent(candidate)
py = size(candidate,2);
count = 0;
for i = 1:py
    if candidate(i) ==0 
           count = count + 1;
    end
end
if count >0
    flag = 1;
else
    flag =0;
   
end
  %A=0
  %G=1
  %C=2
  %T=3
