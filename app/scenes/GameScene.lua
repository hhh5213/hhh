--游戏场景
require("app.myLevel.GameData")
require("app.myLevel.LevelConfig")

local GameScene = class("GameScene", function ()
	return display.newScene("GameScene")
end)

function GameScene:ctor()
	--获取当前关卡
	level = GameData.getLevel()

	--背景
	local bg = display.newSprite(LevelConfig.getBG_IMAGE(level))
	bg:setScaleX(display.width / bg:getContentSize().width)
	bg:setScaleY(display.height / bg:getContentSize().height)
	bg:setPosition(ccp(display.cx, display.cy))
	self:addChild(bg, -1)

	--分数 label
	local totalScoreLabel = ui.newTTFLabel({text = "目标分数：" .. LevelConfig.getLeast_Score(level), size = 18,})
	totalScoreLabel:setColor(ccc3(255, 50, 100)) 
	totalScoreLabel:setPosition(ccp(75, display.height - 25))
	self:addChild(totalScoreLabel, 0)
	        
	self._currentScoreLabel = ui.newTTFLabel({text = "当前得分：" .. GameData.getScore(), size = 18,})
    self._currentScoreLabel:setColor(ccc3(255, 50, 100)) 
	self._currentScoreLabel:setPosition(ccp(75, display.height - 55))
	self:addChild(self._currentScoreLabel, 0)

    --时间
    self._time = 60
    self._timeLabel = ui.newTTFLabel({text = "时间: " .. self._time, size = 18,})
    self._timeLabel:setColor(ccc3(200, 100, 50))
    self._timeLabel:setPosition(ccp(display.width - 40, display.height - 20))
    self:addChild(self._timeLabel, 0)

    --创建矿工
    local miner = Miner.new()
    miner:setPosition(ccp(display.cx, display.cy + 10))
    self:addChild(miner, 0)

    --创建矿物
    self._goods_tab = {}
    itemData = LevelConfig.getItem(level)
    for k,v in pairs(itemData) do
    	local goods = Goods.new({path = v.pic, weight = v.weight, price = v.price})
    	goods:setPosition(v.pos)
    	self:addChild(goods, 0)

    	table.insert(self._goods_tab, goods)
    end

    --创建钩子
    self._hook = Hook.new({
         funcL = function()
         	self:startCollisionCheck()
         	miner:startAction()
         end,
         funcBE = function(goods)
         	miner:stopAction()
         	if goods then
         		GameData.setScore(GameData.getScore() + goods._price)
         		self._currentScoreLabel:setString("当前得分：" ..GameData.getScore())
         	end
         end,
         funcBB = function(goods)
         	self:stopCollisionCheck()
         	local index = 0
         	for k,v in pairs(self._goods_tab) do
         		if v == goods then
         			index = k 
         			break
         		end
         	end
         	if index ~= 0 then
         		local time = 2
         		if goods then
         			time = goods._weight / 10 + 2
         		end
         		goods:runAction(getSequence({CCMoveTo:create(time, ccp(display.cx, display.cy - 10)), CCCallFuncN:create(function ( ... )
                goods:removeFromParentAndCleanup(true)   
         		end)}))

         		table.remove(self._goods_tab, index)
         	end
         end
    })
    self._hook:setPosition(ccp(display.cx - 2, display.cy - 15))
    self:addChild(self._hook, 0)

    self._hook:startRotation()


    --创建用于接收触摸的层
    local touchLayer = TouchLayer.new({func = function( ... )
    	if not self._hook._launchFlag then
    		self._hook:hookLaunch()
    	end
    end})

    self:addChild(touchLayer, 0)

    --计时器
    local sharedScheduler = CCDirector:sharedDirector():getScheduler()
    self._timeSchedule = sharedScheduler:scheduleScriptFunc(function( ... )
    	self:timeDeal()
    end, 1, false)

    -- 检测画线
    self._drawLineSchedule = sharedScheduler:scheduleScriptFunc(function()
    	self:drawLine()
    end, 0.01, false)

    self._lineTexture = CCTextureCache:sharedTextureCache():addImage("myClass/shengzi.png")
    self._line = cc.Sprite:createWithTexture(self._lineTexture, cc.RectMake(0, 0, 0, 3))
    self._line:setAnchorPoint(ccp(0, 0.5))
    self._line:setPosition(ccp(display.cx - 2, display.cy - 15))
    self:addChild(self._line, 0)
end

--画线
function GameScene:drawLine()
	local x = math.abs(self._hook:getPositionX() - (display.cx - 2))
    local y = math.abs(self._hook:getPositionY() - (display.cy - 15))
    local distance = math.sqrt(x * x + y * y)
    if distance < self._hook:getHookLength() then
    	distance = 0
    else
    	distance = distance - self._hook:getHookLength()
    end
    self._line:setTextureRect(cc.RectMake(0, 0, distance, 3))
    self._line:setRotation(self._hook:getRotation() + 90)
end

--开始碰撞检测
function GameScene:startCollisionCheck()
	local sharedScheduler = CCDirector:sharedDirector():getScheduler()
	self._collisionSchedule = sharedScheduler:scheduleScriptFunc(function()
		self:collisionDeal()
	end, 0.01, false)
end

--停止碰撞检测
function GameScene:stopCollisionCheck()
	local sharedScheduler = CCDirector:sharedDirector():getScheduler()
	if self._collisionSchedule then
	     sharedScheduler:unscheduleScriptEntry(self._collisionSchedule)
	     self._collisionSchedule = nil
	end
end

--碰撞检测
function GameScene:collisionDeal()
	local hookX = self._hook:getPositionX()
	local hookY = self._hook:getPositionY()

	for k,v in pairs(self._goods_tab) do
	    local x = v:getPositionX()
	    local y = v:getPositionY()

	    if math.abs(hookX - x) < v:getContentSize().width * 0.3 and math.abs(hookY - y) < v:getContentSize().height * 0.3 then
	    	self:stopCollisionCheck()
	    	self._hook:setGoods(v)
	    	self._hook:hookBack()
	    end
	end
end

--游戏倒计时
function GameScene:timeDeal()
	self._time = self._time - 1
	self._timeLabel:setString("时间：" ..self._time)
	if self._time <= 0 then
		self._time = 0
		local sharedScheduler = CCDirector:sharedDirector():getScheduler()
		if self._timeSchedule then
			sharedScheduler:unscheduleScriptEntry(self._timeSchedule)
			self._timeSchedule = nil
		end
		self:stopCollisionCheck()
		local scene = nil

		--是否通关
		if LevelConfig.getLeast_Score(level) <= GameData.getScore() then
			local sharedScheduler = CCDirector:sharedDirector():getScheduler()
			sharedScheduler:unscheduleScriptEntry(self._drawLineSchedule)
			self._drawLineSchedule = nil
            if GameData.getLevel() == 6 then --如果当前关卡为6，说明游戏结束
                scene = GameOverScene.new() 
                GameData.setLevel(1) 
            else
                scene = ShopScene.new() --否则进入店铺 
            end
		else
			local sharedScheduler = CCDirector:sharedDirector():getScheduler()
			sharedScheduler:unscheduleScriptEntry(self._drawLineSchedule)
			self._drawLineSchedule = nil
			GameData.setScore(0)
			scene = GameOverScene.new()
		end
		CCDirector:sharedDirector():replaceScene(scene)
	end
end

function GameScene:onEnter()
	
end

function GameScene:onExit()
	
end

return GameScene