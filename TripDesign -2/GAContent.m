%双工：GC、占比40-60%%
function  flag = GAContent(candidate)
[px,py] = size(candidate);
dim=18;
count = 0;
for i = 1:py
    if candidate(1,i) == 1 
           count = count + 1;
    end
end
% if  count>=4 && count<= 6
%  if  count==(py/2)
% if  count>7 && count<10
if count/dim >=0.4 &&   count/dim <=0.6

% if  count==10
    flag = 1;
else
    flag =0;

end
  %A=0
  %G=1
  %C=2
  %T=3
