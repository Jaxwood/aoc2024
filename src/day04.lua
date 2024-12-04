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

--[[
--  Returns the word found in the puzzle starting at the given x, y position
--  and moving in all directions. If the word is not found, nil is returned.
--  We capture the indexes of the characters in the word so that we can
--  remove duplicates as the same word can be found multiple times.
--
--  Data structure of the word:
--  [{ x = number, y = number, char = string }]
--]]
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

