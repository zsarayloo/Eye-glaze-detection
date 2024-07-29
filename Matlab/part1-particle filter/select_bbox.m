function B=select_bbox(Im,bboxeye,count)
old=bboxeye;
S=size(Im);
d=floor(mean(floor(S(1)./100),floor(S(2)./100))+count);
bboxeye=bboxeye+[-d,-d,2*d,2*d];
B=bboxeye;
Im=im2double(Im);
im=rgb2gray(Im);
S=size(im);

faceDetector = vision.CascadeObjectDetector;
bbox= step(faceDetector, im);


hedge = vision.EdgeDetector;
im = step(hedge,im);
% imshow(im);


In=zeros(S(1),S(2));
In(bboxeye(1,2):bboxeye(1,2)+bboxeye(1,4),bboxeye(1,1):bboxeye(1,1)+bboxeye(1,3))=im(bboxeye(1,2):bboxeye(1,2)+bboxeye(1,4),bboxeye(1,1):bboxeye(1,1)+bboxeye(1,3));
eye=In;

In=zeros(S(1),S(2));
In(bbox(1,2):bbox(1,2)+bbox(1,4),bbox(1,1):bbox(1,1)+bbox(1,3))=im(bbox(1,2):bbox(1,2)+bbox(1,4),bbox(1,1):bbox(1,1)+bbox(1,3));

face=In;

projectx=sum(eye,2);

projecty=sum(face,1);

%find peaks
x=projectx;

[pksx,locsx] = findpeaks(x);
% 
% findpeaks(x);
% text(locsx+.02,pksx,num2str((1:numel(pksx))'))

%y

y=projecty;

[pksy,locsy] = findpeaks(y);
% 
% findpeaks(y);
% text(locsy+.02,pksy,num2str((1:numel(pksy))'))
 



% sort x and y
[Sy,idy]=sort(pksy);

col=Sy(1,end-1:end);
row=[pksx(1,1) pksx(end,1)] ;

Ly=find_location_peak(col,y)
Lx=find_location_peak(row,x)
w=abs(Ly(2)-Ly(1));
h=abs(Lx(2)-Lx(1));
if h<d
    h=2*d;
end
if w<h
    w=old(1,4);
    if w<h
        w=2*h;
    end
end


B=[Ly(1),Lx(1),w,h]

 
end







