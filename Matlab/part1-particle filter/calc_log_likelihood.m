function L = calc_log_likelihood(Xstd_rgb, Xrgb_trgt, X, Y,bboxeye) %#codegen

Npix_h = size(Y, 1);
Npix_w = size(Y, 2);
% [~, Target_image]=Generate_Target(Y);
%% eye detection

faceDetector = vision.CascadeObjectDetector;
bbox= step(faceDetector, Y);
Sbox=size(bbox);
if Sbox(1,1)>1
    b=bbox(:,3:4);
    b=sum(b,2);
    [I,IDX]=sort(b');
    bbox=bbox(IDX(1,end),:);
    S=size(Y);
    Im=im2double(Y);
    In=zeros(S);
    In(bbox(1,2):bbox(1,2)+bbox(1,4),bbox(1,1):bbox(1,1)+bbox(1,3),:)=Im(bbox(1,2):bbox(1,2)+bbox(1,4),bbox(1,1):bbox(1,1)+bbox(1,3),:);
    
elseif Sbox(1,1)==0
    In=Y;
    S=size(Y);
    
else
    S=size(Y);
    Im=im2double(Y);
    In=zeros(S);
    In(bbox(1,2):bbox(1,2)+bbox(1,4),bbox(1,1):bbox(1,1)+bbox(1,3),:)=Im(bbox(1,2):bbox(1,2)+bbox(1,4),bbox(1,1):bbox(1,1)+bbox(1,3),:);
end
%%eye detector
B=bbox2points(bboxeye);
Y=zeros(S);
Y(B(1,2):B(4,2),B(1,1):B(2,1),:)=Im(B(1,2):B(4,2),B(1,1):B(2,1),:);
 
%%

N = size(X,2);

L = zeros(1,N);
Y = permute(Y, [3 1 2]);

A = -log(sqrt(2 * pi) * Xstd_rgb);
B = - 0.5 / (Xstd_rgb.^2);

X = round(X);

for k = 1:N
    
    m = X(1,k);
    n = X(2,k);
    
    I = (m >= 1 & m <= Npix_h);
    J = (n >= 1 & n <= Npix_w);
    z=(Y(1, m, n)==0 & Y(1, m, n)==0 & Y(1, m, n)==0);
    
    if I && J && z==0
        
        C = Y(:, m, n);
        
        D = C - Xrgb_trgt;
        
        D2 = D' * D;
        
        L(k) =  A + B * D2;
    else
        
        L(k) = -Inf;
    end
end
