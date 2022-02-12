LoadScript("entity-zombie")
LoadScript("entity-heart")

GameScene = {}
GameScene.__index = GameScene

local gameLvUpdateDelay = 20000 -- unit: ms

function GameScene:Init()	
	local _gamescene = {
		totalScore = 0,
		gameLV = 1,
		lvTimer = 0, -- unit: ms
		heart = nil,
	}

	setmetatable(_gamescene, GameScene)
	return _gamescene 
end

function GameScene:GetTotalScore()
	return self.totalScore
end

function GameScene:AddEntity(entity)
	table.insert( self.entities, entity )
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
		xpos = math.random() * Display().x
		ypos = Display().y
	elseif( direction == 2 ) then
		xpos = math.random() * Display().x 
	elseif( direction == 3 ) then
		xpos = Display().x
		ypos = math.random() * Display().y 
		fH = true
	else
		ypos = math.random() * Display().y 
	end
	
	enemy = Zombie:Init( xpos, ypos, fH, false, direction )
	self:AddEntity( enemy )
end

-- generate zombies according to game level
function GameScene:GenerateEnemy()
	if (math.random(0, 100) < self.gameLV * 20 ) then
		self:AddEnemy()
    end
end

-- generate heart
function GameScene:GenerateHeart()
	if( self.heart == nil ) then
		self.heart = Heart:Init()
		self:AddEntity( self.heart )
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
	for i = 1, self.totalEntities - 10 do
		if self.entities[i].outBound == true then
			table.remove(self.entities, i)
			self.totalEntities = #self.entities
		end
	end

	-- check heart and score
	if( self.heart ~= nil and self.heart.goal == true ) then
		self.totalScore = self.totalScore + 1
		self.heart = nil
	end
	self:GenerateHeart()

	-- update all eneities
	for i = 1, self.totalEntities do 
		self.entities[ i ]:Update(timeDelta)
	end
end

function GameScene:Draw()
	RedrawDisplay()
	for i = 1, self.totalEntities do 
		self.entities[ i ]:Draw()
	end
end

function GameScene:Reset()
	RedrawDisplay()
	self.heart = nil
	self.totalScore = 0
	self.entities = {}
	self.totalEntities = 0
	self.gameLV = 1
	self.lvTimer = 0
end
