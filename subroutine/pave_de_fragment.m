function [pks,ct]=pave_de_fragment(M_CID,pks,option,settings)
ct=0;

error=option.error;
pvalue=option.pvalue;
a=option.dup;
b=option.cat;

for i=1:b
 V{i}=1:a;
 V{i}=V{i}+(i-1)*a;
end
%V=[{[1, 2, 3]},{[4, 5, 6]},{[7, 8, 9]}];


  
for i=1:length(pks)  
 if isempty(pks(i).feature) || settings.override==1
 %get signals from M_CID
     [~,intensity,~]=EIC(M_CID,pks(i),settings);
     sig(i,:)=log10(intensity+1);
 %/get signals from M_CID    
    for j=1:length(V)
        dt{j}=sig(i,V{j});  %get X, Y for ttest
    end
    p=1; %reset p
    for j=2:length(V)
        [t, tp]=ttest_m(dt{j},dt{1},log10(1+error)); %tp is calculated p value for V{j} vs V{1}
        if t>0 && tp<pvalue
         p=min(p,tp);
        end
    end
    
    if p<pvalue
     pks(i).pvalue=p;
     pks(i).feature='Fragment';
     ct=ct+1;
     fprintf([num2str(ct),'/',num2str(i),'\n']);
    else
     pks(i).pvalue=p;
    end
   % [i,ct]
 end
end
fprintf([num2str(ct),' fragments found','\n']);


function [t,p]=ttest_m(X,Y,varargin)
s_min=0;
if nargin>2
    s_min=varargin{1};
end
x=mean(X);
y=mean(Y);
sx=max(std(X),s_min);
sy=max(std(Y),s_min);
t=(x-y)/sqrt(sx^2/length(X)+sy^2/length(Y));
p=(1-(tcdf(abs(t),length(X)+length(Y)-2)))*2;



