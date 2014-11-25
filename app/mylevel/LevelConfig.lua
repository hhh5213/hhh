--关卡配置
module("LevelConfig", package.seeall) -- module 模块机制，将公共的代码放在模块中

--获取对应关卡的过关成绩
function getLeast_Score(config)
	local score = LEAST_SCORE[config]
	if not score then
		score = LEAST_SCORE[1]
	end
	return score
end

--获取对应关卡的背景图片
function getBG_IMAGE(config)
	local bgImage = BG_IMAGE[config]
	if not bgImage then
		bgImage = BG_IMAGE[1]
	end
	return bgImage
end

--获取对应关卡的矿物
function getItem(config)
	local item = ITEM[config]
	if not item then
		item = ITEM[1]
	end
	return item
end

--通关条件
LEAST_SCORE = {300, 800, 1300, 1700, 2200, 2800}

--关卡背景
BG_IMAGE = {
	"bgImage/mineBG1.png",
	"bgImage/mineBG2.png",
	"bgImage/mineBG3.png",
	"bgImage/mineBG4.png",
	"bgImage/mineBG5.png",
	"bgImage/mineBG6.png"
}

--矿物图片
local pic_path_tab = {
	"goods/gold_large.png",
	"goods/gold_middle.png",
	"goods/gold_small.png",
	"goods/stone_large.png",
	"goods/stone_middle.png",
	"goods/stone_small.png",
	"goods/diamond_large.png",
	"goods/diamond_middle.png",
	"goods/diamond_small.png",
	"goods/secret_large.png",
	"goods/secret_middle.png",
	"goods/secret_small.png"
}

--矿物分布及类型
ITEM = {}

ITEM[1] = {}
ITEM[1][1] = {pic = pic_path_tab[1], pos = ccp(15, 30), weight = 50, price = 300}
ITEM[1][2] = {pic = pic_path_tab[2], pos = ccp(40, 70), weight = 20, price = 100}
ITEM[1][4] = {pic = pic_path_tab[3], pos = ccp(100, 60), weight = 10, price = 50}
ITEM[1][5] = {pic = pic_path_tab[3], pos = ccp(300, 30), weight = 10, price = 50}
ITEM[1][6] = {pic = pic_path_tab[3], pos = ccp(300, 100), weight = 10, price = 50}
ITEM[1][7] = {pic = pic_path_tab[4], pos = ccp(370, 40), weight = 30, price = 50}
ITEM[1][8] = {pic = pic_path_tab[5], pos = ccp(240, 100), weight = 20, price = 30}
ITEM[1][9] = {pic = pic_path_tab[6], pos = ccp(160, 80), weight = 5, price = 15}
ITEM[1][10] = {pic = pic_path_tab[6], pos = ccp(420, 20), weight = 5, price = 15}

ITEM[2] = {}
ITEM[2][1] = {pic = pic_path_tab[1], pos = ccp(30, 140), weight = 50, price = 300}
ITEM[2][2] = {pic = pic_path_tab[1], pos = ccp(240, 50), weight = 50, price = 300}
ITEM[2][3] = {pic = pic_path_tab[2], pos = ccp(100, 70), weight = 20, price = 100}
ITEM[2][4] = {pic = pic_path_tab[2], pos = ccp(300, 70), weight = 20, price = 100}
ITEM[2][5] = {pic = pic_path_tab[3], pos = ccp(180, 120), weight = 10, price = 50}
ITEM[2][6] = {pic = pic_path_tab[3], pos = ccp(420, 70), weight = 10, price = 50}
ITEM[2][7] = {pic = pic_path_tab[4], pos = ccp(30, 30), weight = 30, price = 50}
ITEM[2][8] = {pic = pic_path_tab[4], pos = ccp(240, 100), weight = 30, price = 50}
ITEM[2][9] = {pic = pic_path_tab[5], pos = ccp(160, 40), weight = 20, price = 30}
ITEM[2][10] = {pic = pic_path_tab[6], pos = ccp(250, 110), weight = 5, price = 15}
ITEM[2][11] = {pic = pic_path_tab[6], pos = ccp(350, 70), weight = 5, price = 15}