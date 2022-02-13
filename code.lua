LoadScript("scene-over")
LoadScript("scene-welcome")
LoadScript("scene-game")
LoadScript("scene-intro")
LoadScript("scene-rule")

local scenes = nil
local activeScene = nil
local activeSceneId = 0

-- define scenes
WELCOME, INTRO, RULE, GAME, OVER = 1, 2, 3, 4, 5
-- define canvas size
CANVASX_MIN = 0
CANVASX_MAX = Display().X
CANVASY_MIN = 0
CANVASY_MAX = Display().Y

function Init()
  scenes = {
    WelcomeScene:Init(),
    IntroScene:Init(),
    RuleScene:Init(),
    GameScene:Init(),
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

  if (activeSceneId == GAME) then
    PlaySong(0, false, 1)
  end

  if ( activeSceneId == OVER ) then
    scenes[OVER]:SetTotalScore(scenes[GAME]:GetTotalScore())
    StopSong()
    PlaySong(1, false, 0)
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
