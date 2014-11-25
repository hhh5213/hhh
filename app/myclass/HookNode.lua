--钩子
local Hook = class("Hook", function()
	return display.newNode()
end)

function Hook:ctor(params)
	self._funcL = params.funcL   --钩子发射回调
	self._funcBB = params.funcBB --钩子回收开始调用
	self._funcBE = params.funcBE --钩子回收结束调用
	self:init()
end

function Hook:init()
	self._hook = display.newSprite("myClass/hook.png")
    self._hook:setAnchorPoint(ccp(0.5, 1))
    self:addChild(self._hook, 0)
end

--延时
function delay(object, time, func)
	if not object then
		print("object is nil value")
	end

	local delayTime = CCDelayTime:create(time)
	local callFunc = CCCallFuncN:create(func)
	local sequence = CCSequence:createWithTwoActions(delayTime, callFunc)

	object:runAction(sequence)
end

--动作序列
function getSequence(tb)
	local array = CCArray:create()
	for k,v in pairs(tb) do
		array:addObject(v)
	end
	local sequence = CCSequence:create(array)
	return sequence
end

--钩子旋转
function Hook:startRotation()
	self:setRotation(-90)
	self._launchFlag = false
	local sequence = getSequence({CCRotateBy:create(2, 180), CCRotateBy:create(2, -180)})
	local repeatForever = CCRepeatForever:create(sequence)
	self:runAction(repeatForever)
end

--钩子发射
function Hook:hookLaunch()
	self:stopAllActions()
	self._launchFlag = true
	local angle = self:getRotation()
	local moveBy = CCMoveBy:create(2, ccp(500 * math.sin(math.rad(-angle)), -500 * math.cos(math.rad(-angle))))
    self:runAction(moveBy)

    delay(self, 1, function()
        self:hookBack()
    end)
    
    if self._funcL then
    	(self._funcL)()
    end

    self._hook:setAnchorPoint(ccp(0.5, 0))
end

--钩子返回
function Hook:hookBack()
	self:stopAllActions()
	local time = 2
	if self._goods then
		time = self._goods._weight / 10 + 2
	end

	local moveTo = CCMoveTo:create(time, ccp(display.cx - 2, display.cy - 15))
	local sequence = getSequence({moveTo, CCCallFunc:create(function()
		self._hook:setAnchorPoint(ccp(0.5, 1))
		self:startRotation()
		if self._funcBE then
			(self._funcBE)(self._goods)
		end
		self._goods = nil
	end)})

	self:runAction(sequence)

	if self._funcBB then
		(self._funcBB)(self._goods)
	end
     
end

--设置钩子捕获到的矿物
function Hook:setGoods(goods)
	self._goods = goods
end

--过去钩子的长度
function Hook:getHookLength()
	return self._hook:getContentSize().height
end

return Hook