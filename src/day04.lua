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

local directions = { { { x = 0, y = 0, c = 'X' }, { x = -1, y = 0, c = 'M' }, { x = -2, y = 0, c = 'A' }, { x = -3, y = 0, c = 'S' } },
    { { x = 0, y = 0, c = 'X' }, { x = 1, y = 0, c = 'M' },   { x = 2, y = 0, c = 'A' },   { x = 3, y = 0, c = 'S' } },
    { { x = 0, y = 0, c = 'X' }, { x = 0, y = -1, c = 'M' },  { x = 0, y = -2, c = 'A' },  { x = 0, y = -3, c = 'S' } },
    { { x = 0, y = 0, c = 'X' }, { x = 0, y = 1, c = 'M' },   { x = 0, y = 2, c = 'A' },   { x = 0, y = 3, c = 'S' } },
    { { x = 0, y = 0, c = 'X' }, { x = -1, y = -1, c = 'M' }, { x = -2, y = -2, c = 'A' }, { x = -3, y = -3, c = 'S' } },
    { { x = 0, y = 0, c = 'X' }, { x = 1, y = -1, c = 'M' },  { x = 2, y = -2, c = 'A' },  { x = 3, y = -3, c = 'S' } },
    { { x = 0, y = 0, c = 'X' }, { x = -1, y = 1, c = 'M' },  { x = -2, y = 2, c = 'A' },  { x = -3, y = 3, c = 'S' } },
    { { x = 0, y = 0, c = 'X' }, { x = 1, y = 1, c = 'M' },   { x = 2, y = 2, c = 'A' },   { x = 3, y = 3, c = 'S' } } }

function wordSearch(x, y, puzzle)
    local total = 0
    for _, direction in ipairs(directions) do
        local match = true
        for _, search in ipairs(direction) do
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
    end

    return total
end

function Day04.part1(content)
    local puzzle = parse(content)
    local sum = 0

    for y, line in ipairs(puzzle) do
        for x, _ in ipairs(line) do
            sum = sum + wordSearch(x, y, puzzle)
        end
    end

    return sum
end

return Day04
