
GameScene = {}
GameScene.__index = GameScene

function GameScene:Init()	
	local _gamescene = {
		totalScore = 0,
	}

	setmetatable(_gamescene, GameScene)
	return _gamescene 
end

function GameScene:GetTotalScore()
	return self.totalScore
end

local record = 0
function GameScene:Update(timeDelta)
	record += timeDelta
	if( record > 1000 ) then
		self.totalScore = self.totalScore + 1
		record = 0
	end

	if(Key(Keys.Enter, InputState.Released)) then
		SwitchScene(OVER)
	end
end

function GameScene:Draw()
	--pass
	RedrawDisplay()
	local size = Display()
	local finalScoreText = string.format("Total love: %d", self.totalScore)
	DrawText(finalScoreText, size.x/2 - (string.len(finalScoreText) / 2 ) * 8
	                     , size.y/2 - 2 * 8, DrawMode.Sprite, "large", 15 )
end

function GameScene:Reset()
	RedrawDisplay()
	self.totalScore = 0
	self.entities = {}	
	self.totalEntities = 0
end
