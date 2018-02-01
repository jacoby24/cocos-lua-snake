--
-- Created by IntelliJ IDEA.
-- User: rdcchina
-- Date: 2018/1/30
-- Time: 下午6:02
-- To change this template use File | Settings | File Templates.
--
local Food = class('Food')

function Food:ctor(node,r)
    self.node = node
    self.round = r
    
    self.sp = cc.Sprite:create("food.jpeg")
    self.node:addChild(self.sp)
    self:Update()
end

cc.exports.gernerateRandom = function(r)
    math.randomseed(os.time())
    return math.random(-r,r)
end

function Food:Update()

    local x,y = gernerateRandom(self.round),gernerateRandom(self.round)
    local finalX,finalY = Grid2Pos(x,y)

    self.sp:setPosition(finalX,finalY)
    self:Blink()

    self.posX,self.posY = x,y
end
function Food:Blink()
    local blink = cc.Blink:create(2,3)
    self.sp:runAction(blink)
end

function Food:Reset()
    self.node:removeChild(self.sp)
end

return Food