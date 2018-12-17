function [pks,idx]=pave_junkremover(M,pks,settings,rep,adduct)
idx=[];
for i=1:length(adduct)
  [pks,id,~] = pave_find_adduct(M,pks,settings,rep,adduct(i)); % -junkremover
  idx=[idx,id];
end

[pks,id,~]=pave_find_dimer(M,pks,settings,rep);
idx=[idx,id];


%settings.rt_tol=0.3;
% Alert: code below is to find the peak ID of the parent, which is not
% a scalable approach
if ~isempty(idx)
 for i=1:length(pks)
    if(~isempty(pks(i).description))
     id=inlist(pks(i).parent,pks,settings);
     if id>0
      pks(i).parentID=pks(id).id;
     else
      pks(i).parentID=0;
     end
    end    
 end
end

%-----------------------------------
% for i=1:length(adduct)
%     if strcmp(adduct(i).feature,'Adduct')
%       pks_final=pave2_find_adduct_pola(M,M2,pks,settings,rep,adduct(i),-1);
%     end
% end
