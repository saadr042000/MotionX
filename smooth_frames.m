function smooth_frames(folder_name,smoothing_factor,start_index,end_index)

% ----------------------------------------------------------%
% Reads in a sequence of image frames                       %
% Converts rgb to gray, and places each frame in a 3D array.%
% Smooths the frames in the "Z" (stack) direction           %
% using a Gaussian with the specified smoothing lvl (0-1.0) %
% Then save the smoothed frames as images.                  %
% ----------------------------------------------------------%

frame_1 = single(rgb2gray(read_image(folder_name,start_index)));

% Create a 3D stack to store all the frames

stack(:,:,:)=zeros(size(frame_1,1),size(frame_1,2),(end_index - start_index)+1);

% Now populate each slice in the stack
for i=start_index:1:end_index
    frame = single(rgb2gray(read_image(folder_name,i)));
    stack(:,:,i)=frame;
end

% Now smooth the stack in the 'Z' (3rd dimension) using a Gaussian

smoothstack = smoothdata(stack,3,'gaussian','SmoothingFactor',smoothing_factor);

% Spatial smoothing using a Gaussian filter
for i = start_index:end_index
    smoothstack(:, :, i) = imgaussfilt(smoothstack(:, :, i), 2); % Adjust the smoothing factor (e.g., 2) as needed
end

% Now save the frames

for i=start_index:1:end_index
    imwrite(mat2gray(smoothstack(:,:,i)),fullfile(folder_name,strcat('image_smoothed_',num2str(i),'.png')));
end

end


function I = read_image(folder_name,index)

% -------------------------------- %
% DO NOT CHANGE THIS FUNCTION !!!! %
% -------------------------------- %

if(index < 10)
    I = imread(fullfile(folder_name,strcat('frame0',num2str(index),'.png')));
    % Used to be 'frame0'
elseif(index < 100)
    I = imread(fullfile(folder_name,strcat('frame',num2str(index),'.png')));
else    
    I = imread(fullfile(folder_name,strcat('frame0',num2str(index),'.png')));
end

end

