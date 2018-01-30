
local MainScene = class("MainScene", cc.load("mvc").ViewBase)


local size = cc.Director:getInstance():getWinSize()

function MainScene:onCreate()


    local layer = cc.Layer:create()
    local sprite = cc.Sprite:create("bg.jpeg")
    sprite:setPosition(cc.p(size.width/2,size.height/2))
    sprite:setScale(2)
    layer:addChild(sprite)

    cc.MenuItemFont:setFontName("Times New Roman")
    cc.MenuItemFont:setFontSize(86)

    local item1 = cc.MenuItemFont:create("Start")
    local function menuItem1Callback(sender)
        local scene = require("app.views.GameScene")
        local gameScene = scene.create()
        if cc.Director:getInstance():getRunningScene() then
            cc.Director:getInstance():replaceScene(gameScene)
        else
            cc.Director:getInstance():runWithScene(gameScene)
        end
    end
    item1:registerScriptTapHandler(menuItem1Callback)

    local menu = cc.Menu:create(item1)
    menu:alignItemsVertically()
    layer:addChild(menu)

    -- add background image
--    display.newSprite("bg.jpeg")
--        :move(display.center)
--        :setScale(3)
--        :addTo(self)

--    local sp = display.newSprite("btn_start.png",display.cx+100,display.cy)
--    self:addChild( sp )
--    local a = cc.ScaleTo:create(2.0,2)
--    sp:runAction(a)

    self:addChild(layer)

end

function  MainScene:onEnter()
    print('enter')

end

return MainScene
