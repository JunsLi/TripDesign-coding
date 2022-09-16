%双工设计
function  flag = GCContent(candidate)
py = size(candidate);
count = 0;
for i = 1:py
    if candidate(1,i) == 1 || candidate(1,i) == 2
           count = count + 1;
    end
end
if count == floor(py/2)
    flag = 1;
else
    flag =0;
   
end
  %A=0
  %G=1
  %C=2
  %T=3
