local Day10 = {}

local function parse(content)
    local map = {}
    local trailheads = {}

    for y = 1, #content do
        for x = 1, #content[y] do
            local c = content[y]:sub(x, x)
            map[y] = map[y] or {}
            map[y][x] = tonumber(c)
            if c == "0" then
                table.insert(trailheads, { x = x, y = y })
            end
        end
    end

    return map, trailheads
end

function Day10.part1(content)
    local map, trailheads = parse(content)

    return 0
end

return Day10

