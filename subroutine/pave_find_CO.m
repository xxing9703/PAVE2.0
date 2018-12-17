function [pks,count]=pave_find_CO(pks,settings)
CO = 27.9949;
pks_good=[pks_subset(pks,'feature',[]);pks_subset(pks,'feature','Metabolite')]; 

count=0;idx=[];idx2=[];
for i=1:length(pks)
    if isempty(pks(i).feature) || settings.override==1
    for j=1:length(pks_good)
      if abs(pks(i).mz-pks_good(j).mz-CO)<settings.mz_tol*pks_good(j).mz...
              && pks(i).C_num==pks_good(j).C_num...
              && pks(i).N_num==pks_good(j).N_num...
              && pks(i).C_num>0
          count=count+1;
                  
          pks(i).feature='CO_reaction';
          pks(i).parent=pks(j);
          
          
          fprintf(['find_CO:',num2str(count),'/',num2str(i),'\n']);
          break
      end
    end
    end
end