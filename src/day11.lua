local Day11 = {}

local function parse(content)
    local nums = {}

    for y = 1, #content do
        for num in content[y]:gmatch("(%d+)") do
            local n = tonumber(num)
            nums[n] = 1
        end
    end

    return nums
end

local function split_number(number)
    local digit_count = math.floor(math.log10(number)) + 1

    -- Calculate the split point
    local half_digits = digit_count // 2

    -- Split the number
    local first_part = math.floor(number / (10 ^ half_digits))
    local second_part = number % (10 ^ half_digits)

    return { first_part, math.floor(second_part) }
end

function Day11.part1(content, iterations)
    local nums = parse(content)

    for i = 1, iterations do
        local next = {}
        for num, val in pairs(nums) do
            -- If the number is 0, the stone becomes 1
            if num == 0 then
                next[1] = (next[1] or 0) + val
            -- If the number is even, the stone splits into two stones
            elseif (#tostring(num)) % 2 == 0 then
                local ns = split_number(num)
                for _, n in ipairs(ns) do
                    next[n] = (next[n] or 0) + val
                end
            -- otherwise, the stone is multiplied by 2024
            else
                local n = num * 2024
                next[n] = val
            end
        end
        nums = next
    end

    -- Calculate the sum of the stones
    local sum = 0
    for _, val in pairs(nums) do
        sum = sum + val
    end

    return sum
end

return Day11
