%This function determines if a pk is found in the list of pks within tolerance 
%return the index if found, else return 0
function idx=inlist(pk,pks,settings)
idx=0;
mz=pk.mz;
rt=pk.rt;
mz_tol=settings.mz_tol;
rt_tol=settings.rt_tol;

for i=1:length(pks)
    dm=mz-pks(i).mz;
    dt=rt-pks(i).rt;
    if abs(dm)<mz*mz_tol && abs(dt)<rt_tol
        idx=i;
        return
    end  
end

