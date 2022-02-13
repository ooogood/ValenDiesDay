Heart = {}
Heart.__index = Heart

function Heart:Init()
    spriteSize = SpriteSize()
    display = Display()
    xpos = math.random(spriteSize.X, display.x-spriteSize.X)
    ypos = math.random(spriteSize.Y, display.y-spriteSize.Y)
    local _heart = {
        hitRect = NewRect( xpos, ypos, spriteSize.X, spriteSize.Y ),
        type = TYPE_HEART,
        goal = false,
        hole_position = { ( display.x - spriteSize.X ) / 2, ( display.y - spriteSize.Y ) / 2 },
    }
    setmetatable(_heart, Heart)
    return _heart
end

function Heart:IsBothHolding( p1, p2 )
    -- return self.hitRect:Contains( p1 ) and self.hitRect:Contains( p2 )
    if( math.abs( p1.X - self.hitRect.X ) < SpriteSize().X * 1.2 and 
        math.abs( p1.Y - self.hitRect.Y ) < SpriteSize().Y * 1.2 and
        math.abs( p2.X - self.hitRect.X ) < SpriteSize().X * 1.2 and 
        math.abs( p2.Y - self.hitRect.Y ) < SpriteSize().Y * 1.2 ) then
        return true
    end
    return false
end

function Heart:GetPosition()
    return self.hitRect
end

function Heart:UpdatePosition(x, y)
    self.hitRect.X = x
    self.hitRect.Y = y

    -- restrict it within boundar
    if( self.hitRect.X < CANVASX_MIN ) then
        self.hitRect.X = CANVASX_MIN
    end
    if( self.hitRect.Y < CANVASY_MIN ) then
        self.hitRect.Y = CANVASY_MIN
    end
    if( self.hitRect.X > CANVASX_MAX - SpriteSize().X ) then
        self.hitRect.X = CANVASX_MAX - SpriteSize().X
    end
    if( self.hitRect.Y > CANVASY_MAX - SpriteSize().Y ) then
        self.hitRect.Y = CANVASY_MAX - SpriteSize().Y 
    end
end

function Heart:Update(timeDelta)
    -- check if this heart is near the hole
    if ( math.abs( self.hitRect.X - self.hole_position[1] ) < SpriteSize().X and
         math.abs( self.hitRect.Y - self.hole_position[2] ) < SpriteSize().Y ) then
        print("goal")
        self.goal = true
    end
end

function Heart:Draw()
    DrawMetaSprite("hole", self.hole_position[1], self.hole_position[2] )
    if (self.goal ~= true) then
        DrawMetaSprite("heart", self.hitRect.X, self.hitRect.Y )
    end
end

