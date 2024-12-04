local Day04 = {}

function parse(content)
    local puzzle = {}
    for y, line in ipairs(content) do
        for x = 1, #line do
            if not puzzle[y] then
                puzzle[y] = {}
            end
            puzzle[y][x] = line:sub(x, x)
        end
    end
    return puzzle
end

function wordSearch(x, y, puzzle, searchTerm)
    return nil
end

function Day04.part1(content)
    local puzzle = parse(content)
    local searchTerm = "XMAS"

    local words = {}
    for y, line in ipairs(puzzle) do
        for x, _ in ipairs(line) do
            local word = wordSearch(x, y, puzzle, searchTerm)
            if word then
                table.insert(words, word)
            end
        end
    end
    return 0
end

return Day04

