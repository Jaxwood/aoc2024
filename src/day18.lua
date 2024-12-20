local Day18 = {}

local function parse(content)
    local bytes = {}
    local idx = 0

    for _, line in ipairs(content) do
        local x, y = line:match("(%d+),(%d+)")
        bytes[idx] = { x = tonumber(x), y = tonumber(y) }
        idx = idx + 1
    end

    return bytes
end

local neighbors = {
    { x = 0,  y = -1 },
    { x = 0,  y = 1 },
    { x = -1, y = 0 },
    { x = 1,  y = 0 }
}

local function contains(list, x, y)
    for _, v in ipairs(list) do
        if v.x == x and v.y == y then
            return true
        end
    end

    return false
end

function Day18.part1(content, steps, grid)
    local bytes = parse(content)

    local walls = {}
    -- mark walls
    for i = 0, steps - 1, 1 do
        local x, y = bytes[i].x, bytes[i].y
        walls[y] = walls[y] or {}
        walls[y][x] = true
    end

    local unvisited = {}
    local visited = {}
    local start = { x = 0, y = 0 }
    local goal = { x = grid, y = grid }

    -- add all nodes that is not a wall to the unvisited list
    for y = 0, grid, 1 do
        for x = 0, grid, 1 do
            if not walls[y] or not walls[y][x] then
                unvisited[y] = unvisited[y] or {}
                if x == start.x and y == start.y then
                    table.insert(unvisited, { x = x, y = y, cost = 0 })
                else
                    table.insert(unvisited, { x = x, y = y, cost = math.huge })
                end
            end
        end
    end

    while #unvisited > 0 do
        -- get the node with the lowest cost
        table.sort(unvisited, function(a, b) return a.cost < b.cost end)
        local current = table.remove(unvisited, 1)
        table.insert(visited, current)

        -- if the cost is infinity, we can't reach the goal
        if current.cost == math.huge then
            break
        end

        -- check if we reached the goal
        if current.x == goal.x and current.y == goal.y then
            return current.cost
        end

        -- visit neighbors
        for _, neighbor in ipairs(neighbors) do
            local x, y = current.x + neighbor.x, current.y + neighbor.y
            if x >= 0 and x <= grid and y >= 0 and y <= grid then
                if not walls[y] or not walls[y][x] and not contains(visited) then
                    local cost = current.cost + 1
                    -- update cost if it's less than the current cost
                    for _, v in ipairs(unvisited) do
                        if v.x == x and v.y == y then
                            if cost < v.cost then
                                v.cost = cost
                            end
                        end
                    end
                end
            end
        end
    end

    assert(false, "No solution found")
end

function Day18.part2(content, grid)
    local bytes = parse(content)

    local mid = 0
    local left = 1
    local right = #bytes

    -- use binary search to find the next step until we can reach the goal
    while left <= right do
        mid = math.floor((left + right) / 2)
        local walls = {}
        -- mark walls
        for i = 0, mid, 1 do
            local x, y = bytes[i].x, bytes[i].y
            walls[y] = walls[y] or {}
            walls[y][x] = true
        end

        local unvisited = {}
        local visited = {}
        local start = { x = 0, y = 0 }
        local goal = { x = grid, y = grid }

        -- add all nodes that is not a wall to the unvisited list
        for y = 0, grid, 1 do
            for x = 0, grid, 1 do
                if not walls[y] or not walls[y][x] then
                    unvisited[y] = unvisited[y] or {}
                    if x == start.x and y == start.y then
                        table.insert(unvisited, { x = x, y = y, cost = 0 })
                    else
                        table.insert(unvisited, { x = x, y = y, cost = math.huge })
                    end
                end
            end
        end

        while #unvisited > 0 do
            -- get the node with the lowest cost
            table.sort(unvisited, function(a, b) return a.cost < b.cost end)
            local current = table.remove(unvisited, 1)
            table.insert(visited, current)

            -- no solution found set upper bound to mid - 1
            if current.cost == math.huge then
                right = mid - 1
                break
            end

            -- solution found set lower bound to mid + 1
            if current.x == goal.x and current.y == goal.y then
                left = mid + 1
                break
            end

            -- visit neighbors
            for _, neighbor in ipairs(neighbors) do
                local x, y = current.x + neighbor.x, current.y + neighbor.y
                if x >= 0 and x <= grid and y >= 0 and y <= grid then
                    if not walls[y] or not walls[y][x] and not contains(visited) then
                        local cost = current.cost + 1
                        -- update cost if it's less than the current cost
                        for _, v in ipairs(unvisited) do
                            if v.x == x and v.y == y then
                                if cost < v.cost then
                                    v.cost = cost
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return string.format("%d,%d", bytes[mid].x, bytes[mid].y)
end

return Day18
