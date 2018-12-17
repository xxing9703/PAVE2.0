function [pks,idx]=pave_find_artifact(M,pks,settings,rep)
idx=[];
rt_tol=settings.rt_tol;
count=0; ppm=500*1e-6;
for i=1:length(pks)
    if isempty(pks(i).feature) || settings.override==1
          spectra= MS(M(1:rep(1)),pks(i),settings);
            [~,myid]=min(abs(spectra{1}(:,1)-pks(i).mz));
            id=find(abs(spectra{1}(:,1)-pks(i).mz)<pks(i).mz*ppm);
            
            mysig=spectra{1}(myid,2);
            top=max(spectra{1}(id,2));
            
     if top/mysig>100
           
           count=count+1;
           idx=[idx,i];
           pks(i).feature='Artifact';
           
         
     end      
   
    if settings.verbose==1
        fprintf(['find_artifact:',num2str(count),'/',num2str(i),'\n']);
    end
   end
end
% 
% for i=1:length(idx)
%    pks(idx(i)).feature2='Artifacts';
% end
