function [train test]=G_train_test_multiclass(data,n)
class=9;
for i=1:class
    temp=find(data(:,end-1)==i);
    if i==1
        C1=data(temp,:);
    elseif i==2
        C2=data(temp,:);
        elseif i==3
        C3=data(temp,:);
        elseif i==4
        C4=data(temp,:);
        elseif i==5
        C5=data(temp,:);
        elseif i==6
        C6=data(temp,:);
        elseif i==7
        C7=data(temp,:);
        elseif i==8
        C8=data(temp,:);
        elseif i==9
        C9=data(temp,:);
    end
end

[train1 test1]=g_train_test_r(C1,n);
[train2 test2]=g_train_test_r(C2,n);
[train3 test3]=g_train_test_r(C3,n);
[train4 test4]=g_train_test_r(C4,n);
[train5 test5]=g_train_test_r(C5,n);
[train6 test6]=g_train_test_r(C6,n);
[train7 test7]=g_train_test_r(C7,n);
[train8 test8]=g_train_test_r(C8,n);
[train9 test9]=g_train_test_r(C9,n);


train=[train1;train2;train3;train4;train5;train6;train7;train8;train9];
test=[test1;test2;test3;test4;test5;test6;test7;test8;test9];

train=random_data(train);
test=random_data(test);
