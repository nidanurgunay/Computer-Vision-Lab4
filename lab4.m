clc;
clear all;
close all;
i=imread("Monastry.bmp");
k=imread("checker.jpg");
k=rgb2gray(k);
l=imread("blocks.png");


check=checkerboard;
lab4ktcorners(l,50);



%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%
figure
subplot(2,2,1);
imshow(k);
title("Original Image");
subplot(2,2,2);
k1=edge(k,"Canny");
imshow(k1);
title("Edges");
subplot(2,2,3);
[H,T,R] = hough(k1,'RhoResolution',0.5,'Theta',-90:0.5:89);
imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
          'InitialMagnification','fit');
    title('Hough transform of checker');
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal, hold on;

title("Hough Transform");
subplot(2,2,4);
    P  = houghpeaks(H, 20, 'Threshold',0.5*max(H(:)));
    imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal, hold on;
    plot(T(P(:,2)),R(P(:,1)),'s','color','white');

lab4houghlines(k);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%KANADE-TOMASI CIRCLE DETECTION%%%%%%%%
 circle=imread("circlesBrightDark.png");
%circle=imread("images2.png");
  [r,c] = size(circle);
 
  tic;
    figure;
        imshow(circle)
        [centersBright, radiiBright] = imfindcircles(circle,[20 60],'ObjectPolarity','bright');
        viscircles(centersBright, radiiBright,'Color','b');
      m=toc;
      title(["Detected Circle using Hough Transform 20<=Radius <=60", num2str(m)]);
      
        tic;
    figure;
        imshow(circle)
    [centersBright, radiiBright] = imfindcircles(circle,[20 60],'ObjectPolarity','bright', 'Sensitivity',0.9);
    viscircles(centersBright, radiiBright,'Color','r');
    d=toc;
     title(["Detected Circle using Hough Transform20<=Radius <=60 & the sensivity 0.9", num2str(d)]);
    figure;
    imshow(circle)
    [centersBright, radiiBright] = imfindcircles(circle,[20 60],'ObjectPolarity','bright', 'Sensitivity',0.9);
    [centersDark, radiiDark] = imfindcircles(circle,[20 60],'ObjectPolarity','dark');
    viscircles(centersBright, radiiBright,'Color','b');
    viscircles(centersDark, radiiDark,'LineStyle','--');
    h=toc;
    title(["Detected Bright and Dark Circles 20<=Radius <=60& the sensivity 0.9", num2str(h)]);





