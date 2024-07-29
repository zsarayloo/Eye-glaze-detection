function [Target, new_image]=Generate_Target(Im)
eyeDetector = vision.CascadeObjectDetector('EyePairBig');
% preprocessing
In=pre_process(im2double(Im));

% detecting eyes
bboxeye = step(eyeDetector, In);

%% de center of eyes
x=bboxeye(1);
y=bboxeye(2);
W=bboxeye(3);
H=bboxeye(4);
Mask=In(y:(y+H),x:(x+W),:);

LeyeDetector = vision.CascadeObjectDetector('LeftEye');
bbox_Leye = step(LeyeDetector, Mask);

Leye = insertObjectAnnotation( Mask, 'rectangle',bbox_Leye,'single eye');
figure, imshow(Leye), title('Detected eyes');
S_b=size(bbox_Leye);
W1=bbox_Leye(:,3);
H1=bbox_Leye(:,4);
S=size(Mask);
Mask2=zeros(S(1),S(2),3);
if S_b(1,1)==0
    Mask2=Mask;
end
if S_b(1,1)==1
Mask2(bbox_Leye(1,2):(bbox_Leye(1,2)+bbox_Leye(1,4)),bbox_Leye(1,1):(bbox_Leye(1,1)+bbox_Leye(1,3)),:)=Mask(bbox_Leye(1,2):(bbox_Leye(1,2)+bbox_Leye(1,4)),bbox_Leye(1,1):(bbox_Leye(1,1)+bbox_Leye(1,3)),:);
end
if S_b(1,1)>=2
Mask2(bbox_Leye(2,2):(bbox_Leye(2,2)+bbox_Leye(2,4)),bbox_Leye(2,1):(bbox_Leye(2,1)+bbox_Leye(2,3)),:)=Mask(bbox_Leye(2,2):(bbox_Leye(2,2)+bbox_Leye(2,4)),bbox_Leye(2,1):(bbox_Leye(2,1)+bbox_Leye(2,3)),:);
end


S=size(In);
new_image=zeros(S(1),S(2),3);
new_image(y:(y+H),x:(x+W),:)=Mask2;
% figure,imshow(new_image);
% title('detect eye')

nn=rgb2gray(new_image);
% level=graythresh(im2double(nn));%threshold by otsu method on cr component
% I_bw=im2bw(im2double(nn),level);
% figure,imshow(I_bw);
% title('threshold by otsu mathode on image')

if S_b(1,1)==0
    R_max=10;
    R_min=ceil(R_max/3);
else
R_max=ceil(min(min(H1,W1)/2));
R_min=ceil(R_max/3);
end

[centers,radii,metric] = imfindcircles(nn,[R_min R_max],'ObjectPolarity','dark','Sensitivity',1);

% centersStrong2 = centers(1:2,:);
% radiiStrong2 = radii(1:2);
% metricStrong2 = metric(1:2);
% viscircles(centersStrong2, radiiStrong2,'EdgeColor','b');
% hold on
% plot(centersStrong2(:,1),centersStrong2(:,2),'*r')
% title('detect center of eyes')

a1=ceil(sqrt(2*(radii(1)^2)));
xs1=ceil(centers(1,2)-a1);
ys1=ceil(centers(1,1)-a1);
A=Im(xs1:xs1+2*a1,ys1:ys1+2*a1,:);
S_C=size(centers);
if S_C(1)>1
a2=ceil(sqrt(2*(radii(2)^2)));
xs2=ceil(centers(2,2)-a2);
ys2=ceil(centers(2,1)-a2);
B=Im(xs2:xs2+2*a2,ys2:ys2+2*a2,:);

R1=mean(mean(A(:,:,1)));
G1=mean(mean(A(:,:,2)));
B1=mean(mean(A(:,:,3)));
R2=mean(mean(A(:,:,1)));
G2=mean(mean(A(:,:,2)));
B2=mean(mean(A(:,:,3)));

Target=[R1+R2 ;G1+G2; B1+B2]./2;
else
R1=mean(mean(A(:,:,1)));
G1=mean(mean(A(:,:,2)));
B1=mean(mean(A(:,:,3)));
Target=[R1 ;G1; B1];
end






%
%




