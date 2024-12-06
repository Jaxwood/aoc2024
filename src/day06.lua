local Day06 = {}

function parse(content)
    local map = {}

    for y, line in ipairs(content) do
        for x = 1, #line do
            if not map[y] then
                map[y] = {}
            end
            map[y][x] = line:sub(x, x)
        end
    end

    return map
end

function Day06.part1(content)
    local map = parse(content)
    return 0
end

return Day06
