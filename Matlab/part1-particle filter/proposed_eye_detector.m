function box=proposed_eye_detector(I)
I=im2double(I);
S=size(I);
gx=zeros(S(1),S(2));
gy=zeros(S(1),S(2));

faceDetector = vision.CascadeObjectDetector;
bboxes = step(faceDetector, I);
bboxPoints = bbox2points(bboxes(1, :));

IFaces = insertObjectAnnotation(I, 'rectangle', bboxes, 'Face');
figure, imshow(IFaces), title('Detected faces');

I1=rgb2hsv(I);
ch1=I1(:,:,1);
ch2=I1(:,:,2);
ch3=I1(:,:,3);

figure,imshow(ch1.*ch2,[])
figure,imshow(ch2,[])
figure,imshow(ch3,[])



hedge = vision.EdgeDetector;
edges = step(hedge,ch2);
imshow(edges)

% [Gx,Gy] = imgradientxy(I1(:,:,2));
% gx(bboxPoints(1,2):bboxPoints(3,2),bboxPoints(1,1):bboxPoints(2,1))=Gx(bboxPoints(1,2):bboxPoints(3,2),bboxPoints(1,1):bboxPoints(2,1));
% gy(bboxPoints(1,2):bboxPoints(3,2),bboxPoints(1,1):bboxPoints(2,1))=Gy(bboxPoints(1,2):bboxPoints(3,2),bboxPoints(1,1):bboxPoints(2,1));
% 
% figure,imshow(gx)
% figure,imshow(gy)

projectx=sum(edges,2);
projecty=sum(edges,1);
imshow(I)
hold on
plot(projectx)
plot(projecty)

eyesDetector = vision.CascadeObjectDetector('EyePairBig');
 step(eyesDetector, I);