%第三条链：xyxy不连续
function Discontinuous = Discontinuous2(DNASet) 
 Discontinuous=0;
for p = 1:size(DNASet,2)-3
   
         if DNASet(p) == DNASet(p+2) && DNASet(p+1) == DNASet(p+3)
             Discontinuous=1;
             break;
         end
     
 end
