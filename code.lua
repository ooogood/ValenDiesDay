LoadScript("scene-over")
LoadScript("scene-welcome")

local scenes = nil
local activeScene = nil
local activeSceneId = 0

-- define scenes
WELCOME, GAME, OVER = 1, 2, 2

function Init()
  scenes = {
    WelcomeScene:Init(),
    -- GameScene:Init(),
    OverScene:Init(),
  }
  activeScene = scenes[ 1 ]
  SwitchScene( WELCOME )
end

-- We use this function to prepare a new scene and run through all of the steps required to make sure the new scene is correctly reset and ready to go.
function SwitchScene(id)

  activeSceneId = id
  activeScene = scenes[activeSceneId]
  activeScene:Reset()

  if ( activeSceneId == OVER ) then
    -- scenes[OVER]:SetTotalScore(scenes[GAME]:GetTotalScore())
  end
end

--[[
  The Update() method is part of the game's life cycle. The engine calls
  Update() on every frame before the Draw() method. It accepts one argument,
  timeDelta, which is the difference in milliseconds since the last frame.
]]--
function Update(timeDelta)
  if(activeScene ~= nil) then
    -- Call the active scene's `Update()` function.
    activeScene:Update(timeDelta)
  end  
end

--[[
  The Draw() method is part of the game's life cycle. It is called after
  Update() and is where all of our draw calls should go. We'll be using this
  to render sprites to the display.
]]--
function Draw()
  if(activeScene ~= nil) then
    -- Call the active scene's `Draw()` function.
    activeScene:Draw()
  end
end
