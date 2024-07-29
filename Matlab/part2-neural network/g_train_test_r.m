function [train test]=g_train_test_r(c,n)
[a b]=size(c);
ntrain=ceil(n*a);
ntest=a-ntrain;
k=randperm(a);

for i=1:ntrain
    train(i,:)=c(k(1,i),:);
end

for i=1:ntest
    test(i,:)=c(k(1,i+ntrain),:);
end

    
    
