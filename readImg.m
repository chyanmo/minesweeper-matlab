function [a,b] = readImg

%读取地雷的图片
a = imread('bomb.png','BackgroundColor',[1,1,1]);
a = imresize(a,0.6);

% 读取标记的图片
b = imread('mark.png','BackgroundColor',[1,1,1]);
b = imresize(b,0.6);