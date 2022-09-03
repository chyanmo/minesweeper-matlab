function drawMap
% 生成 BombMap

global GameSize BombSet BombMap

% 在 BombSet矩阵 周围增加一圈0 , 防止越界
BombSetL = padarray(BombSet,[1,1]);

% 计算每个格子周围 3x3 区域内的雷的数量
for i = 1:GameSize
    for j = 1:GameSize
        BombMap(i,j) = sum(sum(BombSetL(i:i+2,j:j+2)));
    end
end


