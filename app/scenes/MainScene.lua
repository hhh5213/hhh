--主场景
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    local startNode = StartNode.new()
    self:addChild(startNode)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
