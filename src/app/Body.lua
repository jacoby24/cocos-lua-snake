--
-- Created by IntelliJ IDEA.
-- User: rdcchina
-- Date: 2018/1/25
-- Time: 下午3:55
-- To change this template use File | Settings | File Templates.
--
local Body = class("body")


function Body:ctor(snake,x ,y,node)
    self.snake = snake
    self.x = x
    self.y = y
    self.node = node
    self.sp = cc.Sprite:create("snake_body.jpeg")
    self.node:addChild(self.sp)
    self:Update()

end

function Body:Update()

    local posx, posy = Grid2Pos(self.x,self.y)
    self.sp:setPosition(posx,posy)
end


return Body

