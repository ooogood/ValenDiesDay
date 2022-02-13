
RuleScene = {}
RuleScene.__index = RuleScene 

function RuleScene:Init()	
	local _rulescene = {
	}

	setmetatable(_rulescene, RuleScene)
	return _rulescene 
end

function RuleScene:ShowText()
	local size = Display()
	local storyText = {
		"Rules:",
		"Hold the LOVE together and ",
		"hide it in the hole.",
		"",
		"Don't get caught by zombies!",
		"",
		"Player1 Control:",
		"  Up, Down, Left, Right",
		"",
		"Player2 Control:",
		"  W, S, A, D",
		"",
		"press enter to start...",
	}
	for i = 1, #storyText do
		DrawText(storyText[ i ], size.x / 16, size.y * i / 16, DrawMode.Sprite, "large", 15 )
	end

	-- local hintText = "press enter to start"
	-- DrawText(hintText, size.x/2 - (string.len(hintText) / 2 ) * 8
	--                      , size.y/2 + 4 * 8, DrawMode.Sprite, "small", 15 )
end

function RuleScene:Update(timeDelta)
	if(Key(Keys.Enter, InputState.Released)) then
		SwitchScene(GAME)
	end
end

function RuleScene:Draw()
	RedrawDisplay()
	self:ShowText()
end

function RuleScene:Reset()
	--pass
end