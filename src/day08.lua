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

function Day08.part1(content)
    local map, coords = parse(content)
    local height = #map
    local width = #map[1]

    for k, v in pairs(coords) do
        -- find all permutations of the coordinates in pairs of two
        local perms = permute(v)
        for _, c in ipairs(perms) do
            print(k, c[1].x .. "," .. c[1].y, c[2].x .. "," .. c[2].y)
        end
    end

    return 0
end

return Day08

