vidObj = VideoWriter(outfile);

open(vidObj);

for i=start_frame:stop_frame
    demo_optical_flow(folder_name,i,i+1); %i+1 for subsequent frames
    frame = getframe(gcf);
    writeVideo(vidObj,frame);
    fprintf('Frame #: %d\n',i)
end;

close(vidObj);
