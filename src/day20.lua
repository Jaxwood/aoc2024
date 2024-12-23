local binaryheap = require 'binaryheap'

local Day20 = {}

local OPEN = "."
local WALL = "#"
local start = "S"
local finish = "E"

local function parse(content)
    local racetrack = {}
    local from = {}
    local to = {}

    for y, line in ipairs(content) do
        for x = 1, string.len(line) do
            local c = string.sub(line, x, x)
            if racetrack[y] == nil then
                racetrack[y] = {}
            end
            if c == OPEN then
                racetrack[y][x] = 1
            elseif c == WALL then
                racetrack[y][x] = 2
            elseif c == start then
                racetrack[y][x] = 1
                from = { x, y }
            elseif c == finish then
                racetrack[y][x] = 1
                to = { x, y }
            else
                assert(false, "Unknown character: " .. c)
            end
        end
    end

    return racetrack, from, to
end

local neighbors = {
    { 0,  -1 },
    { 0,  1 },
    { -1, 0 },
    { 1,  0 }
}

local function serialize(x, y)
    return x .. "_" .. y
end

local function deserialize(key)
    local x, y = key:match("(%d+)_(%d+)")
    return tonumber(x), tonumber(y)
end

-- Dijkstra's algorithm
local function dijkstra(unvisited, destination)
    local cost = {}
    local from, val = unvisited:peek()
    cost[from] = val

    while unvisited:peek() do
        local current, distance = unvisited:peek()
        unvisited:remove(current)

        -- check if we reached the destination
        if current == destination then
            return cost
        end

        -- update the distance of the neighbors
        local new_distance = distance + 1
        local x, y = deserialize(current)
        for _, neighbour in ipairs(neighbors) do
            local key = serialize(x + neighbour[1], y + neighbour[2])
            if unvisited.reverse[key] then
                local current_dist = unvisited:valueByPayload(key)
                if current_dist > new_distance then
                    unvisited:update(key, new_distance)
                    cost[key] = new_distance
                end
            end
        end
    end

    assert(false, "No path found")
end

function Day20.part1(content)
    local racetrack, from, to = parse(content)
    local destination = serialize(to[1], to[2])
    local unvisited = binaryheap.minUnique()

    -- initialize the unvisited list
    for y, row in ipairs(racetrack) do
        for x, cell in ipairs(row) do
            if cell == 1 then
                unvisited:insert(math.huge, serialize(x, y))
            end

            -- update the starting point in the unvisited list
            if x == from[1] and y == from[2] then
                unvisited:update(serialize(x, y), 0)
            end
        end
    end

    -- find the cost of each node to reach the destination
    local cost = dijkstra(unvisited, destination)

    local total = 0
    -- find all walls can be used as a cheat
    for y, row in ipairs(racetrack) do
        for x, cell in ipairs(row) do
            -- check if the cell is a wall
            if cell == 2 and x > 1 and x < #row and y > 1 and y < #racetrack then

                local up = y - 1
                local down = y + 1
                -- check if the wall can be used as a cheat in the vertical direction
                if (racetrack[up][x] == 1 and racetrack[down][x] == 1) then
                    local diff = math.abs(cost[serialize(x, down)] - cost[serialize(x, up)]) - 2
                    if diff >= 100 then
                        total = total + 1
                    end
                end

                local left = x - 1
                local right = x + 1
                -- check if the wall can be used as a cheat in the horizontal direction
                if (racetrack[y][left] == 1 and racetrack[y][right] == 1) then
                    local diff = math.abs(cost[serialize(left, y)] - cost[serialize(right, y)]) - 2
                    if diff >= 100 then
                        total = total + 1
                    end
                end
            end
        end
    end

    return total
end

return Day20
