
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()
    -- add background image
    display.newSprite("bg.jpeg")
        :move(display.center)
        :setScale(3)
        :addTo(self)

    local sp = display.newSprite("btn_start.png",display.cx+100,display.cy)


    self:addChild( sp )
   
    local a = cc.ScaleTo:create(2.0,2)
    sp:runAction(a)
end

function  MainScene:onEnter()
    print('enter')

    cc.ui.UIPushButton.new({normal = "btn_start.png",pressed = "btn_start.png"})
    :setPosition(200,200)
    :addTo(self)

    sp:addNodeEventListener("click",function()
        print('click')
    end)

end

return MainScene
