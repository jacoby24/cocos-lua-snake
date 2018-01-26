--
-- Created by IntelliJ IDEA.
-- User: rdcchina
-- Date: 2018/1/25
-- Time: 下午3:55
-- To change this template use File | Settings | File Templates.
--
local Body = class("body")

local cGridSize = 33
local scaleRate = 1/display.contentScaleFactor

cc.exports.Grid2Pos = function(x,y)
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()

    local finalX = origin.x + visibleSize.width/2 + x * cGridSize * scaleRate
    local finalY = origin.y + visibleSize.height/2 + y * cGridSize * scaleRate

    return finalX, finalY
end

function Body:ctor(snake,x ,y,node)
    self.snake = snake
    self.x = x
    self.y = y
    self.sp = cc.Sprite:create("snake_body.png")
    self.sp:setScale(0.5)
    node:addChild(self.sp)

    self:Update()

end

function Body:Update()
    local posx, posy = Grid2Pos(self.x,self.y)
    self.sp:setPosition(posx,posy)
end


return Body

