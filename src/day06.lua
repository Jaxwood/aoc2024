local Day06 = {}

function parse(content)
    local map = {}
    local start = {}

    for y, line in ipairs(content) do
        for x = 1, #line do
            if not map[y] then
                map[y] = {}
            end
            local location = line:sub(x, x)
            if location == '^' then
                start = { x = x, y = y }
            end
            map[y][x] = location
        end
    end

    return map, start
end

function Day06.part1(content)
    local map, start = parse(content)
    local visited = {}
    visited[start.y] = {}
    visited[start.y][start.x] = '^'
    local queue = { start }

    while #queue > 0 do
        local current = table.remove(queue, 1)
        local x, y = current.x, current.y
        local location = map[y][x]
        local next = { x = x, y = y }

        -- move in the direction we are facing
        if location == 'v' then
            next.y = y + 1
        elseif location == '^' then
            next.y = y - 1
        elseif location == '<' then
            next.x = x - 1
        elseif location == '>' then
            next.x = x + 1
        end

        -- check for out of bounds
        if next.x < 1 or next.x > #map[1] or next.y < 1 or next.y > #map then
            break
        end

        -- check if we hit a wall and turn 90 degrees right
        if map[next.y][next.x] == '#' then
            next = { x = x, y = y }
            if location == 'v' then
                next.x = x - 1
                location = '<'
            elseif location == '^' then
                next.x = x + 1
                location = '>'
            elseif location == '<' then
                next.y = y - 1
                location = '^'
            elseif location == '>' then
                next.y = y + 1
                location = 'v'
            end
        end

        -- update position
        map[y][x] = '.'
        map[next.y][next.x] = location
        if not visited[next.y] then
            visited[next.y] = {}
        end
        visited[next.y][next.x] = location
        table.insert(queue, next)
    end

    -- count the number of visited locations
    local total = 0
    for _, v in pairs(visited) do
        for _, _ in pairs(v) do
            total = total + 1
        end
    end

    return total
end

--[[
-- First we find the route to the end of the maze.
-- This will give us all the unique locations we have visited.
-- We then insert an obstacle at each location and check if create a cycle (except for the start location).
--
-- To detect a cycle we need to check if the current position has been visited before
-- and if we are traveling in the same direction.
--
-- The final answer is the number of cycles we have found.
--]]
function part2(content)
    return 0
end

return Day06
