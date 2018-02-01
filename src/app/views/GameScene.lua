--
-- Created by IntelliJ IDEA.
-- User: rdcchina
-- Date: 2018/1/16
-- Time: 下午3:21
-- To change this template use File | Settings | File Templates.
--
local cGridSize = 33
local scaleRate = 1/display.contentScaleFactor

cc.exports.Grid2Pos = function(x,y)
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()

    local finalX = origin.x + visibleSize.width/2 + x * cGridSize * scaleRate
    local finalY = origin.y + visibleSize.height/2 + y * cGridSize * scaleRate

    return finalX, finalY
end

local size = cc.Director:getInstance():getVisibleSize()


local Snake = require "app.Snake"
local Fence = require "app.Fence"
local Food = require "app.Food"
local score = 0
local cMoveSpeed = 0.3
local round = 7

local GameScene = class("GameScene",function()
    return cc.Scene:create()
end)

function GameScene:ctor()
    local function onNodeEvent(event)
        if event == 'enter' then
            self:onEnter()
        end
    end
    self:registerScriptHandler(onNodeEvent)
end
function GameScene:onEnter()

    self.state = 'running'

    self.Fence = Fence.new(self,round)

    self.Snake = Snake.new(self)
    self.Food = Food.new(self,round-1)
    self:ProcessInput()
    self:initScore()
    cc.exports.tick = function()
        if self.state == 'running' then
            self.Snake:Update()
            if GameScene:eat(self.Snake,self.Food) then
                self.Snake:Grow()
                self.Food:Update()
                self:setScore()
                --            GameScene:setScore()
            end
        end
        if self.Snake:HitSelf() or self.Snake:HitFence(round) then
            self.state = 'dead'
            self.Snake:Blink(function()
                self:Reset()
--                cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedule)
            end)
        end
    end
    local schedule = cc.Director:getInstance():getScheduler():scheduleScriptFunc(tick,cMoveSpeed,false)

end

function GameScene.create()
    local scene = GameScene.new()
    return scene
end

function GameScene:eat(snake,food)
    local snakeArr = snake.BodyArr
    local snakeHead = snakeArr[1]
    local headX,headY = snakeHead.x,snakeHead.y

    local foodX,foodY = food.posX,food.posY

    if headX == foodX and headY == foodY then
        return true
    end
    return false
end

local function vector2Dir(x,y)
    if math.abs(x) > math.abs(y) then
        if x<0 then
            return 'left'
        else
            return 'right'
        end
    else
        if y<0 then
            return 'down'
        else
            return 'up'
        end
    end
end

function GameScene:ProcessInput()

    local function onTouchBegan(touch , event)
        local location = touch:getLocation()
        local visibleSize = cc.Director:getInstance():getVisibleSize()
        local origin = cc.Director:getInstance():getVisibleOrigin()
        local finalX = location.x - (origin.x + visibleSize.width/2)
        local finalY = location.y - (origin.y + visibleSize.height/2)

        local dir = vector2Dir(finalX,finalY)
        self.Snake:SetDir(dir)
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self)
end

function GameScene:initScore()
    local sp = cc.Sprite:create("food.jpeg")
    self:addChild(sp)
    sp:setPosition(Grid2Pos(12,6))

    self.label = cc.Label:createWithSystemFont(score,'Arial',66)
    self.label:setPosition(Grid2Pos(12,4))
    self:addChild(self.label)

end
function GameScene:setScore()
    score = score + 1
    self.label:setString(string.format("%d",score))
end

function GameScene:Reset()
    if self.Snake ~= nil then
        self.Snake:Kill()
    end

    if self.Food ~= nil then
        self.Food:Reset()
    end

    self.Snake = Snake.new(self)
    self.Food = Food.new(self,round-1)

    self.state = 'running'
end

return GameScene