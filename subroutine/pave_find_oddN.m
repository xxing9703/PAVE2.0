function [pks,idx]=pave_find_oddN(pks,settings)
count=0;idx=[];

for i=1:length(pks)
mz=pks(i).mz;
N_num=pks(i).N_num;
C_num=pks(i).C_num;
  
if C_num>0 && mod(N_num,2)==mod(floor(mz+0.2),2)
    if isempty(pks(i).feature)||settings.override==1
        pks(i).feature='Odd_N';
        count=count+1;
        idx=[idx,i];
    end
    
end

    if settings.verbose==1
          fprintf(['find_Odd_N:',num2str(count),'/',num2str(i),'\n']);
    end
end