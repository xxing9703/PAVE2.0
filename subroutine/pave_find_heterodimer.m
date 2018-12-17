function [pks,count]=pave_find_heterodimer(pks,settings)

%find good pks pool
pks_good=[pks_subset(pks,'feature',[]);pks_subset(pks,'feature','Metabolite')]; 

H=1.007276;
pola=settings.mode;

count=0;
for i=1:length(pks)
   if isempty(pks(i).feature)||(settings.override==1&& pks(i).C_num>0)  
    pk_C=pks(i);    %pk_C is current pk
    pks_tp=pks_good((abs([pks_good.rt]-pk_C.rt)<settings.rt_tol));
    pks_tp=pks_tp(([pks_tp.mz]<pk_C.mz));
    pks_tp=pks_tp(([pks_tp.C_num]<pk_C.C_num));  %restrict the searching range
    found=0;
    for j=1:length(pks_tp)
       pk_A=pks_tp(j);
        for k=1:length(pks_tp)
            pk_B=pks_tp(k);
            if abs(pk_C.mz-pk_B.mz-pk_A.mz+H*pola)<settings.ppm*pk_C.mz
                if pk_C.C_num==pk_A.C_num+pk_B.C_num && pk_C.N_num==pk_A.N_num+pk_B.N_num
                    if pk_C.sig<pk_A.sig && pk_C.sig<pk_B.sig
                        count=count+1;
                        pks(i).feature='Heterodimer';
                        pks(i).parent = pk_A;
                        pks(i).parentID = pk_A.id;  
                        fprintf([num2str(count),'/',num2str(i),'\n']);
                        found=1;
                        break;
                    end
                end
            end
        end
        if found==1
            break;
        end
       
    end
    end
end
