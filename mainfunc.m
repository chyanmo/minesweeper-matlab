function mainfunc
close all

global BombImg MarkImg FullScreenSize

% 获取屏幕大小
FullScreenSize = get(0,'ScreenSize');   

% 读取需要的图片文件
[BombImg,MarkImg] = readImg;

%调用游戏创建函数
GameRestart(0);

end