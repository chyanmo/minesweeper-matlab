function Click
% 鼠标左键点击格子时触发

global GUI GameSize Init BombSet StartPoint BombMap BombImg VisualMap BombNum MarkMap

% 如果是首次点击, 记录点击的位置, 进行初始化, 生成 BombSet, BombMap 等
if Init == 0
    StartPoint = get(gco,'UserData');
    setBomb;
    drawMap;
    Init = 1;

% 显示'新的游戏'按钮, 点击可重新开始
GUI.start = uicontrol(Parent=GUI.h, ...
            Style='pushbutton',String='新的游戏',Units='normalized', ...
            FontWeight='bold',FontSize=10,...
            Position=[8/(GameSize+2),0.865,2/(GameSize+2),1/(GameSize+2)], ...
                    ButtondownFcn='RightKey',...
                    CallBack='GameRestart(0)');
end

% 点击的位置
pos = get(gco,'UserData');

% 若点击了 周围 3x3 范围内都没有雷的格子时(称之为零格), 调用寻零函数
if BombSet(pos(1),pos(2)) == 0 && BombMap(pos(1),pos(2)) == 0
    findzeros(pos(1),pos(2));

% 如果 周围 3x3 范围内有雷, 显示雷的数量
elseif BombSet(pos(1),pos(2)) == 0 && BombMap(pos(1),pos(2)) > 0
    set(gco,'Enable','off');
    set(gco,'string',BombMap(pos(1),pos(2)));
    VisualMap(pos(1),pos(2)) = 0;

% 如果点到了雷, 游戏失败
else 
    set(gco,'Cdata',BombImg)
    GameRestart(1);
end

% 刷新左上角的计数器
BombRes = BombNum - sum(MarkMap(:));
set(GUI.num,'string',num2str(BombRes));

% 如果没有雷的格子都点开则游戏成功
if sum(VisualMap(:)) == BombNum
    GameRestart(2);
end
