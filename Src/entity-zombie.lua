Zombie = {}
Zombie.__index = Zombie

function Zombie:Init(x, y, fH, fV, direction)

    local _zombie = {
        posX = x,
        posY = y,
        flipH = fH or false,
        flipV = fV or false,
        drawMode = DrawMode.Sprite,
        delay = 400,
        type = TYPE_ZOMBIE,
        checkAgainst = TYPE_PLAYER,
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

function Zombie:Update(timeDelta)

    if self.movement.Up then
        self.posY = self.posY - 1
    end

    if self.movement.Down then
        self.posY = self.posY + 1
    end

    if self.movement.Left then
        self.posX = self.posX - 1
    end

    if self.movement.Right then
        self.posX = self.posX + 1
    end
  
    if self.posX < 0 or self.posX > Display().x + 20 or self.posY < 0 or self.posY > Display().y + 20 then
        self.outBound = true
    end

end

function Zombie:Draw()

    DrawRect( self.posX, self.posY, 8, 8, 14, DrawMode.Sprite )

end
