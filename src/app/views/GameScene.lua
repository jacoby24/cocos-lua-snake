--
-- Created by IntelliJ IDEA.
-- User: rdcchina
-- Date: 2018/1/16
-- Time: 下午3:21
-- To change this template use File | Settings | File Templates.
--
local Snake = require "app.Snake"

local GameScene = class("GameScene", cc.load("mvc").ViewBase)

--function init()
--
--end


function GameScene:onEnter()
    print("Game start")
    local cMoveSpeed = 0.3
    self.Snake = Snake.new(self)

    cc.exports.tick = function()
        self.Snake:Update()
    end

    cc.Director:getInstance():getScheduler():scheduleScriptFunc(tick,cMoveSpeed,false)
end

return GameScene