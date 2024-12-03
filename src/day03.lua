local Day03 = {}

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

function Day03.part1(content)
    return 0
end

return Day03

