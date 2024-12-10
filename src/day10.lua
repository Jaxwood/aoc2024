local Day10 = {}

local function parse(content)
    local map = {}

    for y = 1, #content do
        for x = 1, #content[y] do
            local c = content[y]:sub(x, x)
            map[y] = map[y] or {}
            map[y][x] = tonumber(c)
        end
    end

    return map
end

function Day10.part1(content)
    local map = parse(content)

    return 0
end

return Day10

