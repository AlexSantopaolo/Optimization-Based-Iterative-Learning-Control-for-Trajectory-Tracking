function [Fcontr,d_estimated_contr] = get_Fd_contr(F,d_estimated)
N=size(F,2);
Fcontr=F;
d_estimated_contr=d_estimated;
c_list=[];
for i=1:N
    %c_list=[c_list i*4-3];
    c_list=[c_list i*4-3+1];
    c_list=[c_list i*4-3+3];
end

J=length(c_list);
for j=J:-1:1
    Fcontr(c_list(j),:)=[];
end

for j=J:-1:1
    d_estimated_contr(c_list(j))=[];
end


end

