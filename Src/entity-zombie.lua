Zombie = {}
Zombie.__index = Zombie

function Zombie:Init(x, y, fH, fV, direction)

    local zombie = {
        hitRect = NewRect(x, y, SpriteSize().X, SpriteSize().Y),
        flipH = fH or false,
        flipV = fV or false,
        drawMode = DrawMode.Sprite,
        frame = 1,
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

    -- Before we get started it's important to call out that there is no way to kill an enemy in this game so we don't check to see if the enemy is dead.
  
  
    -- This is where we calculate if the direction the enemy should be moving. We do this by setting the `input.left` flag to the `flipH` value. By default, all entities are facing right which would make `flipH` false. Knowing this, we can set the `input.right` flag to the opposite of `flipH` via the `not` keyword.
    self.input.Left = self.flipH
    self.input.Right = not self.flipH
    

end
