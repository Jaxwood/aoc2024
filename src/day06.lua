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

function has_value(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function hashKey(x, y)
    return x * 1000 + y
end

function Day06.part1(content)
    local map, start = parse(content)
    local visited = { hashKey(start.x, start.y) }
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
        local key = hashKey(next.x, next.y)
        if not has_value(visited, key) then
            table.insert(visited, key)
        end
        table.insert(queue, next)
    end


    return #visited
end

return Day06
