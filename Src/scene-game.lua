LoadScript("entity-zombie")
LoadScript("entity-heart")
LoadScript("entity-player")

GameScene = {}
GameScene.__index = GameScene

-- remember to add player type!
TYPE_PLAYER, TYPE_ZOMBIE, TYPE_HEART = 1, 2, 3

local difficulty = 2
local gameLvUpdateDelay = 20000 -- unit: ms

function GameScene:Init()	
	local _gamescene = {
		totalScore = 0,
		gameLV = 1,
		lvTimer = 0, -- unit: ms
		heart = nil,
		player1 = nil,
		player2 = nil,
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

function GameScene:AddEnemy()
	local direction = math.random( 4 )
	local xpos = CANVASX_MIN
	local ypos = CANVASY_MIN
	local fH = false

	if( direction == 1 ) then
		xpos = math.random( CANVASX_MIN, CANVASX_MAX )
		ypos = CANVASY_MAX
	elseif( direction == 2 ) then
		xpos = math.random( CANVASX_MIN, CANVASX_MAX )
	elseif( direction == 3 ) then
		xpos = CANVASX_MAX
		ypos = math.random( CANVASY_MIN, CANVASY_MAX )
		fH = true
	else
		ypos = math.random( CANVASY_MIN, CANVASY_MAX )
	end
	
	enemy = Zombie:Init( xpos, ypos, fH, false, direction )
	self:AddEntity( enemy )
end

-- generate zombies according to game level
function GameScene:GenerateEnemy()
	if (math.random(0, 100) < self.gameLV * difficulty ) then
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
	checkingIdx = 1
	while( checkingIdx <= self.totalEntities ) do
		if self.entities[checkingIdx].type == TYPE_ZOMBIE and self.entities[checkingIdx].outBound == true then
			table.remove(self.entities, checkingIdx)
			self.totalEntities = #self.entities
		else
			checkingIdx = checkingIdx + 1
		end
	end

	-- check heart and score
	if( self.heart ~= nil and self.heart.goal == true ) then
		self.totalScore = self.totalScore + 1
		self.heart = nil
		for i = 1, self.totalEntities do
			if self.entities[ i ].type == TYPE_HEART then
				table.remove( self.entities, i )
				self.totalEntities = #self.entities
				break
			end
		end
	end
	self:GenerateHeart()

	-- check if players are beside the heart before this frame
	isBothHoldingHeart = self.heart:IsBothHolding( self.player1:GetPosition(),
												   self.player2:GetPosition() )

	-- update all eneities
	for i = 1, self.totalEntities do 
		self.entities[ i ]:Update(timeDelta)
	end

	-- < post update area > -- 
	-- check all hit boxes
	heartPos = self.heart:GetPosition() 
	p1Pos = self.player1:GetPosition()
	p2Pos = self.player2:GetPosition()
	spSize = SpriteSize()
	if CheckCollision( p1Pos, heartPos, spSize ) then
		self.player1:RevertThisFrame()
	end
	if CheckCollision( p2Pos, heartPos, spSize ) then
		self.player2:RevertThisFrame()
	end
	for i = 1, self.totalEntities do 
		if( self.entities[ i ].type == TYPE_ZOMBIE ) then
			if CheckCollision( p1Pos, self.entities[ i ]:GetPosition(), spSize ) or
				CheckCollision( p2Pos, self.entities[ i ]:GetPosition(), spSize ) then
				self:GameOver()
				return
			end
		end
	end

	-- If players are both holding the heart
	if( isBothHoldingHeart ) then 
		-- If both players moving toward the same direction
		if( self.player1.dx == self.player2.dx and self.player1.dy == self.player2.dy ) then
			-- heart move with players
			hpos = self.heart:GetPosition()
			hpos.X + = self.player1.dx
			hpos.Y + = self.player1.dy
			self.heart:UpdatePosition( hpos.X, hpos.Y )
		end
	end
	print(string.format("%d", self.totalEntities))
end

function CheckCollision(o1, o2, spSize)
	if( math.abs( o1.X - o2.X ) < spSize.X and 
		math.abs( o1.Y - o2.Y ) < spSize.Y ) then
		return true
	end
	return false
end

function GameScene:Draw()
	RedrawDisplay()
	--DrawMetaSprite("background", 0, 0, false, false, DrawMode.TilemapCache)
	for i = 1, self.totalEntities do 
		self.entities[ i ]:Draw()
	end
end

function GameScene:Reset()
	RedrawDisplay()
	display = Display()
	self.heart = nil
	self.totalScore = 0
	self.gameLV = 1
	self.lvTimer = 0
	self.player1 = Player:Init( ( display.X * 2) / 3 , display.Y / 3, "player1", 1 )
	self.player2 = Player:Init( display.X / 3, display.Y / 3, "player2", 2 )
	self.entities = { self.player1, self.player2 }
	self.totalEntities = 2
end

function GameScene:GameOver()
	SwitchScene(OVER)
end