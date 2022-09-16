function ST = Stack (candidate,dim)
%双工：堆积力约束
dim=18;
stack=0;
% standard=(-5.13)*(dim-1);

for i=1:dim-1
    if candidate(1,i) == 0 && candidate(1,i+1) == 0
        stack=stack-7.37;
    elseif(candidate(1,i) == 0 && candidate(1,i+1) == 1)
         stack=stack-8.56;
    elseif candidate(1,i) == 1 && candidate(1,i+1) == 0
         stack=stack-8.56;
        else
        stack=stack-3.77;
    end
end
ST = stack;
% if stack <= standard
%     ST = 1;
% else
%     ST =0;
% end

  %A=0
  %G=1
  %C=2
  %T=3