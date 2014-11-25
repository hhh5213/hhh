--游戏结束
local GameOverScene = class("GameOverScene", function()
	return display.newScene("GameOverScene")
end)

function GameOverScene:ctor()
	--显示游戏结束
    local label = CCLabelTTF:create("Game Over", "Zapfino", 50)
    label:setPosition(ccp(display.cx,display.cy))
    self:addChild(label, 0)

    --发射粒子
    local particleQuad = CCParticleSystemQuad:create("myClass/fengye.plist")
    particleQuad:setPosition(ccp(display.cx, display.cy))
    particleQuad:setBlendAdditive(true)
    particleQuad:setAutoRemoveOnFinish(true)
    self:addChild(particleQuad, 0)

    --重玩按钮
    local rePlayBtn = cc.ui.UIPushButton.new({normal = "myClass/againPlay1.png"}, {scale9 = true})
    rePlayBtn:setPosition(ccp(display.width - 30, 20))
    self:addChild(rePlayBtn, 0)

    rePlayBtn:onButtonClicked(function()
    	CCDirector:sharedDirector():replaceScene(MainScene.new())
    end)
end

return GameOverScene