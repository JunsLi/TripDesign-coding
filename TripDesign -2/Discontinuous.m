%整体：四个碱基不连续
function Discontinuous = Discontinuous(DNASet) 

for p = 4:size(DNASet,2)
   
         if DNASet(p-2) == DNASet(p) && DNASet(p-1) == DNASet(p)&& DNASet(p-3) == DNASet(p)
%             if DNASet(p-2) == DNASet(p) && DNASet(p-1) == DNASet(p)
             Discontinuous=1;
             break;
             
         else
             Discontinuous=0;
         end
     
 end
