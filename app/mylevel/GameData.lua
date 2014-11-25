--游戏数据

module("GameData", package.seeall)

local score = 0
local level = 1

function setScore(num)
	score = num
end

function getScore()
	return score
end

function setLevel(num)
	level = num
end

function getLevel()
	return level
end