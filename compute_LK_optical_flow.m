function [u, v] = compute_LK_optical_flow(im1, im2)
a1 = im1;
a2 = im2;
b = size(a1);
a1 = double(a1);
a2 = double(a2);

% Generating Fx Fy and Ft
rx = [-1 1;-1 1];
ry = [1 1;-1 -1];

fx = zeros(b(1)-1,b(2)-1);
fy = zeros(b(1)-1,b(2)-1);
ft = zeros(b(1)-1,b(2)-1);
for i = 1:b(1)-1
    for j = 1:b(2)-1
        fx(i,j) = 0.5*(sum(sum(a1(i:i+1,j:j+1).*rx)) + sum(sum(a2(i:i+1,j:j+1).*rx)));
        fy(i,j) = 0.5*(sum(sum(a1(i:i+1,j:j+1).*ry)) + sum(sum(a2(i:i+1,j:j+1).*ry)));
        ft(i,j) = sum(sum(a2(i:i+1,j:j+1) - a1(i:i+1,j:j+1)));
    end
end

[height, width] = size(fx);
% for i = w+1 : height - w
% for j = w+1 : width-w
% Creating the u and v matrices
u = zeros(b(1)-1,b(2)-1);
v = zeros(b(1)-1,b(2)-1);
w=40;    
for i = w+1 : height - w
    for j = w+1 : width-w
        x = fx(i-w:i+w,j-w:j+w);
        x = x(:);
        y = fy(i-w:i+w,j-w:j+w);
        y = y(:);
        t = -ft(i-w:i+w,j-w:j+w);
        t = t(:);
        Amat = [x(:),y(:)];
        bvec = t(:);
        if det((Amat')*Amat) ~=0
            U = ((Amat')*Amat)\(Amat'*bvec);
            u(i,j) = U(1);
            v(i,j) = U(2);
        end
        
    end

end
% Apply a threshold on the flow vector length (e.g., set a minimum magnitude)
min_magnitude = 2;  % Adjust this threshold as needed

u(abs(u) < min_magnitude) = 0;
v(abs(v) < min_magnitude) = 0;

% im1t = im1;
% ww = 40;
% w = round(ww/2);
% % im1 = imresize(im1, 0.5); % downsize to half
% % im2 = imresize(im2, 0.5); % downsize to half
% 
% 
% [dx, dy, dt] = partial_derivatives(im1, im2);
% % disp(size(dx));
% u = zeros(size(im1));
% v = zeros(size(im2));
% [height, width] = size(dx);
% for i = w+1 : height - w
% for j = w+1 : width-w
% 
%     Ix = dx(i-w:i+w, j-w:j+w);
%     Iy = dy(i-w:i+w, j-w:j+w);
%     It = dt(i-w:i+w, j-w:j+w);
% % % 
% %     Ix=Ix';
% %     Iy=Iy';
% %     It = It';
% 
%     Ix = Ix(:);
%     Iy = Iy(:);
%     b = -It(:);
% 
%     A = [Ix Iy];
%     f = pinv(double(A))*double(b);
% 
%     u(i,j) = f(1);
%     v(i,j) = f(2);
% end
% end
% % u(k)=f(1);
% % v(k)=f(2);
% % downsize u and v
% % u = imresize(u, size(im1t));
% % v = imresize(v, size(im1t));
% 
% % get coordinate for u and v in the original frame
% % [m, n] = size(im1t);
% % [X,Y] = meshgrid(1:n, 1:m);
% % X_deci = X(1:20:end, 1:20:end);
% % Y_deci = Y(1:20:end, 1:20:end);
% % 
% % figure();
% % imshow(fr2);
% % hold on;
% % draw the velocity vectors
% % quiver(X_deci, Y_deci, u_deci,v_deci, 'y')
% 
% function [dx, dy, dt] = partial_derivatives(im1, im2)
% 
% dx = conv2(im1, [-1 1; -1 1], 'same') + conv2(im2, [-1 1; -1 1], 'same');
% dy = conv2(im1, [1 1; -1 -1], "same") + conv2(im2, [1 1; -1 -1], "same");
% % dt = conv2(im1, ones(2), "valid") + conv2(im2, -ones(2),"valid");
% dt = im1 - im2;
% % 
% % dx = dx(1:size(dx,1)-1, 1:size(dx,2)-1);
% % dy = dy(1:size(dy,1)-1, 1:size(dy,2)-1);
% % dt = dt(1:size(dt,1)-1, 1:size(dt,2)-1);
% 
% 
% 
