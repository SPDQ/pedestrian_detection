clear;
clc;
for l=1:1108
    Im=imread(['images/',num2str(l),'.bmp']);
    Im=im2double(Im);
    bac=255*ones(288,352);
    x1=0;
    y1=0;
    count=0;
    hwidth=20;
    hheight=45;
    width=18;
    height=40;
    if(l==1)
        bac(150:240,160:212)=Im(150:240,160:212);
        %bac(148:243,182:228)=Im(148:243,182:228);
        
        dif=bac<0.22;
        dif1=dif;
        imLabel = bwlabel(dif);% 对连通区域进行标记
        stats = regionprops(imLabel,'Area');
        [b,index]=sort([stats.Area],'descend');
        if length(stats)<1
            dif=imLabel;
        else
            dif=ismember(imLabel,index(1:1));
        end  
        se1=strel('disk',1);
        dif=imdilate(dif,se1);
        %imshow(dif)
        for i=1:288
            for j=1:352
                if dif(i,j)==1
                    x1=x1+j;
                    y1=y1+i;
                    count=count+1;
                end
            end
        end
        x(l)=ceil(x1/count);
        y(l)=ceil(y1/count);
        Im(y(l)-hheight,x(l)-hwidth:x(l)+hwidth)=255;
        Im(y(l)+hheight,x(l)-hwidth:x(l)+hwidth)=255;
        Im(y(l)-hheight:y(l)+hheight,x(l)-hwidth)=255;
        Im(y(l)-hheight:y(l)+hheight,x(l)+hwidth)=255;
        imshow(dif1)
     end
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     if(l>1)%
         bac(y(l-1)-height:y(l-1)+height,x(l-1)-width:x(l-1)+width)=Im(y(l-1)-height:y(l-1)+height,x(l-1)-width:x(l-1)+width);
         %bac=im2double(bac);
         dif=bac<0.19;
         se1=strel('square',3);
         se2=strel('disk',3);
        dif=imclose(dif,se1);
        dif=imdilate(dif,se2);
        imLabel = bwlabel(dif);% 对连通区域进行标记
        stats = regionprops(imLabel,'Area');
        [b,index]=sort([stats.Area],'descend');
        if length(stats)<1
            dif=imLabel;
        else
            dif=ismember(imLabel,index(1:1));
        end  
        for i=1:288
            for j=1:352
                if dif(i,j)==1
                    x1=x1+j;
                    y1=y1+i;
                    count=count+1;
                end
            end
        end
        x(l)=ceil(x1/count);
        y(l)=ceil(y1/count);
%         if (l>3)
% %             x2(l)=(8*x(l-1)+5*x(l-2)+2*x(l-3)-x(l-4)-4*x(l-5))/10;
% %             y2(l)=(8*y(l-1)+5*y(l-2)+2*y(l-3)-y(l-4)-4*y(l-5))/10;
% %             x3(l)=(9*x(l-1)-4*x(l-3)-3*x(l-4)+3*x(l-5))/5;
% %             y3(l)=(9*y(l-1)-4*y(l-3)-3*y(l-4)+3*y(l-5))/5;
% %             wx=0.001;
% %             wy=0.999;
% %             x5(l)=wx*x2(l)+(1-wx)*x3(l);
% %             y5(l)=wy*y2(l)+(1-wy)*y3(l);
% %             
% %             x(l)=ceil(x5(l));
% %             y(l)=ceil(y5(l));
%               x(l)=x(l-1)+uint32(0.6*(x(l-1)-x(l-2))+0.4*(x(l-2)-x(l-3)));
%               y(l)=y(l-1)+uint32(0.6*(y(l-1)-y(l-2))+0.4*(y(l-2)-y(l-3)));
%          end    
        Im(y(l)-hheight,x(l)-hwidth:x(l)+hwidth)=255;
        Im(y(l)+hheight,x(l)-hwidth:x(l)+hwidth)=255;
        Im(y(l)-hheight:y(l)+hheight,x(l)-hwidth)=255;
        Im(y(l)-hheight:y(l)+hheight,x(l)+hwidth)=255;
        imshow(Im)
        %imshow(dif)
%         hold on;
%         plot(x,y);
     end
end    