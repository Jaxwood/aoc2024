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
                racetrack[y][x] = 1
            elseif c == "#" then
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

local composite_key = function(x, y, xx, yy)
    return math.min(x, xx) .. "_" .. math.min(y, yy) .. "_" .. math.max(x, xx) .. "_" .. math.max(y, yy)
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
    local seen = {}

    local total = 0
    -- find all walls can be used as a cheat
    for y, row in ipairs(racetrack) do
        for x, cell in ipairs(row) do
            -- check if the cell is open
            if cell == OPEN then
                local key = serialize(x, y)
                -- check the manhattan distance to the destination
                -- to verify if the new cell is reachable
                for yy = y - seconds, y + seconds do
                    for xx = x - seconds, x + seconds do
                        local manhattan = math.abs(x - xx) + math.abs(y - yy)
                        if manhattan <= seconds then
                            local new_key = serialize(xx, yy)
                            -- check if the new cell is part of the track
                            if cost[new_key] and cost[key] then
                                local diff = math.abs(cost[new_key] - cost[key]) - manhattan
                                -- check if the difference is greater than the limit
                                -- store the path to handle the duplicates
                                if diff >= limit then
                                    local composite = composite_key(x, y, xx, yy)
                                    seen[diff] = seen[diff] or {}
                                    table.insert(seen[diff], composite)
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    -- count the number of unique keys for each difference
    for k, v in pairs(seen) do
        local unique = {}
        for _, vv in ipairs(v) do
            unique[vv] = true
        end
        local cnt = 0
        for _, _ in pairs(unique) do
            cnt = cnt + 1
        end
        total = total + cnt
        -- print(k, cnt)
    end

    return total
end

return Day20
