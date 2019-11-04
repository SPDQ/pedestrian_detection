clear
clc
video=cell(1,297);
blur=cell(1,297);
dif=cell(1,297);
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
dif1=double(zeros(288,352));
dif2=uint32(zeros(288,352));
hwidth=20;
hheight=42;
for m=2:297
    dif1=dif1+double(video{m});
end   
dif1=dif1/296;
% for m=100:297
%     dif2=dif2+uint32(video{m});
% end   
% dif2=dif2/173;
figure;
%imshow(dif1,[]);
for m=1:297
    if m==1
        %dif1=(video{m}+video{m-1}+video{m-2}+video{m-3}+video{m-4}+video{m-5}+video{m-6}+video{m-7}+video{m-8}+video{m-9}+video{m-10}+video{m-11}+video{m-12}+video{m-13}+video{m-14})/15;
        %dif{m}=video{m}-uint8(dif1*255);
        dif{m}=(abs(double(video{m})-dif1)>15)*255;
        %imshow(abs(double(video{m})-dif1),[]);
        %dif3=((ceil(im2double(dif1.*dif2)/255).*im2double(dif1+dif2)/2)>(6/255))*255;
        imLabel = bwlabel(dif{m});% 对连通区域进行标记
        stats = regionprops(imLabel,'Area');
        [b,index]=sort([stats.Area],'descend');
        if length(stats)<2
            dif{m}=imLabel;
        else
            dif{m}=ismember(imLabel,index(1:2));
        end  
        se1=strel('disk',5);
        dif{m}=imdilate(dif{m},se1);
        %imshow(dif{m});
        x1=0;
        y1=0;
        count=0;
        for i=1:288
            for j=1:352
                if dif{m}(i,j)==1
                    x1=x1+j;
                    y1=y1+i;
                    count=count+1;
                end
            end
        end
        x=uint16(zeros(1,297));
        y=uint16(zeros(1,297));
        x(m)=ceil(x1/count);
        y(m)=ceil(y1/count);
        video{m}(y(m)-hheight,x(m)-hwidth:x(m)+hwidth)=255;
        video{m}(y(m)+hheight,x(m)-hwidth:x(m)+hwidth)=255;
        video{m}(y(m)-hheight:y(m)+hheight,x(m)-hwidth)=255;
        video{m}(y(m)-hheight:y(m)+hheight,x(m)+hwidth)=255;
        imshow(video{m},[])
      end
    if m>1
        H = fspecial('gaussian',12, 4);
        %dif2=imfilter(video{m},H,'replicate');
        dif{m}=abs(double(video{m})-dif1);
        %imshow(dif{m},[]);
        dif{m}(1:y(m-1)-hheight,:)=0;
        dif{m}(y(m-1)+hheight:288,:)=0;
        dif{m}(y(m-1)-hheight:y(m-1)+hheight,1:x(m-1)-hwidth)=0;
        dif{m}(y(m-1)-hheight:y(m-1)+hheight,x(m-1)+hwidth:355)=0;
        dif{m}=(dif{m}>22)*255;
        se1=strel('square',18);
        dif{m}=imdilate(dif{m},se1);
        imLabel = bwlabel(dif{m});% 对连通区域进行标记
        stats = regionprops(imLabel,'Area');
        [b,index]=sort([stats.Area],'descend');
        if length(stats)<2
            dif{m}=imLabel;
        else
            dif{m}=ismember(imLabel,index(1:2));
        end  
        x1=0;
        y1=0;
        count=0;
        for i=1:288
            for j=1:352
                if dif{m}(i,j)==1
                    x1=x1+j;
                    y1=y1+i;
                    count=count+1;
                end
            end
        end
        x=uint16(zeros(1,297));
        y=uint16(zeros(1,297));
        x(m)=ceil(x1/count);
        y(m)=ceil(y1/count);
        video{m}(y(m)-hheight,x(m)-hwidth:x(m)+hwidth)=255;
        video{m}(y(m)+hheight,x(m)-hwidth:x(m)+hwidth)=255;
        video{m}(y(m)-hheight:y(m)+hheight,x(m)-hwidth)=255;
        video{m}(y(m)-hheight:y(m)+hheight,x(m)+hwidth)=255;
        imshow(video{m},[]);
     end
    %imshow(g);
end