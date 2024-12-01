local Day01 = {}

function parse(content)
    local left = {}
    local right = {}
    for _, line in ipairs(content) do
        l, r = line:match("(%d+)%s+(%d+)")
        table.insert(left, tonumber(l))
        table.insert(right, tonumber(r))
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

function Day01.part2(content)
    local left, right = parse(content)
    local result = 0

    -- calculate how many times a number appears in right list
    local times = {}
    for _, v in ipairs(right) do
        times[v] = (times[v] or 0) + 1
    end

    -- sum all
    for _, v in ipairs(left) do
        result = result + (v * (times[v] or 0))
    end

    return result
end

return Day01
