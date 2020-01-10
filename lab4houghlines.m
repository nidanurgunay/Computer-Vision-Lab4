function  lab4houghlines(I)
  
   [r,c,ch] = size(I);

    if ch == 3
      I = rgb2gray(I);
    end
     K=edge(I,"canny");
    [H,T,R] = hough(K,'RhoResolution',0.5,'Theta',-90:0.5:89);

  xlabel('\theta'), ylabel('\rho');
    axis on, axis normal, hold on;
    P  = houghpeaks(H, 20, 'Threshold',0.5*max(H(:)));
  
   xlabel('\theta'), ylabel('\rho');
    axis on, axis normal, hold on;
    plot(T(P(:,2)),R(P(:,1)),'s','color','white');
    
   %%%%%%%%%%%%%%%%%%%% 
    lines = houghlines(K,T,R,P,'FillGap',10,'MinLength',40);
    figure, imshow(I), hold on
    max = 0;
    min = 200;
    for k = 1:length(lines)     
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');


       plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
       plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

       len = norm(lines(k).point1 - lines(k).point2);
       if ( len > max)
          max = len;
          xy_long = xy;
       end
       if( len < min)
           min = len;
           xy_short = xy;
       end
       
    end
    plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');
    plot(xy_short(:,1),xy_short(:,2),'LineWidth',2,'Color','red');
end