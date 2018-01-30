--
-- Created by IntelliJ IDEA.
-- User: rdcchina
-- Date: 2018/1/30
-- Time: 下午6:02
-- To change this template use File | Settings | File Templates.
--
local Food = class('Food')

local size = cc.Director:getInstance():getVisibleSize()

function Food:ctor(node)
    self.node = node
    self.sp = cc.Sprite:create("food.jpeg")
    --self.sp:setScale(0.5)
    node:addChild(self.sp)
    self:Update()

end

function Food:Update()
    local posx = math.random(40,size.width-40)
    local posy = math.random(40,size.height-40)

    self.sp:setPosition(posx,posy)
end

return Food