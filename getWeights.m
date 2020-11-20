function N = getWeights()

N=zeros(101);
for i=0:20
N(101-i,101-i)=100;
end

N=eye(101);
end

