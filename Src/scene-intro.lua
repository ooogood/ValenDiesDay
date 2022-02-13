
IntroScene = {}
IntroScene.__index = IntroScene 

function IntroScene:Init()	
	local _introscene = {
	}

	setmetatable(_introscene, IntroScene)
	return _introscene 
end

function IntroScene:ShowText()
	local size = Display()
	local storyText = {
		"You are a pair of bride and ",
		"groom who have done every ",
		"evil things while alive.",
		"",
		"Now you are stuck in hell.",
		"",
		"Collecting LOVE is your only ",
		"path to salvation.",
		"",
		"You two shall hold the LOVE",
		"together to collect it.",
		"",
		"press enter...",
	}
	for i = 1, #storyText do
		DrawText(storyText[ i ], size.x / 16, size.y * i / 16, DrawMode.Sprite, "large", 15 )
	end

	-- local hintText = "press enter to start"
	-- DrawText(hintText, size.x/2 - (string.len(hintText) / 2 ) * 8
	--                      , size.y/2 + 4 * 8, DrawMode.Sprite, "small", 15 )
end

function IntroScene:Update(timeDelta)
	if(Key(Keys.Enter, InputState.Released)) then
		SwitchScene(RULE)
	end
end

function IntroScene:Draw()
	RedrawDisplay()
	self:ShowText()
end

function IntroScene:Reset()
	--pass
end