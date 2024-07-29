function In=pre_process(Im)
Im=im_denoise(Im);
I=rgb2ycbcr(Im);% Convert RGB color space to YCbCr
level=graythresh(im2double(I(:,:,3)));%threshold by otsu method on cr component
I_bw=im2bw(im2double(I(:,:,3)),level);
BW2 = bwareafilt(I_bw,1);%keep the face(the largest area)
B1 = imfill(BW2,'holes');%Generate mask of face
B1=double(B1);
Im=im2double(Im);
% applying mask on image
In(:,:,1)=B1.*Im(:,:,1);
In(:,:,2)=B1.*Im(:,:,2);
In(:,:,3)=B1.*Im(:,:,3);
figure,imshow(In);
title('pre process')


