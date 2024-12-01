local Day01 = {}

function parse(content)
    local left = {}
    local right = {}
    for i, line in ipairs(content) do
        l, r = line:match("(%d+)%s+(%d+)")
        left[i] = l
        right[i] = r
    end

    return left, right
end

function Day01.part1(content)
    local left, right = parse(content)
    return 0
end

return Day01
