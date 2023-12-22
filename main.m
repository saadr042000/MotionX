smooth_frames('/Users/saadrahman/Computer Vision/Assignment2/Q3/Backyard', 0.5, 7, 14)

% demo_optical_flow('/Users/saadrahman/Computer Vision/Assignment2/Q3/Basketball',13,14)
start_frame = 7;
stop_frame = 13;

vidObj = VideoWriter('/Users/saadrahman/Computer Vision/Assignment2/Q3/Backyard/outputVideo.avi', 'Motion JPEG AVI');
vidObj.FrameRate=2;
open(vidObj);

for i=start_frame:stop_frame
    demo_optical_flow('/Users/saadrahman/Computer Vision/Assignment2/Q3/Backyard',i,i+1); %i+1 for subsequent frames
    frame = getframe(gcf);
    writeVideo(vidObj,frame);
    fprintf('Frame #: %d\n',i)
end;

close(vidObj);


