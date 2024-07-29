%main_neural network
clear all
clc
close all
% 
% load('New_feature.mat')
% data=NFV(:,1:end-2);
% %% principal component analysis
% [pc,score,latent] = princomp(data);
% D=cumsum(latent)./sum(latent);
% num=20
% Data=[score(:,1:num),NFV(:,end-1:end)];
load('newPCA.mat')
percent=0.6;
[traind testd]=G_train_test_multiclass(Data,percent);


%% design neural network

%initial NN
train_da=random_data(traind);
test_da=random_data(testd);
Xi=train_da(:,1:end-2)';
de_out=train_da(:,end-1)';

X_test=test_da(:,1:end-2)';
Y_test=test_da(:,end-1)';
%%%
Target=full(ind2vec(de_out));
T_test=full(ind2vec(Y_test));
%
%%
inputs = Xi;
targets = Target;

% Create a Pattern Recognition Network
hiddenLayerSize = 40;
net = patternnet(hiddenLayerSize);


% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;


% Train the Network
[net,tr] = train(net,inputs,targets);

% Test the Network by training data
outputs = net(inputs);
S=size(outputs);
for i=1: S(2)
    temp=outputs(:,i);
    M=max(temp);
    f=find(temp==M);
    temp=zeros(9,1);
    temp(f,1)=1;
    outputs(:,i)=temp;
end

errors = gsubtract(targets,outputs);
S_E=sum(abs(errors));
C=find(S_E==0);
correctt=(length(C)/length(S_E))*100

% Test the Network by testing data
outputs = net(X_test);
S=size(Y_test);
for i=1: S(2)
    temp=outputs(:,i);
    M=max(temp);
    f=find(temp==M);
    temp=zeros(9,1);
    temp(f,1)=1;
    outputs(:,i)=temp;
end

errors = gsubtract(T_test,outputs);
S_E=sum(abs(errors));
C=find(S_E==0);
correct_test=(length(C)/length(S_E))*100


%% testing by image
I=imread('Im (609).jpg');
num_image=609;% [please enter number of image in dataset for search its feature
select=find(Data(:,end)==num_image);
y=net(Data(select,1:end-2)');
M=max(y);
class=find(y==M);
T=Data(select,end-1);
error=class-T;
B=Generate_patch(I,3,3);

RGB = insertShape(I,'FilledRectangle',B(class,:));
figure, imshow(RGB), title('gaze detection');
display('Error is')
error
display('detected class is: ')
class

