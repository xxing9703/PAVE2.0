function stat=pave_stat(pks,category)
if isfield(pks,category)   
 if strcmp(category,'feature')
   [cats,~,J]=unique({pks.feature});
   occ = histc(J, 1:numel(cats));
   stat=[cats',num2cell(occ)];
 elseif strcmp(category,'description')
    tp=pks(find(~cellfun(@isempty,{pks.description})));
   [cats, ~, J]=unique({tp.description});
   occ = histc(J, 1:numel(cats));
   stat=[cats',num2cell(occ)];  
 end
else
   stat=[];
end
