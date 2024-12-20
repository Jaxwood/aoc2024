local Day20 = {}

local OPEN = "."
local WALL = "#"
local start = "S"
local finish = "E"

local function parse(content)
    local racetrack = {}
    local from = {}
    local to = {}

    for y, line in ipairs(content) do
        for x = 1, string.len(line) do
            local c = string.sub(line, x, x)
            if racetrack[y] == nil then
                racetrack[y] = {}
            end
            if c == OPEN then
                racetrack[y][x] = 1
            elseif c == WALL then
                racetrack[y][x] = 2
            elseif c == start then
                racetrack[y][x] = 1
                from = { x, y }
            elseif c == finish then
                racetrack[y][x] = 1
                to = { x, y }
            else
                assert(false, "Unknown character: " .. c)
            end
        end
    end

    return racetrack, from, to
end

local neighbors = {
    { 0, -1 },
    { 0, 1 },
    { -1, 0 },
    { 1, 0 }
}

function Day20.part1(content)
    local racetrack, from, to = parse(content)

    local unvisited = {}
    local score = {}

    -- initialize the score and unvisited list
    for y, row in ipairs(racetrack) do
        score[y] = score[y] or {}
        for x, cell in ipairs(row) do
            if cell == 1 then
                table.insert(unvisited, { x, y })
                score[y][x] = math.huge
            end
            if x == from[1] and y == from[2] then
                score[y][x] = 0
            end
        end
    end

    while #unvisited > 0 do
        -- get the current field with the lowest score
        table.sort(unvisited, function(a, b)
            return score[a[2]][a[1]] < score[b[2]][b[1]]
        end)
        local current = table.remove(unvisited, 1)

        -- if we reached the end, then return the score
        if current[1] == to[1] and current[2] == to[2] then
            return score[current[2]][current[1]]
        end

        -- check the neighbors
        for _, neighbor in ipairs(neighbors) do
            local x = current[1] + neighbor[1]
            local y = current[2] + neighbor[2]

            -- check in bounds
            if x >= 1 and x <= #racetrack[1] and y >= 1 and y <= #racetrack then
                -- check if the field is open
                if racetrack[y][x] == 1 then
                    -- calculate the tentative score and update the score if it's lower
                    local tentative_score = score[current[2]][current[1]] + 1
                    if tentative_score < score[y][x] then
                        score[y][x] = tentative_score
                    end
                end
            end
        end
    end

    assert(false, "No path found")
end

return Day20
