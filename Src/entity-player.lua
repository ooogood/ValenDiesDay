
--@ a table to store all of the player's functions
Player = {}
Player.__index = Player

function Player:Init( px, py , spriteName )
    
    --@ record bounds
    local display = Display()
    width = display.x
    height = display.y

    --@ define the bounds of a player by the size of the sprite (X:width. Y:heigth)
    -- set all the variables
    local _player = {
        hitRect = NewRect( px, py, SpriteSize().X, SpriteSize().Y ),
        metaSprite = MetaSprite( spriteName ), 
        alive = true,
        blobX = px,
        blobY = py,
        frame = 1,
        speed = 1,
        blobSize = 20,
        blobSpeed = 1
    }

    setmetatable(_player, Player)
    return _player

end

function Player:Update( timeDelta )
    
    local dx = 0
    local dy = 0

    -- If left is pressed, make the x velocity towards the left.
    if( Key( Keys.Left ) ) then
        dx +  = -blobSpeed
    end

    -- If right is pressed, make the x velocity towards the right.
    if( Key( Keys.Right ) ) then
        dx +  = blobSpeed
    end

    -- If up is pressed, make the y velocity upwards.
    if( Key( Keys.Up ) ) then
        dy +  = -blobSpeed
    end

    -- If down is pressed, make the y velocity downwards.
    if( Key( Keys.Down ) ) then
        dy +  = blobSpeed
    end

    -- calculating the net x and y velocities, 
    -- change the player's position accordingly.
    self.blobX +  = dx
    self.blobY +  = dy

    -- restrict it within boundaries
    self.blobX % = width
    self.blobY % = height
    
    -- Since the player is dead, there is nothing to do and we exit 
    -- out of the player's `LateUpdate()` function. This also insures 
    -- that we don't try to collect the key or gem in the next block of code.
    
    if( self.alive == false ) then
        return
    end

end

-- get the position
function Player:GetPosition()
    return self.hitRect
end

function Player:Draw()
    DrawMetaSprite ( FindMetaSpriteId( "player" ), self.blobX, self.blobY )
end