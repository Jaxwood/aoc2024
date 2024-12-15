local Day15 = {}

local WALL = 0
local OPEN = 1
local BOX = 2

local LEFT = 0
local RIGHT = 1
local UP = 2
local DOWN = 3

local function parse(content)
    local is_movement = false
    local map = {}
    local movements = {}
    local robot = nil

    for y, line in ipairs(content) do
        if line == "" then
            is_movement = true
        elseif is_movement then
            for x = 1, #line do
                local c = line:sub(x, x)
                if c == "<" then
                    table.insert(movements, LEFT)
                elseif c == ">" then
                    table.insert(movements, RIGHT)
                elseif c == "^" then
                    table.insert(movements, UP)
                elseif c == "v" then
                    table.insert(movements, DOWN)
                end
            end
        else
            for x = 1, #line do
                local c = line:sub(x, x)
                if c == "#" then
                    if not map[y] then
                        map[y] = {}
                    end
                    map[y][x] = WALL
                elseif c == "." then
                    if not map[y] then
                        map[y] = {}
                    end
                    map[y][x] = OPEN
                elseif c == "O" then
                    if not map[y] then
                        map[y] = {}
                    end
                    map[y][x] = BOX
                else
                    if not map[y] then
                        map[y] = {}
                    end
                    map[y][x] = OPEN
                    robot = { x = x, y = y }
                end
            end
        end
    end

    return map, movements, robot
end

function Day15.part1(content)
    local map, movements, robot = parse(content)

    return 0
end

return Day15
