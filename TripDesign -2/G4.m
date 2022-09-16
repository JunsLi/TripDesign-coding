

function  flag = G4(candidate)
[px,py] = size(candidate);
j=1;
count = 0;
p = 0;
q = 0;
for i = 1:py-1
    
    if candidate(1,i) == 1 && candidate(1,i+1) ==1
           p = p + 1;
    end
    
    
end
for i = 1:py-2
    if candidate(1,i) == 1 && candidate(1,i+1) ==1 && candidate(1,i+2) ==1
           q = q + 1;
    end
 end

 m=p-q;
for i = 1:py
    if candidate(1,i) == 1 
           count = count + 1;
    end
end

if  count> 7&& m>3
    flag = 0;
else
    flag =1;

end
  %A=0
  %G=1
  %C=2
  %T=3
