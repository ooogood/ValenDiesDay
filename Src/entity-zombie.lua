Zombie = {}
Zombie.__index = Zombie

function Zombie:Init(x, y, fH, fV, direction)

    local _zombie = {
        posX = x,
        posY = y,
        flipH = fH or false,
        flipV = fV or false,
        drawMode = DrawMode.Sprite,
        delay = 400
        type = TYPE_ZOMBIE
        checkAgainst = TYPE_PLAYER
        speed = .3
    }

    local movement = {
        Up = false,
        Down = false,
        Left = false,
        Right = false
    }

    if direction == 1 then
        movement.Up = true
    end

    if direction == 2 then
        movement.Down = true
    end

    if direction == 3 then
        movement.Left = true
    end

    if direction == 4 then
        movement.Right = true
    end


    setMetaTable(zombie, Zombie)

    return zombie

end


function Zombie:Update(timeDelta)

    if movement.Up then
        posY = posY - 1
    end

    if movement.Down then
        posY = posY + 1
    end

    if movement.Left then
        posX = posX - 1
    end

    if movement.Right then
        posX = posX + 1
    end
  
  
    -- This is where we calculate if the direction the enemy should be moving. We do this by setting the `input.left` flag to the `flipH` value. By default, all entities are facing right which would make `flipH` false. Knowing this, we can set the `input.right` flag to the opposite of `flipH` via the `not` keyword.
    self.input.Left = self.flipH
    self.input.Right = not self.flipH
    

end

function Zombie:Draw()

    DrawRect( zombie.posX, zombie.posY, 8, 8, 2, DrawMode.Sprite )

end
