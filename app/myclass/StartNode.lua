-- 开始界面
local StartNode = class("StartNode", function ()
	return display.newNode()
end)

function StartNode:ctor()
    --背景
    local bgSprite = display.newSprite("myClass/MainMenu.png")
    bgSprite:setScaleX(display.width / bgSprite:getContentSize().width)
    bgSprite:setScaleY(display.height / bgSprite:getContentSize().height)
    bgSprite:setPosition(ccp(display.cx, display.cy))
    self:addChild(bgSprite, -1)

    --开始按钮
    local startBtn = cc.ui.UIPushButton.new({normal = "myClass/button/PlayMenu.png"}, {scale9 = true})
    startBtn:setPosition(ccp(display.cx - 110, display.cy + 65))
    self:addChild(startBtn, 0)

    startBtn:onButtonClicked(function (event)
    	local gameScene = GameScene.new()
    	CCDirector:sharedDirector():replaceScene(gameScene)
    end)

    --音乐开关按钮
    local musicBtn = cc.ui.UICheckBoxButton.new({on = "myClass/button/soundController.png", off = "myClass/button/soundController2.png"})
    musicBtn:setPosition(ccp(30, 30))
    musicBtn:onButtonStateChanged(function (event)
    	if event.state == "on" then
    		audio.playMusic("myClass/backMusic.mp3", true)
    	elseif event.state == "off" then
    		audio.stopMusic(true)
    	end
    end)
    musicBtn:setButtonSelected(true)
    self:addChild(musicBtn)
end

return StartNode