%need to input adduct structure.
%M1 is the current mode, M2 is the opposite mode. pola=1 is M1 is posi
%one adduct at a time.
function [pks,idx1]=pave_find_adductNP(M1,M2,pks,settings,rep,adduct)
pola=settings.mode;
H=1.007276;
dm=adduct.diff+2*H*pola;
idx1=[];idx2=[];
factor_lb=1; factor_ub=1;
count=0;c1=0;c2=0;
for num=1:length(pks)
    pk1=pks(num);
    if isempty(pk1.feature) || settings.override==1 
    % if ~strcmp(pk1.feature,'Background')&& ~strcmp(pk1.feature,'Adduct')&&~strcmp(pk1.feature,'Adduct') %do it if it's not a background
    %if strcmp(pk1.feature,'Metabolite')
    count=count+1;     
     mz1=pk1.mz;
     mz2=mz1-dm;
     pk2.mz=mz2;
     pk2.rt=pk1.rt;
     
     
   % read signal
    if isempty(pk1.sig)
        [~,I,~]=EIC(M1(1:rep(1)),pk1,settings);
        sig1=log10(max(I)+1);
        pk1.sig=sig1;
    else
        sig1=pk1.sig;
    end
    
    % read signal2
    [~,I,~]=EIC(M2(1:rep(1)),pk2,settings);
    sig2=log10(max(I)+1);  
    
    % ratio
    ratio=10^(sig2-sig1);   
    
    if strcmp(adduct.name,'13C')||strcmp(adduct.name,'13C++')
        n=(mz1-dm)/12;  
        factor_lb=1/(n*0.0107*(1-0.0107)^(n-1));
    elseif strcmp(adduct.name,'15N')
        n=min((mz1-dm)/15,10);  
        factor_lb=1/(n*0.00364*(1-0.00364)^(n-1));
    elseif strcmp(adduct.name,'18O')||strcmp(adduct.name,'18O++')
        n=min((mz1-dm)/18,30);  
        factor_lb=1/(n*0.00205*(1-0.00205)^(n-1));
    elseif strcmp(adduct.name,'34S')
        n=min((mz1-dm)/32,10);  
        factor_lb=1/(n*0.0429*(1-0.0429)^(n-1));
    elseif strcmp(adduct.name,'37Cl')
        n=min((mz1-dm)/35,5);  
        factor_lb=1/(n*0.24*(1-0.24)^(n-1));
    end
    
    min_ratio=adduct.I_lb*factor_lb;
    max_ratio=adduct.I_ub*factor_ub;
    
    if ratio>min_ratio && ratio<max_ratio % intensity ratio in bound
        c1=c1+1;
        
        pk2=pave_atomcount(M2,pk2,settings,rep); %find C/N number of putative parent
        dC=pk2.C_num-pk1.C_num;
        dN=pk2.N_num-pk1.N_num;
        
        
       if dC>=adduct.C_lb && dC<=adduct.C_ub && dN>=adduct.N_lb && dN<=adduct.N_ub... %C N match
               && pk2.C_num>0 %parent must be a good peak with C>0
        c2=c2+1;
        pks(num).feature='Adduct_np'; %assign feature
        pks(num).description=adduct.name; %assign adduct name
        pks(num).parent=pk2;   %store parent info
        
        idx1=[idx1,num];  %idx1 is the idx of identified adducts
        
                
      end
    end
     if settings.verbose==1
       fprintf(['iso/adduct:',adduct.name,' -- ',num2str(c2),'/',num2str(c1),'/',num2str(count),'\n']);
     end
    end
    
end

