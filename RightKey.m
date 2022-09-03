function RightKey
%右键触发函数

global MarkImg MarkMap GUI BombNum

% 被点开的格子不能被标记
isButtonEnable = get(gco,'Enable');
if isButtonEnable(2) == 'f'
    return
end

str = get(gco,'String');
pos = get(gco,'UserData');

% 标记或取消标记
if(isempty(str))
    set(gco,'String',' ');
    set(gco,'Cdata',MarkImg);
    set(gco,'CallBack','');
    MarkMap(pos(1),pos(2)) = 1;
else
    set(gco,'String','');
    set(gco,'Cdata',[]);
    set(gco,'CallBack','Click');
    MarkMap(pos(1),pos(2)) = 0;
end

% 更新左上角的计数器
BombRes = BombNum - sum(MarkMap(:));
set(GUI.num,'string',num2str(BombRes));
