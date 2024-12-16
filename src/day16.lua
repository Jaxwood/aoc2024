local Day16 = {}

local WALL = 1
local OPEN = 2

local EAST = 1
local WEST = 2
local NORTH = 3
local SOUTH = 4

local function parse(content)
    local map = {}
    local from = {}
    local to = {}

    for y, line in ipairs(content) do
        if not map[y] then
            map[y] = {}
        end

        for x = 1, #line do
            local c = line:sub(x, x)
            if c == "S" then
                from = { x = x, y = y }
                map[y][x] = OPEN
            elseif c == "E" then
                to = { x = x, y = y }
                map[y][x] = OPEN
            elseif c == "#" then
                map[y][x] = WALL
            else
                map[y][x] = OPEN
            end
        end
    end

    return map, from, to
end

local function print_map(map)
    for y, line in ipairs(map) do
        local out = ""
        for x, tile in ipairs(line) do
            if tile == OPEN then
                out = out .. "."
            elseif tile == WALL then
                out = out .. "#"
            end
        end
        print(out)
    end
end

local function contains(map, val)
    for _, v in ipairs(map) do
        if v.x == val.x and v.y == val.y and v.facing == val.facing then
            return true
        end
    end

    return false
end

-- get the neighbors of the current position
-- we can either move forward at the cost of 1
-- or turn clockwise or counter clockwise at the cost of 1000
local function get_neighbors(map, current)
    local neighbors = {}
    local cost = current.cost

    if current.facing == EAST then
        if map[current.y][current.x + 1] == OPEN then
            table.insert(neighbors, { x = current.x + 1, y = current.y, cost = cost + 1, facing = EAST })
        end
        table.insert(neighbors, { x = current.x, y = current.y, cost = cost + 1000, facing = NORTH })
        table.insert(neighbors, { x = current.x, y = current.y, cost = cost + 1000, facing = SOUTH })
    elseif current.facing == WEST then
        if map[current.y][current.x - 1] == OPEN then
            table.insert(neighbors, { x = current.x - 1, y = current.y, cost = cost + 1, facing = WEST })
        end
        table.insert(neighbors, { x = current.x, y = current.y, cost = cost + 1000, facing = NORTH })
        table.insert(neighbors, { x = current.x, y = current.y, cost = cost + 1000, facing = SOUTH })
    elseif current.facing == NORTH then
        if map[current.y - 1][current.x] == OPEN then
            table.insert(neighbors, { x = current.x, y = current.y - 1, cost = cost + 1, facing = NORTH })
        end
        table.insert(neighbors, { x = current.x, y = current.y, cost = cost + 1000, facing = EAST })
        table.insert(neighbors, { x = current.x, y = current.y, cost = cost + 1000, facing = WEST })
    elseif current.facing == SOUTH then
        if map[current.y + 1][current.x] == OPEN then
            table.insert(neighbors, { x = current.x, y = current.y + 1, cost = cost + 1, facing = SOUTH })
        end
        table.insert(neighbors, { x = current.x, y = current.y, cost = cost + 1000, facing = EAST })
        table.insert(neighbors, { x = current.x, y = current.y, cost = cost + 1000, facing = WEST })
    end

    return neighbors
end

function Day16.part1(content)
    local map, from, to = parse(content)

    local queue = {}
    local visited = {}
    table.insert(queue, { x = from.x, y = from.y, cost = 0, facing = EAST })

    while #queue > 0 do
        table.sort(queue, function(a, b) return a.cost < b.cost end)
        local current = table.remove(queue, 1)

        -- mark as visited
        table.insert(visited, { x = current.x, y = current.y, facing = current.facing })

        local neighbors = get_neighbors(map, current)
        for _, neighbor in ipairs(neighbors) do
            if not contains(visited, neighbor) then
                if neighbor.x == to.x and neighbor.y == to.y then
                    return neighbor.cost
                else
                    table.insert(queue, neighbor)
                end
            end
        end
    end

    return 0
end

return Day16
