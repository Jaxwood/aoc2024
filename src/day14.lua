local Day14 = {}

local function parse(content)
    local robots = {}

    for _, line in ipairs(content) do
        local x, y, vx, vy = line:match("p=(%d+),(%d+)%sv=([-]?%d+),([-]?%d+)")
        -- increment x and y by 1 as lua is 1-indexed
        table.insert(robots,
            { x = tonumber(x) + 1, y = tonumber(y) + 1, vx = tonumber(vx), vy = tonumber(vy), disabled = false })
    end

    return robots
end

local function count_robots(robots, x1, y1, x2, y2)
    local sum = 0
    for y = y1, y2 do
        for x = x1, x2 do
            for i, robot in ipairs(robots) do
                if robot.x == x and robot.y == y and not robots[i].disabled then
                    sum = sum + 1
                end
            end
        end
    end

    return sum
end

function Day14.part1(content, width, height, iterations)
    local robots = parse(content)
    local map = {}
    for i = 1, height do
        map[i] = {}
        for j = 1, width do
            map[i][j] = '.'
        end
    end

    for _ = 1, iterations do
        -- move robot according to velocity
        -- if they are out of bounds, wrap around
        for i, _ in ipairs(robots) do
            robots[i].x = robots[i].x + robots[i].vx
            robots[i].y = robots[i].y + robots[i].vy

            if robots[i].x < 1 then
                robots[i].x = (width + robots[i].x)
            elseif robots[i].x > width then
                robots[i].x = (robots[i].x - width)
            end

            if robots[i].y < 1 then
                robots[i].y = (height + robots[i].y)
            elseif robots[i].y > height then
                robots[i].y = (robots[i].y - height)
            end
        end
    end

    -- find the middle of the grid
    local horizontal = (width // 2 + 1)
    local vertical = height // 2 + 1

    -- disable robots in the middle of the grid
    for _ = 1, height do
        for _ = 1, width do
            for i, robot in ipairs(robots) do
                if robot.x == horizontal or robot.y == vertical then
                    robots[i].disabled = true
                end
            end
        end
    end

    -- count robots in each quadrant
    return count_robots(robots, 1, 1, horizontal, vertical) *
        count_robots(robots, horizontal, 1, width, vertical) *
        count_robots(robots, 1, vertical, horizontal, height) *
        count_robots(robots, horizontal, vertical, width, height)
end

return Day14
