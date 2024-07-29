function L=im_denoise(I)% remove noise from image
L(:,:,1)=medfilt2(I(:,:,1));
L(:,:,2)=medfilt2(I(:,:,2));
L(:,:,3)=medfilt2(I(:,:,3));


