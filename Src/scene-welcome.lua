
WelcomeScene = {}
WelcomeScene.__index = WelcomeScene 

function WelcomeScene:Init()	
	local _welcomescene = {
	}

	setmetatable(_welcomescene, WelcomeScene)
	return _welcomescene 
end

function WelcomeScene:ShowText()
	local size = Display()
	-- Draw the two sizes to the display
	-- assume: one character = 8 pixels
	local TitleText = "ValenDiesDay"
	DrawText(TitleText, size.x/2 - (string.len(TitleText) / 2 ) * 8
	                     , size.y/2 - 4 * 8, DrawMode.Sprite, "large", 15 )

	local hintText = "press enter to start"
	DrawText(hintText, size.x/2 - (string.len(hintText) / 2 ) * 8
	                     , size.y/2 + 4 * 8, DrawMode.Sprite, "small", 15 )
end

function WelcomeScene:Update(timeDelta)
	if(Key(Keys.Enter, InputState.Released)) then
		-- SwitchScene(GAME)
		SwitchScene(OVER)
	end
end

function WelcomeScene:Draw()
	--pass
end

function WelcomeScene:Reset()
	Clear()
	self:ShowText()
end