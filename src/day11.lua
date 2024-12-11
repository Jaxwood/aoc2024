local Day11 = {}

local function parse(content)
    local nums = {}

    for y = 1, #content do
        for num in content[y]:gmatch("(%d+)") do
            table.insert(nums, tonumber(num))
        end
    end

    return nums
end

function Day11.part1(content)
    local nums = parse(content)
    local iterations = 25

    for _ = 1, iterations do
        local newnums = {}

        for _, num in ipairs(nums) do
            if num == 0 then
                table.insert(newnums, 1)
            elseif #tostring(num) % 2 == 0 then
                local newnum = tostring(num)
                local half = #newnum / 2
                table.insert(newnums, tonumber(newnum:sub(1, half)))
                table.insert(newnums, tonumber(newnum:sub(half + 1, #newnum)))
            else
                table.insert(newnums, num * 2024)
            end
        end

        nums = newnums
    end

    return #nums
end

return Day11

