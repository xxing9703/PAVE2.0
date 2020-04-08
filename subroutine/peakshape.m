%find the peakshape similarities between pks(id1) and pks(id2)
%M is the raw data, it only takes and compares the first spectrum
function [coef,spec1,spec2]=peakshape(M,pk1,pk2,settings)
unit=0.01; shiftaround=9;
[spec1,~,~]=EIC(M,pk1,settings);
[spec2,~,~]=EIC(M,pk2,settings);
spec1=spec1{1};
spec2=spec2{1};

spec1=spec1(:,[1,3]);
spec2=spec2(:,[1,3]);
coef=-1;
for i=1:shiftaround
 offset=(i-(shiftaround+1)/2)*unit;
 spec2(:,1)=spec2(:,1)+offset;%shift
 
lb=max(spec1(1,1),spec2(1,1));
ub=min(spec1(end,1),spec2(end,1));
sz=min(size(spec1,1),size(spec2,1));
step=(ub-lb)/sz;

if lb<ub
vq1 = interp1(spec1(:,1),spec1(:,2),lb:unit:ub);
vq2 = interp1(spec2(:,1),spec2(:,2),lb:unit:ub);
corr=corrcoef(vq1,vq2);
coef=max(coef,corr(1,2));
else
    coef=-1;
end

spec2(:,1)=spec2(:,1)-offset; %recover
end




