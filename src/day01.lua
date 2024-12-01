local Day01 = {}

function parse(content)
    local left = {}
    local right = {}
    for i, line in ipairs(content) do
        l, r = line:match("(%d+)%s+(%d+)")
        table.insert(left, l)
        table.insert(right, r)
    end

    table.sort(left)
    table.sort(right)

    return left, right
end

function Day01.part1(content)
    local left, right = parse(content)
    local result = 0
    for i, v in ipairs(right) do
        result = result + math.abs(left[i] - right[i])
    end
    return result
end

return Day01
