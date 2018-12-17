function spectra=MS(M,pk,settings)

num_file=length(M);
spectra=cell(num_file,1);
intensity=zeros(num_file,1);
rt=zeros(num_file,1);
for j=1:num_file
    rt_array=cell2mat(M(j).data(:,1));
    [~, index] = min(abs(rt_array-pk.rt));    
    sig=[];
    sig(:,1)=cell2mat(M(j).data(index,2));
    sig(:,2)=cell2mat(M(j).data(index,3));
    spectra{j}=sig;  
end