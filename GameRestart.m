function [] = GameRestart(tmp)
global GUI GameSize Init BombSet BombMap FindMap MarkImg FullScreenSize BombImg VisualMap BombNum MarkMap


switch(tmp)

    % 踩到地雷时触发
    case 1
        % 显示所有地雷的位置
        for i = 1:GameSize
            for j = 1:GameSize
                if BombSet(i,j) == 1
                    set(GUI.button(j,GameSize+1-i),'Cdata',BombImg);
                elseif BombMap(i,j) > 0
                    set(GUI.button(j,GameSize+1-i),'string',BombMap(i,j));
                    set(GUI.button(j,GameSize+1-i),'Enable','off');
                else
                    set(GUI.button(j,GameSize+1-i),'Enable','off');
                end
            end
        end

        % 显示失败的文字,颜色为黑色

        GUI.fail = uicontrol(Parent=GUI.h, ...
            Style='Text',String='失败',Units='normalized', ...
            FontWeight='bold',FontSize=15,...
            Position=[4.6/(GameSize+2),0.865,1.5/(GameSize+2),1/(GameSize+2)]);

    % 游戏胜利时(点开所有不是雷的格子)触发    
    case 2

        % 显示胜利的文字,颜色为蓝色
        GUI.win = uicontrol(Parent=GUI.h, ...
            Style='Text',String='胜利',Units='normalized', ...
            FontWeight='bold',FontSize=15,ForegroundColor='b',...
            Position=[4.6/(GameSize+2),0.865,1.5/(GameSize+2),1/(GameSize+2)]);

        % 在所有雷的位置显示标记的图片
        for i = 1:GameSize
            for j = 1:GameSize
                if BombSet(i,j) == 1
                    set(GUI.button(j,GameSize+1-i),'Cdata',MarkImg);
                    set(GUI.button(j,GameSize+1-i),'ButtondownFcn','');
                    set(GUI.button(j,GameSize+1-i),'CallBack','');
                end
            end
        end

        % 显示剩余的雷数为0
        set(GUI.num,'String','0');

    % 第一次进入游戏或重新开始时触发    
    otherwise

        close all

        Init = 0;
        
        GameSize = 9;                           % 地图大小
        BombNum = 10;                           % 雷的数量
        
        BombSet = zeros(GameSize);              % 记录地雷位置的矩阵
        BombMap = zeros(GameSize);              % 记录每个格子所在的 3x3 方格中有多少个雷
        FindMap = zeros(GameSize);              % 记录格子 是否被 findzeros 函数搜索过
        VisualMap = ones(GameSize);             % 记录格子 是否被玩家点开
        MarkMap = zeros(GameSize);              % 记录格子 是否被玩家标记

        % 主窗口
        GUI.h = figure(Name='扫雷' , ...
            units='pixels',...
            position=[FullScreenSize(3)/3,FullScreenSize(4)/4,80+35*GameSize,80+35*GameSize], ...
            MenuBar='none', ...
            NumberTitle='off', ...
            Resize='off');

        % 显示一个数字, 值为雷的个数减去玩家标记的个数
        GUI.num = uicontrol(Parent=GUI.h, ...
            Style='Text',String=num2str(BombNum),Units='normalized', ...
            FontWeight='bold',FontSize=15,ForegroundColor='r',...
            Position=[1/(GameSize+2),0.865,1/(GameSize+2),1/(GameSize+2)]);


        % 生成按钮方阵
        for i = 1:GameSize
            for j = 1:GameSize
                GUI.button(i,j) = uicontrol(Parent=GUI.h, ...
                    Style='pushbutton', ...
                    FontWeight='bold',...
                    FontSize=10,String='',Units='normalized', ...
                    Position=[i/(GameSize+2),1/(GameSize+2)*(j-0.5),1/(GameSize+2),1/(GameSize+2)], ...
                    UserData=[GameSize+1-j,i],...
                    ButtondownFcn='RightKey',...
                    CallBack='Click');
            end
        end
end
return
