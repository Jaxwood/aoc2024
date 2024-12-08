local Day08 = {}

local function parse(content)
    local map = {}
    local coords = {}

    for y, line in ipairs(content) do
        for x = 1, #line do
            map[y] = map[y] or {}
            local c = line:sub(x, x)
            map[y][x] = c
            if c ~= "." then
                coords[c] = coords[c] or {}
                table.insert(coords[c], {x = x, y = y})
            end
        end
    end

    return map, coords
end

local function contains(t, e)
    for _, v in ipairs(t) do
        if v[1] == e[1] and v[2] == e[2] then
            return true
        end
    end
    return false
end

local function permute(coords)
    local perms = {}
    for i = 1, #coords do
        for j = 1, #coords do
            if i ~= j then
                if not contains(perms, {coords[j], coords[i]}) then
                    table.insert(perms, {coords[i], coords[j]})
                end
            end
        end
    end
    return perms
end

local function withinMap(coord, map)
    return coord.x > 0 and coord.x <= #map[1] and coord.y > 0 and coord.y <= #map
end

local table_contains = function(t, e)
    for _, v in ipairs(t) do
        if v.x == e.x and v.y == e.y then
            return true
        end
    end
    return false
end

function Day08.part1(content)
    local map, coords = parse(content)
    local antinodes = {}

    for _, v in pairs(coords) do
        -- find all permutations of the coordinates in pairs of two
        local perms = permute(v)
        for _, c in ipairs(perms) do
            -- calculate the antinodes
            local first = c[1]
            local second = c[2]
            local xDiff = math.abs(c[2].x - c[1].x)
            local yDiff = math.abs(c[2].y - c[1].y)
            local antinodeOne = { x = 0, y = 0 }
            local antinodeTwo = { x = 0, y = 0 }
            if first.x > second.x then
                antinodeOne.x = first.x + xDiff
                antinodeTwo.x = second.x - xDiff
            else
                antinodeOne.x = first.x - xDiff
                antinodeTwo.x = second.x + xDiff
            end
            if first.y > second.y then
                antinodeOne.y = first.y + yDiff
                antinodeTwo.y = second.y - yDiff
            else
                antinodeOne.y = first.y - yDiff
                antinodeTwo.y = second.y + yDiff
            end

            -- check if the antinodes are within the map and not already in the list
            if withinMap(antinodeOne, map) and not table_contains(antinodes, antinodeOne) then
                table.insert(antinodes, antinodeOne)
            end

            if withinMap(antinodeTwo, map) and not table_contains(antinodes, antinodeTwo) then
                table.insert(antinodes, antinodeTwo)
            end
        end
    end

    return #antinodes
end

return Day08

