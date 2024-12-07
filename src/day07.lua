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

function copy_table(original)
    local copy = {}
    for i, row in ipairs(original) do
        copy[i] = row
    end
    return copy
end

function solve(numbers, total, result)
    if total == result then
        return true
    end

    if #numbers == 0 then
        return false
    end

    local next = table.remove(numbers, 1)
    return solve(copy_table(numbers), total + next, result) or solve(copy_table(numbers), total * next, result)
end

function Day07.part1(content)
    local data = parse(content)
    local total = 0

    for _, eq in ipairs(data) do
        local result = eq.result
        local numbers = eq.numbers
        local start = table.remove(numbers, 1)

        if solve(copy_table(numbers), start, result) then
            total = total + result
        end
    end

    return total
end

return Day07
