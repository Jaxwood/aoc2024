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
    local first, _ = unvisited:peek()

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

local function create_track(racetrack, from)
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

    return unvisited
end

function Day20.part1(content)
    local racetrack, from, to = parse(content)
    local destination = serialize(to[1], to[2])
    local cheats = {}
    local times = {}

    -- find the shortest path to the destination
    -- track all the nodes in the path
    local track = create_track(racetrack, from)
    local path_length = dijkstra(track, destination)

    -- find all walls can be used as a cheat
    for y, row in ipairs(racetrack) do
        for x, cell in ipairs(row) do
            if cell == 2 and x > 1 and x < #row and y > 1 and y < #racetrack then
                local up = y - 1
                local down = y + 1
                local left = x - 1
                local right = x + 1
                if (racetrack[up][x] == 1 and racetrack[down][x] == 1) or (racetrack[y][left] == 1 and racetrack[y][right] == 1) then
                    table.insert(cheats, { x, y })
                end
            end
        end
    end

    local total = 0

    -- try each cheat and update the distance to the destination
    for i, cheat in ipairs(cheats) do
        local copy = create_track(racetrack, from)
        local x, y = cheat[1], cheat[2]
        local key = serialize(x, y)
        copy:insert(math.huge, key)
        local distance = dijkstra(copy, destination)
        local idx = tostring(path_length - distance)
        if not times[idx] then
            times[idx] = 0
        end
        times[idx] = times[idx] + 1
        if (path_length - distance) >= 100 then
            total = total + 1
        end
    end

    return total
end

return Day20

