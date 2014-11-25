local ShopAssistant = class("ShopAssistant", function()
	return display.newNode()
end)

function ShopAssistant:ctor()
	self:init()
end

function ShopAssistant:init()
	display.addSpriteFramesWithFile("shop/shop_npc.plist", "shop/shop_npc.png")
	--CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile("shop/shop_npc.plist") --两种方法均可
	self._shopAssistant = display.newSprite("#npc_2007.png")
	self:addChild(self._shopAssistant, 0)
	self:setContentSize(self._shopAssistant:getContentSize())
end

function ShopAssistant:unHappyAction()
	self._shopAssistant:stopAllActions()
	local frames = display.newFrames("npc_%d.png", 1001, 10)
	local animation = display.newAnimation(frames, 0.2)
	self._shopAssistant:playAnimationForever(animation, 0)
end

function ShopAssistant:smileAction()
	self._shopAssistant:stopAllActions()
	local frames = display.newFrames("npc_%d.png", 2002, 9)
	local animation = display.newAnimation(frames, 0.2)
	self._shopAssistant:playAnimationForever(animation, 0)
end

function ShopAssistant:kissAction()
	self._shopAssistant:stopAllActions()
	local frames = display.newFrames("npc_%d.png", 3002, 9)
	local animation = display.newAnimation(frames, 0.2)
	self._shopAssistant:playAnimationForever(animation, 0)
end

return ShopAssistant