
OverScene = {}
OverScene.__index = OverScene

function OverScene:Init()	
	local _overscene = {
		finalScore = 0,
	}

	setmetatable(_overscene, OverScene)
	return _overscene 
end

function OverScene:SetTotalScore(score) 
	self.finalScore = score
end

function OverScene:ShowText()
	local size = Display()
	-- Draw the two sizes to the display
	-- assume: one character = 8 pixels
	local gameOverText = "Game Over"
	DrawText(gameOverText, size.x/2 - (string.len(gameOverText) / 2 ) * 8
	                     , size.y/2 - 4 * 8, DrawMode.Sprite, "large", 15 )

	local finalScoreText = string.format("Total love: %d", self.finalScore)
	DrawText(finalScoreText, size.x/2 - (string.len(finalScoreText) / 2 ) * 8
	                     , size.y/2 - 2 * 8, DrawMode.Sprite, "large", 15 )
						 
	local hintText = "press enter to continue"
	DrawText(hintText, size.x/2 - (string.len(hintText) / 2 ) * 8
	                     , size.y/2 + 4 * 8, DrawMode.Sprite, "small", 15 )
end

function OverScene:Update(timeDelta)
	if(Key(Keys.Enter, InputState.Released)) then
		SwitchScene(WELCOME)
	end
end

function OverScene:Draw()
	RedrawDisplay()
	self:ShowText()
end

function OverScene:Reset()
	self.finalScore = 0
end
