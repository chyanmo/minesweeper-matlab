function setBomb
% 生成雷图

global  GameSize BombSet StartPoint BombNum


BombNum1 = BombNum;

% 随机生成
while BombNum1
    x = randi(GameSize);
    y = randi(GameSize);
    if BombSet(x,y) == 0
        BombSet(x,y) = 1;
        BombNum1 = BombNum1 - 1;
    end
end

% 将第一次点击的格子周围 3x3 区域内的雷全部移走, 保证第一次点击的格子自身及周围都没有雷, 从而触发寻零函数
for i = StartPoint(1)-1:StartPoint(1)+1
    for j = StartPoint(2)-1:StartPoint(2)+1
        if i > 0 && j > 0 && i <= GameSize && j<= GameSize
            while BombSet(i,j) == 1

                x = randi(GameSize);
                y = randi(GameSize);
                if BombSet(x,y) == 0 && abs(x-StartPoint(1)) > 1 && abs(y-StartPoint(2)) > 1
                    BombSet(i,j) = 0;
                    BombSet(x,y) = 1;
                    break;
                end

            end
        end
    end
end