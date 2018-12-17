function [pks,idx]=pave_find_formula(pks,settings)
%H=1.0078;  %this should be H+e-
H=1.00728;
idx=[];
for i=1:length(pks)
    if isempty(pks(i).feature) || settings.override==1
      output=mass2formula_CN(pks(i).mz, pks(i).C_num, pks(i).N_num, settings.mz_tol*1e6,settings.mode);
      if ~isempty(output)
          pks(i).formula=output{1,1};
          idx=[idx,i];
          if size(output,1)>1
              pks(i).formula2=output{2,1};
          else
              pks(i).formula2=[];
          end
      else 
          pks(i).formula2=[];          
      end
    end
    if settings.verbose==1
     fprintf(['formula:',num2str(length(idx)),'/',num2str(i),'\n']);
    end
end