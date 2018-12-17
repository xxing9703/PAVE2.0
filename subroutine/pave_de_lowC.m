function [pks,ct]=pave_de_lowC(M,pks,settings,rep,m)
C=1.00335;
ct=0; C_num=[];

for i=1:length(pks)
  if pks(i).C_num>0 && (isempty(pks(i).feature) || settings.override==1)
    pk=pks(i);
   [~,intensity1,~]=EIC(M(1:rep(1)),pk,settings);
    pk1=pk;
    pk1.mz=pk.mz+C;   
    tp=inlist(pk1,pks,settings);
   
    
   [~,intensity2,~]=EIC(M(1:rep(1)),pk1,settings);   
   score=peakshape(M(1),pk,pk1,settings);
   
   ratio=(intensity2./intensity1);   
   ratio=min(ratio);
   C_num(i)=round(ratio/0.0108);   
   
   if score<0.9
       C_num(i)=0;
   end
   
   if C_num(i)>pk.mz/14
       C_num(i)=0;
   end
   
   if C_num(i)>pks(i).C_num*(1+0.2) || (pks(i).mz>m(pks(i).C_num) && C_num(i)==0)
       ct=ct+1;
       fprintf(['low_C:',num2str(ct),'/',num2str(i),'\n'])
       pks(i).feature='low_C';       
   end

       
   
  
 end
end
