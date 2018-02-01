--
-- Created by IntelliJ IDEA.
-- User: rdcchina
-- Date: 2018/2/1
-- Time: 下午2:11
-- To change this template use File | Settings | File Templates.
--

local Fence = class('Fence')


function Fence:GenerateFence(r)
    local finalX,finalY
    for i = 1,4 do
        for j = -r,r  do
            self.sp = cc.Sprite:create('fence.jpeg')
            self.node:addChild(self.sp)
            -- left
            if i == 1 then
               finalX , finalY = Grid2Pos(-r,j)
            end
            -- right
            if i == 2 then
                finalX , finalY = Grid2Pos(r,j)
            end
            -- up
            if i == 3 then
               finalX , finalY = Grid2Pos(j,r)
            end
            -- down
            if i == 4 then
               finalX , finalY = Grid2Pos(j,-r)
            end
            self.sp:setPosition(finalX,finalY)
        end
    end

end

function Fence:ctor(node,r)
    self.node = node
    self:GenerateFence(r)
end


return Fence