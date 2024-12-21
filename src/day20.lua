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
    while unvisited:peek() do
        local current, distance = unvisited:peek()
        unvisited:remove(current)

        -- check if we reached the destination
        if current == destination then
            return distance
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
            if x == from[1] and y == from[2] then
                unvisited:update(serialize(x, y), 0)
            end
        end
    end

    return dijkstra(unvisited, destination)
end

return Day20

