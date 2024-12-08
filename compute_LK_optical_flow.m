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
