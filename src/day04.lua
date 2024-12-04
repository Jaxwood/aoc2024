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

local searchLeft = { { x = 0, y = 0, c = 'X' }, { x = -1, y = 0, c = 'M' }, { x = -2, y = 0, c = 'A' }, { x = -3, y = 0, c = 'S' } }
local searchRight = { { x = 0, y = 0, c = 'X' }, { x = 1, y = 0, c = 'M' }, { x = 2, y = 0, c = 'A' }, { x = 3, y = 0, c = 'S' } }
local searchUp = { { x = 0, y = 0, c = 'X' }, { x = 0, y = -1, c = 'M' }, { x = 0, y = -2, c = 'A' }, { x = 0, y = -3, c = 'S' } }
local searchDown = { { x = 0, y = 0, c = 'X' }, { x = 0, y = 1, c = 'M' }, { x = 0, y = 2, c = 'A' }, { x = 0, y = 3, c = 'S' } }
local searchUpLeft = { { x = 0, y = 0, c = 'X' }, { x = -1, y = -1, c = 'M' }, { x = -2, y = -2, c = 'A' }, { x = -3, y = -3, c = 'S' } }
local searchUpRight = { { x = 0, y = 0, c = 'X' }, { x = 1, y = -1, c = 'M' }, { x = 2, y = -2, c = 'A' }, { x = 3, y = -3, c = 'S' } }
local searchDownLeft = { { x = 0, y = 0, c = 'X' }, { x = -1, y = 1, c = 'M' }, { x = -2, y = 2, c = 'A' }, { x = -3, y = 3, c = 'S' } }
local searchDownRight = { { x = 0, y = 0, c = 'X' }, { x = 1, y = 1, c = 'M' }, { x = 2, y = 2, c = 'A' }, { x = 3, y = 3, c = 'S' } }

function wordSearch(x, y, puzzle, searchTerm)
    local total = 0
    -- check left
    local match = true
    for _, search in ipairs(searchLeft) do
        local newX = x + search.x
        local newY = y + search.y
        if newX < 1 or newX > #puzzle[1] or newY < 1 or newY > #puzzle then
            match = false
            break
        end
        if puzzle[newY][newX] ~= search.c then
            match = false
            break
        end
    end
    if match then
        total = total + 1
    else
        match = true
    end

    -- check right
    for _, search in ipairs(searchRight) do
        local newX = x + search.x
        local newY = y + search.y
        if newX < 1 or newX > #puzzle[1] or newY < 1 or newY > #puzzle then
            match = false
            break
        end
        if puzzle[newY][newX] ~= search.c then
            match = false
            break
        end
    end
    if match then
        total = total + 1
    else
        match = true
    end
    -- check up
    for _, search in ipairs(searchUp) do
        local newX = x + search.x
        local newY = y + search.y
        if newX < 1 or newX > #puzzle[1] or newY < 1 or newY > #puzzle then
            match = false
            break
        end
        if puzzle[newY][newX] ~= search.c then
            match = false
            break
        end
    end
    if match then
        total = total + 1
    else
        match = true
    end
    -- check down
    for _, search in ipairs(searchDown) do
        local newX = x + search.x
        local newY = y + search.y
        if newX < 1 or newX > #puzzle[1] or newY < 1 or newY > #puzzle then
            match = false
            break
        end
        if puzzle[newY][newX] ~= search.c then
            match = false
            break
        end
    end
    if match then
        total = total + 1
    else
        match = true
    end
    -- check up-left
    for _, search in ipairs(searchUpLeft) do
        local newX = x + search.x
        local newY = y + search.y
        if newX < 1 or newX > #puzzle[1] or newY < 1 or newY > #puzzle then
            match = false
            break
        end
        if puzzle[newY][newX] ~= search.c then
            match = false
            break
        end
    end
    if match then
        total = total + 1
    else
        match = true
    end
    -- check up-right
    for _, search in ipairs(searchUpRight) do
        local newX = x + search.x
        local newY = y + search.y
        if newX < 1 or newX > #puzzle[1] or newY < 1 or newY > #puzzle then
            match = false
            break
        end
        if puzzle[newY][newX] ~= search.c then
            match = false
            break
        end
    end
    if match then
        total = total + 1
    else
        match = true
    end
    -- check down-left
    for _, search in ipairs(searchDownLeft) do
        local newX = x + search.x
        local newY = y + search.y
        if newX < 1 or newX > #puzzle[1] or newY < 1 or newY > #puzzle then
            match = false
            break
        end
        if puzzle[newY][newX] ~= search.c then
            match = false
            break
        end
    end
    if match then
        total = total + 1
    else
        match = true
    end
    -- check down-right
    for _, search in ipairs(searchDownRight) do
        local newX = x + search.x
        local newY = y + search.y
        if newX < 1 or newX > #puzzle[1] or newY < 1 or newY > #puzzle then
            match = false
            break
        end
        if puzzle[newY][newX] ~= search.c then
            match = false
            break
        end
    end
    if match then
        total = total + 1
    else
        match = true
    end

    return total
end

function Day04.part1(content)
    local puzzle = parse(content)
    local searchTerm = "XMAS"
    local sum = 0

    for y, line in ipairs(puzzle) do
        for x, _ in ipairs(line) do
            sum = sum + wordSearch(x, y, puzzle, searchTerm)
        end
    end

    return sum
end

return Day04

