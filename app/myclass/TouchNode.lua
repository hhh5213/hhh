-- 触摸层

local TouchLayer = class("TouchLayer", function()
	return display.newNode()
end)

function TouchLayer:ctor(params)
	self._func = params.func
	self:init()
end

function TouchLayer:init()
	local colorLayer = display.newColorLayer(ccc4(23, 222, 21, 0))
	self:addChild(colorLayer, 0)

	--触摸事件
	colorLayer:setTouchSwallowEnabled(true)
	colorLayer:setTouchEnabled(true)
	colorLayer:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)
	colorLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
		if event.name == "began" then
			return true
		elseif event.name == "moved" then
			
		elseif event.name == "ended" then
		    --点击回调函数
		    if self._func then
		        (self._func)()
		    end
		    return true
		end
		return false
	end)
end

return TouchLayer