function [] = findzeros(x,y)
% 寻零函数, 目的是 在点击一个 周围 3x3 范围内都没有雷的格子时(称之为零格), 向四周继续寻找零格
% 并自动点开零格及周围一圈格子

global GUI GameSize BombMap FindMap VisualMap MarkMap

FindMap(x,y) = 1;

% 作用于零格, 相当于点击它们
set(GUI.button(y,GameSize+1-x),'Enable','off');
set(GUI.button(y,GameSize+1-x),'Cdata',[]);
set(GUI.button(y,GameSize+1-x),'string','');

for i = x-1:x+1
    for j = y-1:y+1
        if i>0 && j>0 && i<=GameSize && j<=GameSize
            % 将这些格子记录为点开且取消标记
            VisualMap(i,j) = 0;
            MarkMap(i,j) = 0;

            % 防止重复寻零而陷入死循环
            if FindMap(i,j) == 1
                continue;
            elseif BombMap(i,j) == 0
                findzeros(i,j);
            else 
                % 作用于零格周围的格子, 作用相当于点击它们
                set(GUI.button(j,GameSize+1-i),'Enable','off');
                set(GUI.button(j,GameSize+1-i),'Cdata',[]);
                set(GUI.button(j,GameSize+1-i),'string',BombMap(i,j));
            
            end
        end
    end
end
