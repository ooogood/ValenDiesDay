LoadScript("entity-zombie")

GameScene = {}
GameScene.__index = GameScene

local gameLvUpdateDelay = 20000 -- unit: ms

function GameScene:Init()	
	local _gamescene = {
		totalScore = 0,
		gameLV = 1,
		lvTimer = 0, -- unit: ms
	}

	setmetatable(_gamescene, GameScene)
	return _gamescene 
end

function GameScene:GetTotalScore()
	return self.totalScore
end

function GameScene:AddEntity(entity)
	table.insert(self.entities, entity)
	self.totalEntities = #self.entities
end

function GameScene:RemoveEntity(entity)
	for i = 1, self.totalEntities do
		if self.entities[ i ] == entity then
			table.remove( self.entities, i )
			break
		end
	end
	self.totalEntities = #self.entities
end

function GameScene:AddEnemy()
	local direction = math.random( 4 )
	local xpos = 0
	local ypos = 0
	local fH = false

	if( direction == 1 ) then
		xpos = math.random( 0, 1 ) * Display().x
		ypos = Display().y
	elseif( direction == 2 ) then
		xpos = math.random( 0, 1 ) * Display().x 
	elseif( direction == 3 ) then
		xpos = Display().x
		ypos = math.random( 0, 1) * Display().y 
		fH = true
	else
		ypos = math.random( 0, 1 ) * Display().y 
	end
	
	enemy = Zombie:Init( xpos, ypos, fH, false, direction )
	-- table.add( self.entities, enemy )
	self.totalEntities = #self.entities
end

-- generate zombies according to game level
function GameScene:GenerateEnemy()
	if (math.random(0, 100) < self.gameLV * 20 ) then
    	-- DrawRect( 16, 16, 8, 8, 14, DrawMode.Sprite )
		self.AddEnemy()
    end
end

function GameScene:Update(timeDelta)
	-- update game level according to timer
	self.lvTimer = self.lvTimer + timeDelta
	if( self.lvTimer > gameLvUpdateDelay ) then
		self.gameLV = self.gameLV + 1
		self.lvTimer = 0
	end
	-- generate enemies according to game level
	self:GenerateEnemy()
	-- remove out of bound enemies
	-- todo

	-- update eneities
	for i = 1, self.totalEntities do 
		self.entities[ i ]:Update(timeDelta)
	end
end

function GameScene:Draw()
	RedrawDisplay()
	for i = 1, self.totalEntities do 
		self.entities[ i ]:Update(timeDelta)
	end
end

function GameScene:Reset()
	RedrawDisplay()
	self.totalScore = 0
	self.entities = {}	
	self.totalEntities = 0
	self.gameLV = 1
	self.lvTimer = 0
end
