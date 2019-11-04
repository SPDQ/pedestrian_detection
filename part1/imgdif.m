clear
clc
video=cell(1,297);
blur=cell(1,297);
dif=cell(1,295);
for m=0:296
    if m<10
        name=['images','/','0','0',num2str(m),'.bmp'];
    end
    if m>9 && m<100
        name=['images','/','0',num2str(m),'.bmp'];
    end
    if m>99
        name=['images','/',num2str(m),'.bmp'];
    end
    a=imread(name);
    video{m+1}=a;
end
figure;
hwidth=20;
hheight=45;
for m=1:296
%     %imshow(video{i});
%      H = fspecial('gaussian',9, 3);
%      blur{m}=imfilter(video{m},H,'replicate');
%     if i>1
%         dif3=video{i}-video{i-1};
%         dif3=(dif>10)*255;
%         
%         imshow(dif);
%     end
    if m==3
        dif1=abs(video{m}-video{m-1});
        dif2=abs(video{m-1}-video{m-2});
        dif3=((ceil(im2double(dif1.*dif2)/255).*im2double(dif1+dif2)/2)>(5/255))*255;
        imLabel = bwlabel(dif3);% 对连通区域进行标记
        stats = regionprops(imLabel,'Area');
        [b,index]=sort([stats.Area],'descend');
        if length(stats)<4
            dif{m-2}=imLabel;
        else
            dif{m-2}=ismember(imLabel,index(1:4));
        end  
        se1=strel('disk',10);
        dif{m-2}=imdilate(dif{m-2},se1);
        %imshow(dif{m-2});
        x1=0;
        y1=0;
        count=0;
        for i=1:288
            for j=1:352
                if dif{m-2}(i,j)==1
                    x1=x1+j;
                    y1=y1+i;
                    count=count+1;
                end
            end
        end
        x(m-2)=ceil(x1/count);
        y(m-2)=ceil(y1/count);
        video{m}(y(m-2)-hheight,x(m-2)-hwidth:x(m-2)+hwidth)=255;
        video{m}(y(m-2)+hheight,x(m-2)-hwidth:x(m-2)+hwidth)=255;
        video{m}(y(m-2)-hheight:y(m-2)+hheight,x(m-2)-hwidth)=255;
        video{m}(y(m-2)-hheight:y(m-2)+hheight,x(m-2)+hwidth)=255;
        imshow(video{m})
    end
%     if i>3
%         dif1=video{i}-video{i-2};
%         dif2=video{i-1}-video{i-3};
%         dif=((uint16(dif1).*uint16(dif2))>1000)*255;
%         imshow(dif);
%     end
    %imshow(g);
    if m>3
        dif1=video{m}-video{m-1};
        dif2=video{m-1}-video{m-2};
        dif3=((ceil(im2double(dif1.*dif2)/255).*im2double(dif1+dif2)/2)>(6/255))*255;
        dif3(1:y(m-3)-hheight,:)=0;
        dif3(y(m-3)+hheight:288,:)=0;
        dif3(y(m-3)-hheight:y(m-3)+hheight,1:x(m-3)-hwidth)=0;
        dif3(y(m-3)-hheight:y(m-3)+hheight,x(m-3)+hwidth:355)=0;
        %imshow(dif3);
        
        imLabel = bwlabel(dif3);% 对连通区域进行标记
        stats = regionprops(imLabel,'Area');
        [b,index]=sort([stats.Area],'descend');
        if length(stats)<3
            dif{m-2}=imLabel;
        else
            dif{m-2}=ismember(imLabel,index(1:3));
        end  
        se1=strel('disk',8);
        dif{m-2}=imdilate(dif{m-2},se1);
        %imshow(dif{m-2});
        x1=0;
        y1=0;
        count=0;
        for i=1:288
            for j=1:352
                if dif{m-2}(i,j)==1
                    x1=x1+j;
                    y1=y1+i;
                    count=count+1;
                end
            end
        end
        x(m-2)=ceil(x1/count);
        y(m-2)=ceil(y1/count);
        video{m}(y(m-2)-hheight,x(m-2)-hwidth:x(m-2)+hwidth)=255;
        video{m}(y(m-2)+hheight,x(m-2)-hwidth:x(m-2)+hwidth)=255;
        video{m}(y(m-2)-hheight:y(m-2)+hheight,x(m-2)-hwidth)=255;
        video{m}(y(m-2)-hheight:y(m-2)+hheight,x(m-2)+hwidth)=255;
        imshow(video{m})
    end
end