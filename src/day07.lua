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

function solve_combine(numbers, total, result)
    if total == result and #numbers == 0 then
        return true
    end

    if #numbers == 0 then
        return false
    end

    local next = table.remove(numbers, 1)
    return solve_combine(copy_table(numbers), total + next, result) or
        solve_combine(copy_table(numbers), total * next, result) or
        solve_combine(copy_table(numbers), tonumber(tostring(total) .. tostring(next)), result)
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
        local start = table.remove(eq.numbers, 1)

        if solve(copy_table(eq.numbers), start, eq.result) then
            total = total + eq.result
        end
    end

    return total
end

function Day07.part2(content)
    local data = parse(content)
    local total = 0

    for _, eq in ipairs(data) do
        local start = table.remove(eq.numbers, 1)

        if solve_combine(copy_table(eq.numbers), start, eq.result) then
            total = total + eq.result
        end
    end

    return total
end

return Day07
