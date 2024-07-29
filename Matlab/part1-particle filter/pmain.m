% main programm of the project
clc
clear all
close all
%% Parameters
F_update = [1 0 1 0; 0 1 0 1; 0 0 1 0; 0 0 0 1];
Npop_particles =100;

Xstd_rgb = 0.15;



%% Loading Movie

videoFileReader = vision.VideoFileReader('6_a.avi');
videoFrame      = step(videoFileReader);
v = VideoWriter('EX.mp4','MPEG-4');

% %
% videoPlayer = vision.VideoPlayer;
% while ~isDone(videoFileReader)
%    frame = step(videoFileReader);
%    step(videoPlayer,frame);
% end
% 
% release(videoFileReader);
% release(videoPlayer);
%% Create a cascade detector object.
eyesDetector = vision.CascadeObjectDetector('EyePairBig');
bbox= step(eyesDetector, videoFrame);
%% Draw the returned bounding box around the detected eyes.

videoFrame = insertShape(videoFrame, 'Rectangle', bbox);
figure; imshow(videoFrame); title('Detected eyes');

videoPlayer  = vision.VideoPlayer('Position',...
    [100 100 [size(videoFrame, 2), size(videoFrame, 1)]+30]);

%% Convert the first box into a list of 4 points

bboxPoints = bbox2points(bbox(1, :));


%% Object Tracking by Particle Filter

X = create_particles(bbox,Npop_particles);%creat particle in range of BBOX
Xstd_pos = 0.5*min(bbox(1, 3:4));
Xstd_vec = 5;
[Target_RGB, Target_image]=Generate_Target(videoFrame);
open(v)
oldbboxeye=bbox;
count=0;
Pclass=5;
sigma=0.2;
size_F=size(videoFrame);
Mid_c=size_F(1,2)/2;
countf=0;
N_dif=1;
while ~isDone(videoFileReader)
    % get the next frame
    countf=countf+1;
    videoFrame = step(videoFileReader);
    Y_K=im_denoise(videoFrame);
    % Forecasting
    oldX=X;
    X = update_particles(F_update, Xstd_pos, Xstd_vec, X);
    % detecting eyes
    eyesDetector = vision.CascadeObjectDetector('EyePairBig');
    bboxeye= step(eyesDetector, Y_K);
    size_b=size(bboxeye);
    if size_b(1)==1
        count=0;
        if bboxeye(1,3)<2*bboxeye(1,4)
            bboxeye(1,3)=oldbboxeye(1,3);
            if bboxeye(1,3)<2*bboxeye(1,4)
                bboxeye(1,3)=2*oldbboxeye(1,4);
            end
            
        end
        
    else
%         count=count+1;
%         bboxeye=select_bbox(Y_K,oldbboxeye,count);
        bboxeye=oldbboxeye;
        count=count+1;
    end
    
    
    %% Calculating Log Likelihood
    L = calc_log_likelihood(Xstd_rgb, Target_RGB, X(1:2, :),Y_K,bboxeye);
    
    % Resampling
    X = resample_particles(X, L);
    visiblePoints=X(1:2,:);
    visiblePoints(1,:)=X(2,:);
    visiblePoints(2,:)=X(1,:);
    
    oldbboxeye=bboxeye;
    
    Y_K = insertObjectAnnotation( Y_K, 'rectangle',bboxeye,'detected eyes');
    
%     Y_K = insertMarker(Y_K, visiblePoints', '+', ...
%         'Color', 'white');
%     writeVideo(v,Y_K);
    
%     Showing Image
%     show_particles(X, Y_K);
%     show_state_estimated(X, Y_K);
    if mod(countf,N_dif)==0
       class=Detect_eyedirection(oldX,X,Pclass,bboxeye,sigma,Mid_c);
       B=Generate_patch(Y_K,3,3);
       RGB = insertShape(Y_K,'FilledRectangle',B(class,:));
%     figure, imshow(RGB), title('gaze detection');
       Pclass=class;
       writeVideo(v,RGB);
    else 
     writeVideo(v,Y_K);
    end


%     step(videoPlayer, RGB);
    end

% Clean up
release(videoFileReader);
release(videoPlayer);

close(v)


