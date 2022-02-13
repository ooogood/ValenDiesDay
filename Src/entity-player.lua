
--@ a table to store all of the player's functions
Player = {}
Player.__index = Player

local frameDelay = 100
local totalFrames = 4
local Player1Key = { 
        up = Keys.Up, 
        down = Keys.Down, 
        left = Keys.Left, 
        right = Keys.Right, 
    }
local Player2Key = { 
        up = Keys.W, 
        down = Keys.S, 
        left = Keys.A, 
        right = Keys.D, 
    }


function Player:Init( px, py, spriteName, playerNum )

    --@ define the bounds of a player by the size of the sprite (X:width. Y:heigth)
    -- set all the variables
    local _player = {
        playeridx = playerNum,
        hitRect = NewRect( px, py, SpriteSize().X * 2, SpriteSize().Y * 2 ),
        metaSprite = spriteName, 
        keys = nil,
        alive = true,
        frame = 1,
        speed = 1,
        speedPerFrame = 1,
        dx = 0,
        dy = 0,
        frame = 1,
        frameTime = 0,
    }
    if( playerNum == 1 ) then 
        _player.keys = Player1Key
    else
        _player.keys = Player2Key
    end

    setmetatable(_player, Player)
    return _player

end

function Player:Update( timeDelta )
    
    local lastPos = self.hitRect
    self.dx = 0
    self.dy = 0

    -- If left is pressed, make the x velocity towards the left.
    if( Key( self.keys.left ) ) then
        self.dx = self.dx - self.speedPerFrame
    end

    -- If right is pressed, make the x velocity towards the right.
    if( Key( self.keys.right ) ) then
        self.dx = self.dx + self.speedPerFrame
    end

    -- If up is pressed, make the y velocity upwards.
    if( Key( self.keys.up ) ) then
        self.dy = self.dy - self.speedPerFrame
    end

    -- If down is pressed, make the y velocity downwards.
    if( Key( self.keys.down ) ) then
        self.dy = self.dy + self.speedPerFrame
    end

    -- calculating the net x and y velocities, 
    -- change the player's position accordingly.
    self.hitRect.X + = self.dx
    self.hitRect.Y + = self.dy

    -- restrict it within boundar
    if( self.hitRect.X < CANVASX_MIN ) then
        self.hitRect.X = CANVASX_MIN
    end
    if( self.hitRect.Y < CANVASY_MIN ) then
        self.hitRect.Y = CANVASY_MIN
    end
    if( self.hitRect.X > CANVASX_MAX - SpriteSize().X * 2 ) then
        self.hitRect.X = CANVASX_MAX - SpriteSize().X * 2
    end
    if( self.hitRect.Y > CANVASY_MAX - SpriteSize().Y * 2 ) then
        self.hitRect.Y = CANVASY_MAX - SpriteSize().Y * 2 
    end
    -- process frame
    if( math.abs( self.dx ) > 0 or math.abs( self.dy ) > 0) then 
        -- only update frame when moving
        self.frameTime += timeDelta
    else 
        self.frame = 1
    end
    if( self.frameTime > frameDelay) then
        self.frameTime = 0
        self.frame += 1
        if( self.frame > totalFrames ) then
            self.frame = 1
        end
    end

end

function Player:RevertThisFrame()
    self.hitRect.X -= self.dx
    self.hitRect.Y -= self.dy
end

function Player:GetDx()
    return self.dx
end

function Player:GetDy()
    return self.dy
end

-- get the position
function Player:GetPosition()
    return self.hitRect
end

function Player:Draw()
    DrawMetaSprite( self.metaSprite .. self.frame, self.hitRect.X, self.hitRect.Y )
end