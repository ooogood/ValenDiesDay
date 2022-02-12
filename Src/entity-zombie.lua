Zombie = {}
Zombie.__index = Zombie

function Zombie:Init(x, y, fH, fV, direction)

    local _zombie = {
        hitRect = NewRect( x, y, SpriteSize().X, SpriteSize().Y ),
        flipH = fH or false,
        flipV = fV or false,
        drawMode = DrawMode.Sprite,
        type = TYPE_ZOMBIE,
        speed = .3,
        movement = {
            Up = false,
            Down = false,
            Left = false,
            Right = false
        },
        -- out of display flag
        outBound = false,
    }


    if direction == 1 then
        _zombie.movement.Up = true
    end

    if direction == 2 then
        _zombie.movement.Down = true
    end

    if direction == 3 then
        _zombie.movement.Left = true
    end

    if direction == 4 then
        _zombie.movement.Right = true
    end

    setmetatable(_zombie, Zombie)

    return _zombie

end

function Zombie:GetPosition()
    return self.hitRect
end

function Zombie:Update(timeDelta)

    if self.movement.Up then
        self.hitRect.Y = self.hitRect.Y - 1
    end

    if self.movement.Down then
        self.hitRect.Y = self.hitRect.Y + 1
    end

    if self.movement.Left then
        self.hitRect.X = self.hitRect.X - 1
    end

    if self.movement.Right then
        self.hitRect.X = self.hitRect.X + 1
    end
  
    if self.hitRect.X < 0 or self.hitRect.X > Display().X + 20 or self.hitRect.Y < 0 or self.hitRect.Y > Display().Y + 20 then
        self.outBound = true
    end

end

function Zombie:Draw()

    DrawRect( self.hitRect.X, self.hitRect.Y, 8, 8, 14, DrawMode.Sprite )

end
