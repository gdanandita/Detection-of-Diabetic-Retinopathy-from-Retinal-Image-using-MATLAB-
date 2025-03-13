clc; clear all;

%loading a sample image of diabetic retinopathy
I = imread("D:\Study\4-1\project\sample.jpg");
figure(1)
subplot(321)
imshow(I);
title("Original Image");

%rgb to gray conversion
I_gray = rgb2gray(I);
subplot(322)
imshow(I_gray);
title("Gray Scale Image");

%Applying filters
h = fspecial('gaussian', [3 3], 0.5); %creating a gaussian filter
I_gau = imfilter(I_gray, h);
subplot(323)
imshow(I_gau)
title("Filtered with Gaussian filter")

% Thresholding
resolution = size(I_gau);
I_th = zeros(resolution(1,1), resolution(1,2));
for i=1:resolution(1,1) 
    for j=1:resolution(1,2) 
        if I_gau(i,j)>=185
            I_th(i,j)= 255;
        end 
    end 
end
subplot(324)
imshow(I_th)
title("Thesholding")


% Applying closing operation
NHOOD=[0 0 1; 0 1 0; 1 0 0]; 
I_cl = imclose(I_th,NHOOD);
subplot(325)
imshow(I_cl)
title("Closed operation")
% %removing the optic disc 
for i=165:210 
    for j=510:540
       I_cl(i,j) = 0;
    end 
end
subplot(326)
imshow(I_cl)
title("Removing the optic disc")

%converting to binary
I_bin = imbinarize(I_cl);

% making the decision
retina = sum(I_bin(:));
spot = (retina/(resolution(1,1)*resolution(1,2)))*100;

if(spot>0.2)
    fprintf("Diabetic Retinopathy Detected\n");
else
    fprintf("Normal eye\n");  
end

% showing the probable affected area
figure(2)
imshow(I_bin)
title("Probable affected area of dibetic retinopathy");
