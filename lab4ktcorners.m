function lab4ktcorners (check, t1)

if(length(size(check))==3)
   check=rgb2gray(check); 
end

[r1,c1]=size(check);

check=double(check);
corners=[];

[gx,gy]=imgradientxy(check);


for  i=2:1:r1-2
    for j=2:1:c1-2
        subimgx=gx(i-1:i+1,j-1:j+1);
        subimgy=gy(i-1:i+1,j-1:j+1);
     
        ix=sum(sum(subimgx.*subimgx));
        ixy=sum(sum(subimgx.*subimgy));  
        iy=sum(sum(subimgy.*subimgy));
        
        H=[ix,ixy;ixy,iy];
        eigvalue=eig(H);
        if ( min(eigvalue) > t1)
           corners= [corners; i,j];
        end
    end
end

figure;
check=uint8(check);
imshow(i);
hold on; plot(corners(:,2),corners(:,1),'r*');
title("Corner Detection");

end

