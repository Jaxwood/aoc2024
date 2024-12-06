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

function is_cycle(map, start, direction, max)
    local queue = { { x = start.x, y = start.y } }
    local size = 1

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
            return false
        end

        -- check if we hit a wall and turn 90 degrees right
        if map[next.y][next.x] == '#' then
            if location == 'v' then
                location = '<'
            elseif location == '^' then
                location = '>'
            elseif location == '<' then
                location = '^'
            elseif location == '>' then
                location = 'v'
            end
            map[y][x] = location

            -- update position
            table.insert(queue, current)
        else
            map[y][x] = '.'
            map[next.y][next.x] = location

            -- update position
            table.insert(queue, next)
            size = size + 1

            if size > max then
                return true
            end
        end
    end
end

function traverse(map, start, direction)
    local visited = {}
    visited[start.y] = {}
    visited[start.y][start.x] = direction
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
            if location == 'v' then
                location = '<'
            elseif location == '^' then
                location = '>'
            elseif location == '<' then
                location = '^'
            elseif location == '>' then
                location = 'v'
            end
            map[y][x] = location
            -- update position
            visited[y][x] = location
            table.insert(queue, current)
        else
            map[y][x] = '.'
            map[next.y][next.x] = location

            -- update position
            if not visited[next.y] then
                visited[next.y] = {}
            end
            visited[next.y][next.x] = location
            table.insert(queue, next)
        end

    end

    return visited
end

function copy_table(original)
    local copy = {}
    for i, row in ipairs(original) do
        copy[i] = {}
        for j, value in ipairs(row) do
            copy[i][j] = value
        end
    end
    return copy
end

function Day06.part1(content)
    local map, start = parse(content)
    local visited = traverse(map, start, '^')

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
-- To detect a cycle we need to check if the length of the path is greater than the number of locations in the maze.
--
-- The final answer is the number of cycles we have found.
--]]
function Day06.part2(content)
    local map, start = parse(content)
    local visited = traverse(copy_table(map), start, '^')
    local total = 0

    for y, v in pairs(visited) do
        for x, _ in pairs(v) do
            -- skip the start location
            if start.x ~= x or start.y ~= y then
                local copy = copy_table(map)
                copy[y][x] = '#'
                if is_cycle(copy, start, '^', #map * #map[1]) then
                    total = total + 1
                end
            end
        end
    end

    return total
end

return Day06
