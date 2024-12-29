local binaryheap = require 'binaryheap'

local Day20 = {}

local OPEN = 1
local WALL = 2
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
            if c == "." then
                racetrack[y][x] = OPEN
            elseif c == "#" then
                racetrack[y][x] = WALL
            elseif c == start then
                racetrack[y][x] = OPEN
                from = { x, y }
            elseif c == finish then
                racetrack[y][x] = OPEN
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

function Day20.part1(content, seconds, limit)
    local racetrack, from, to = parse(content)
    local destination = serialize(to[1], to[2])
    local unvisited = binaryheap.minUnique()

    -- initialize the unvisited list
    for y, row in ipairs(racetrack) do
        for x, cell in ipairs(row) do
            if cell == OPEN then
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

    -- loop through the racetrack
    -- for each cell, check what other cell we can reach within the 20 second rule
    -- use the manhattan distance to check if the new cell is reachable
    -- store all the paths that have a difference greater than the limit
    for y, row in ipairs(racetrack) do
        for x, cell in ipairs(row) do
            -- check if the cell is open
            if cell == OPEN then
                local key = serialize(x, y)
                -- check the manhattan distance to the destination
                -- to verify if the new cell is reachable
                for yy = y - seconds, y + seconds, 1 do
                    for xx = x - seconds, x + seconds, 1 do
                        local manhattan = math.abs(x - xx) + math.abs(y - yy)
                        if manhattan <= seconds then
                            local new_key = serialize(xx, yy)
                            -- check if the new cheat ends up on the track
                            if cost[new_key] and cost[key] and cost[key] < cost[new_key] then
                                local diff = cost[new_key] - cost[key] - manhattan
                                -- check if the difference is greater than the limit
                                if diff >= limit then
                                    total = total + 1
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return total
end

return Day20
