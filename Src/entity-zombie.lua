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
  
    -- -- This is where we calculate if the direction the enemy should be moving. We do this by setting the `input.left` flag to the `flipH` value. By default, all entities are facing right which would make `flipH` false. Knowing this, we can set the `input.right` flag to the opposite of `flipH` via the `not` keyword.
    -- self.input.Left = self.flipH
    -- self.input.Right = not self.flipH
    

end

function Zombie:Draw()

    DrawRect( self.posX, self.posY, 8, 8, 14, DrawMode.Sprite )

end
