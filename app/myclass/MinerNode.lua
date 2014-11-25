--矿工类
local Miner = class("Miner", function()
	return display.newNode()
end)

function Miner:ctor()
	self:init()
end

function Miner:init()
	display.addSpriteFramesWithFile("miner/minerAction.plist", "miner/minerAction.png")
	self._miner = display.newSprite("#miner_0701.png")
	self:addChild(self._miner, 0)
	self:setContentSize(self._miner:getContentSize())
end

function Miner:startAction()
	local frames = display.newFrames("miner_0%d.png", 701, 10)
	local animation = display.newAnimation(frames, 0.3)
	self._miner:playAnimationForever(animation, 0)
end

function Miner:stopAction()
	self._miner:stopAllActions()
end

return Miner