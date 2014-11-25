--商店场景
local ShopScene = class("ShopScene", function()
	return display.newScene("ShopScene")
end)

function ShopScene:ctor()
	--背景
	local bg = display.newSprite("shop/shopBack.png")
	bg:setScaleX(display.width / bg:getContentSize().width)
	bg:setScaleY(display.height / bg:getContentSize().height)
	bg:setPosition(ccp(display.cx, display.cy))
	self:addChild(bg, -1)

    --添加售货员
    local shopAssistant = ShopAssistant.new()
    shopAssistant:setPosition(ccp(60, display.height / 3))
    self:addChild(shopAssistant, 0)
    shopAssistant:smileAction()
    

	--商品列表
	self._index = 1
	self._goods_tab = {
        {types = 1, texture = CCTextureCache:sharedTextureCache():addImage("shop/qianglishui.png")},
        {types = 2, texture = CCTextureCache:sharedTextureCache():addImage("shop/article_2001.png") }
    }

    --当前商品
    local goods = display.newSprite(self._goods_tab[self._index].texture)
    goods:setPosition(ccp(145, 100))
    self:addChild(goods, 0)

    --向左按钮
    local leftBtn = cc.ui.UIPushButton.new({normal = "shop/buyleftbtn.png"}, {scale9 = true})
    leftBtn:setPosition(ccp(90, 45))
    self:addChild(leftBtn, 0)

    leftBtn:onButtonClicked(function(event)
    	self._index = self._index + 1
    	if self._index > #self._goods_tab then
    		self._index = 1
    	end
    	goods:setTexture(self._goods_tab[self._index].texture)
    end)

    --购买按钮
    local buyBtn = cc.ui.UIPushButton.new({normal = "shop/buypowerbtn.png"}, {scale9 = true})
    buyBtn:setPosition(ccp(leftBtn:getPositionX() + 50, 45))
    self:addChild(buyBtn, 0)

    buyBtn:onButtonClicked(function(event)
        shopAssistant:kissAction() --当购买物品后，售货员会有相应动作
    end)

    --向右按钮
    local rightBtn = cc.ui.UIPushButton.new({normal = "shop/buyrightbtn.png"}, {scale9 = true})
    rightBtn:setPosition(ccp(buyBtn:getPositionX() + 50, 45))
    self:addChild(rightBtn, 0)

    rightBtn:onButtonClicked(function()
    	self._index = self._index - 1
    	if self._index < 1 then
    		self._index = #self._goods_tab
    	end
    	goods:setTexture(self._goods_tab[self._index].texture)
    end)

    --下一关按钮
    local nextLevelBtn = cc.ui.UIPushButton.new({normal = "shop/shopArrow.png"}, {scale9 = true})
    nextLevelBtn:setPosition(ccp(display.width - 70, 45))
    self:addChild(nextLevelBtn, 0)

    nextLevelBtn:onButtonClicked(function()
        GameData.setLevel(GameData.getLevel() + 1)
        local gameScene = GameScene.new()
        CCDirector:sharedDirector():replaceScene(gameScene)    
    end)
end

return ShopScene