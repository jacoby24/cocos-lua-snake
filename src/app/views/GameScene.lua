--
-- Created by IntelliJ IDEA.
-- User: rdcchina
-- Date: 2018/1/16
-- Time: 下午3:21
-- To change this template use File | Settings | File Templates.
--
local Snake = require "app.Snake"
local Food = require "app.Food"

local GameScene = class("GameScene",function()
    return cc.Scene:create()
end)

function GameScene:ctor()
    print('game scene ')
    local function onNodeEvent(event)
        if event == 'enter' then
            self:onEnter()
        end
    end
    self:registerScriptHandler(onNodeEvent)
end
function GameScene:onEnter()
    print("Game start")
    local cMoveSpeed = 0.3
    self.Snake = Snake.new(self)
    self.Food = Food.new(self)

    self:ProcessInput()

    cc.exports.tick = function()
        self.Snake:Update()
    end

    cc.Director:getInstance():getScheduler():scheduleScriptFunc(tick,cMoveSpeed,false)
end

function GameScene.create()
    local scene = GameScene.new()
--    scene:addChild(scene:createLayer())
    return scene
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

function GameScene:addKeyboard()

    --注册键盘事件：上下左右控制蛇的方向
    local function onKeyPressed(keyCode,event)
        print("down")
        if keyCode == 37 then
            --left
        elseif keyCode ==38 then
            --up
        elseif keyCode ==39 then
            --right
        elseif keyCode ==40 then
            --down
        end
    end

    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(onKeyPressed,cc.Handler.EVENT_KEYBOARD_PRESSED)
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self)

end

return GameScene