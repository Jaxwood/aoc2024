local Day03 = {}

function parse(content)
    local instructions = {}
    for _, line in ipairs(content) do
        for m, n in line:gmatch("mul%((%d%d?%d?),(%d%d?%d?)%)") do
            table.insert(instructions, { op = "mul", a = tonumber(m), b = tonumber(n) })
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

function findPattern(line, pattern, plain)
    local occurrences = {}
    local startIndex = 1
    while true do
        local foundStart, foundEnd, a, b = string.find(line, pattern, startIndex, plain)
        if not foundStart then
            break
        end

        table.insert(occurrences, { start = foundStart, finish = foundEnd, a = a, b = b })

        -- Move the search start to the character after the last found occurrence
        startIndex = foundEnd + 1
    end

    return occurrences
end

function Day03.part2(content)
    local totalOccurrences = {}
    for _, line in ipairs(content) do
        local occurrences = {}
        -- Find all occurrences of the don't function
        local matches = findPattern(line, "don't()", true)
        for _, match in ipairs(matches) do
            table.insert(occurrences,
                { op = "don't", start = match.start, finish = match.finish, a = match.a, b = match.b })
        end

        -- Find all occurrences of the do function
        matches = findPattern(line, "do()", true)
        for _, match in ipairs(matches) do
            table.insert(occurrences, { op = "do", start = match.start, finish = match.finish, a = match.a, b = match.b })
        end

        -- Find all occurrences of the mul function
        matches = findPattern(line, "mul%((%d%d?%d?),(%d%d?%d?)%)", false)
        for _, match in ipairs(matches) do
            table.insert(occurrences,
                { op = "mul", start = match.start, finish = match.finish, a = match.a, b = match.b })
        end

        table.insert(totalOccurrences, occurrences)
    end

    for _, occurrences in ipairs(totalOccurrences) do
        for _, occurrence in ipairs(occurrences) do
            print(occurrence.op, occurrence.start, occurrence.finish, occurrence.a, occurrence.b)
        end
    end

    return 0
end

return Day03
