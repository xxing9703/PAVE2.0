% use this function to index a subset of peaks that meet certain criteria
% usage: pp=pks_subset(pks, Name,Value) see examples below
% pp=pks_subset(pks, 'feature','Metabolite')
% pp=pks_subset(pks, 'feature',[])
% pp=pks_subset(pks, 'mz',[low, high])  %find mass within bounds
% pp=pks_subset(pks, 'mz',mass)  % ***find mz at mass within 10ppm***
% pp=pks_subset(pks, 'rt',[low, high])  %find rt within bounds
% pp=pks_subset(pks, 'rt',rt)  %***find RT at rt within 0.1***
% pp=pks_subset(pks, 'C_num',[2,3],'N_num',0)  %find CN with range


function pp=pks_subset(pks,varargin)
ct=nargin;pp=pks;
ppm=10;ppm=ppm/1e6;

if ct<2 || mod(ct,2)==0
    fprintf('error: not enough inputs')
    return
end

for i=1:(ct-1)/2
    name=varargin{i*2-1};
    if ~isfield(pks,name)
        return
    end
    value=varargin{i*2};
    
    if strcmpi(name,'feature')|| strcmpi(name,'description')||strcmpi(name,'formula')
       if isempty(value)
         pp=pp(cellfun(@isempty,{pp.(name)}));
       else
         pp=pp(strcmp({pp.(name)},value));
       end
 
       
    elseif strcmp(name,'mz')
        if length(value)>1
            pp=pp([pp.mz]>=value(1));
            pp=pp([pp.mz]<=value(2));
        else
            pp=pp([pp.mz]>=value(1)*(1-ppm));
            pp=pp([pp.mz]<=value(1)*(1+ppm));
        end
           
        
    elseif strcmp(name,'rt')
        if length(value)>1
            pp=pp([pp.rt]>=value(1));
            pp=pp([pp.rt]<=value(2));
        else
            pp=pp([pp.rt]>=value(1)-0.1);
            pp=pp([pp.rt]<=value(1)+0.1);
        end

            
    elseif strcmpi(name,'C_num') || strcmpi(name,'N_num')|| strcmpi(name,'id') ...
            || strcmpi(name,'score')|| strcmpi(name,'sig')|| strcmpi(name,'fragment')
         if length(value)>1
             pp=pp([pp.(name)]>=value(1));
             pp=pp([pp.(name)]<=value(2));
         else
             pp=pp([pp.(name)]==value(1));
         end
         
     
    end
    
end
    
 
end
