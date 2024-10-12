
tic  
clc;
clear;  
close all;         
 addpath(genpath('\tensor_toolbox'));              

lambdaL =1;        
C=5;%5  
L1=3;%L4 L  
%%
file_path1 ='C:\Users\PC\Desktop\DMS\data\data1\';% 
img_path_list1 =  dir(strcat(file_path1,'*.png'));%
img_num = length(img_path_list1);%


for i=1:50
    picname=[file_path1  num2str(i,'%06d'),'.png'];   
    I=imread(picname);%
    [m,n]=size(I); 
    [~, ~, ch]=size(I);
    if ch==3
        I=rgb2gray(I);   
    end
I=double(I);
 D(:,:,i)=I;     
end
D=double(D);
maxzhi=getprior(D);
DP=maxzhi;
sumD=sum(D,3);  
tenD=double(D);
[n1,n2,n3]=size(tenD);         
n_1=max(n1,n2);%n(1)
n_2=min(n1,n2);%n(2)
patch_frames=L1;% temporal slide parameter   
patch_num=n3/patch_frames;
%% constrcut image tensor       
KK=1;
for l=1:patch_num     
    for i=1:patch_frames  
        temp(:,:,i)=tenD(:,:,patch_frames*(l-1)+i);     
        tempDP(:,:,i)=DP(:,:,patch_frames*(l-1)+i);   
    end                              
%% The proposed DMSOGSTV model  
[tenB, tenT,tenN,change] = DMS_OGSTV(temp,tempDP);                     
%% recover the target and background image     
result = min(tenT, [], 3);
 for i=1:patch_frames           
     tarImg=tenT(:,:,i);   
     backImg=tenB(:,:,i);      
     NImg=tenN(:,:,i);
     maxv = max(max(double(I)));  
     tarImg=double(tarImg);  
     backImg=double(backImg);
     NImg=double(NImg);
     result=uint8( mat2gray(result)*maxv );     
     E = ( mat2gray(tarImg)*maxv );  
     A = ( mat2gray(backImg)*maxv);     
     NM = ( mat2gray(NImg)*maxv);             
 figure(1);imshow(E,[]);         
hh=1;
 end
end








