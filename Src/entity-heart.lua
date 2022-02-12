Heart = {}
Heart.__index = Heart

function Heart:Init()
    local _heart = {
        x = math.random(1, Display().x-2),
        y = math.random(1, Display().y-2),
        goal = false,
        hole_position = {10, 10},
    }
    setmetatable(_heart, Heart)
    return _heart
end

function Heart:UpdatePosition(x, y)
    if (x < Display().x and y < Display().y) then
        self.x = x
        self.y = y
    end
end

function Heart:Update(timeDelta)
    local d_x = self.x - self.hole_position[1]
    local d_y = self.y - self.hole_position[2]
    if (math.abs(d_x) <= 2 and math.abs(d_y) <= 2) then
        self.goal = true
    end
end

function Heart:Draw()
    DrawMetaSprite("hole", self.hole_position[1], self.hole_position[2])
    if (self.goal ~= true) then
        DrawMetaSprite("heart", self.x, self.y)
    end
end

