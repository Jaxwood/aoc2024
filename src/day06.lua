local Day06 = {}

function parse(content)
    local map = {}
    local start = {}

    for y, line in ipairs(content) do
        for x = 1, #line do
            if not map[y] then
                map[y] = {}
            end
            local c = line:sub(x, x)
            if c == '^' then
                start = { x = x, y = y }
            end
            map[y][x] = c
        end
    end

    return map, start
end

function Day06.part1(content)
    local uniques = {}
    local map, start = parse(content)
    print(start.x, start.y)

    return #uniques
end

return Day06
