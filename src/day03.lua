local Day03 = {}

function parse(content)
    local instructions = {}
    for _, line in ipairs(content) do
        for m, n in line:gmatch("mul%((%d%d?%d?),(%d%d?%d?)%)") do
            table.insert(instructions, {op = "mul", a = tonumber(m), b = tonumber(n)})
        end
    end

    return instructions
end

function Day03.part1(content)
    local instructions = parse(content)
    local sum = 0
    for _, instruction in ipairs(instructions) do
        if instruction.op == "mul" then
            sum = sum + (instruction.a * instruction.b)
        end
    end
    return sum
end

return Day03

