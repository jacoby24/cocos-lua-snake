--
-- Created by IntelliJ IDEA.
-- User: rdcchina
-- Date: 2018/1/25
-- Time: 下午6:03
-- To change this template use File | Settings | File Templates.
--
local Snake = class("Snake")
local Body = require "app.Body"

local cInitLen = 3

function Snake:ctor(node)
    self.BodyArr = {}
    self.node = node
    self:SetDir('left')


    for i=1,cInitLen do
        print("Grow",i)
        self:Grow()
    end
    
end

function Snake:GetTailGrid()
   if #self.BodyArr == 0 then
        return 0,0
   end
   local tail = self.BodyArr[#self.BodyArr]
    return tail.x, tail.y
end

function Snake:Grow()
    local tailX,tailY = self:GetTailGrid()
    local body = Body.new(self, tailX, tailY, self.node)
    table.insert(self.BodyArr, body)
end

local function offsetGridByDir(x, y, dir)
    if dir == 'left' then
        return x - 1, y
    elseif dir == 'right' then
        return x + 1, y
    elseif dir == 'up' then
        return x, y + 1
    elseif dir == 'down' then
        return x, y - 1
    end

    print('error something')
end

function Snake:SetDir(dir)
    if self.MoveDir == 'left' and dir =='right'  then
        return
    elseif self.MoveDir == 'right' and dir =='left'  then
        return
    elseif self.MoveDir == 'up' and dir =='down'  then
        return
    elseif self.MoveDir == 'dowm' and dir =='up'  then
        return
    else
        self.MoveDir =  dir
    end
end

function Snake:Update()
    if #self.BodyArr == 0 then
        return
    end

    for i = #self.BodyArr, 1, -1 do
        local body = self.BodyArr[i]

        if i == 1 then
            body.x , body.y = offsetGridByDir(body.x,body.y,self.MoveDir)
        else
            local front = self.BodyArr[i-1]
            body.x,body.y = front.x,front.y
        end
        body:Update()
    end
end



return Snake

