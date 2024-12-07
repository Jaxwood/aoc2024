local Day07 = {}

function parse(content)
    local equations = {}
    for _, line in ipairs(content) do
        local numbers = {}
        local result, nums = line:match("(.*):(.*)")
        for num in nums:gmatch("(%d+)") do
            table.insert(numbers, tonumber(num))
        end
        table.insert(equations, { result = tonumber(result), numbers = numbers })
    end
    return equations
end

function Day07.part1(content)
    local data = parse(content)
    return 0
end

return Day07
