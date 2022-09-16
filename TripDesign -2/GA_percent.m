%双工：GC、AT占比50%
function  flag = GA_percent(candidate)
[px,py] = size(candidate);
count = 0;
% TC=[2,3];
 AG=[1,0];
for i = 1:py    
    if candidate(1,i) == 1 ||candidate(1,i) == 0 
           count = count + 1;
    end
end
if count > floor(py/3.5)
    flag = 1;
else
    flag =0;
end

B=[0,0,1;0,1,0;0,1,1;1,0,0;1,0,1;1,1,0];
if flag==1
    flag=1;
else

for i = 1:py -2
    
    A=[candidate(1,i),candidate(1,i+1),candidate(1,i+2)];
for j=1:size(B,1)
    if A==B(j,:)
        flag=1;
        break;
    else
        flag=0;
    end
end

  if flag ==1
  break;
  end
end
end

  %A=0
  %G=1
  %C=2
  %T=3
