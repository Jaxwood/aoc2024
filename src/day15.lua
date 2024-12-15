local Day15 = {}

-- tiles
local WALL = 0
local OPEN = 1
local BOX = 2
local LEFTBOX = 3
local RIGHTBOX = 4
local ROBOT = 5

-- movements
local LEFT = 0
local RIGHT = 1
local UP = 2
local DOWN = 3

local function parse_movement(c)
    if c == "<" then
        return LEFT
    elseif c == ">" then
        return RIGHT
    elseif c == "^" then
        return UP
    elseif c == "v" then
        return DOWN
    end
end

local function parse_tile(c, wide)
    if c == "#" then
        return wide and { WALL, WALL } or { WALL }
    elseif c == "." then
        return wide and { OPEN, OPEN } or { OPEN }
    elseif c == "O" then
        return wide and { LEFTBOX, RIGHTBOX } or { BOX }
    else
        return wide and { ROBOT, OPEN } or { ROBOT }
    end
end

local function parse(content, wide)
    local is_movement = false
    local map = {}
    local movements = {}

    for y, line in ipairs(content) do
        if line == "" then
            is_movement = true
        elseif is_movement then
            for x = 1, #line do
                local c = line:sub(x, x)
                table.insert(movements, parse_movement(c))
            end
        else
            for x = 1, #line do
                local c = line:sub(x, x)
                local tile = parse_tile(c, wide)
                for _, t in ipairs(tile) do
                    if not map[y] then
                        map[y] = {}
                    end
                    table.insert(map[y], t)
                end
            end
        end
    end

    return map, movements
end

local find_robot = function(map)
    for y, row in ipairs(map) do
        for x, cell in ipairs(row) do
            if cell == ROBOT then
                map[y][x] = OPEN
                return { x = x, y = y }
            end
        end
    end
end

-- helper function to print the map
local print_map = function(map, robot)
    print()
    for y, row in ipairs(map) do
        local line = ""
        for x, cell in ipairs(row) do
            if x == robot.x and y == robot.y then
                line = line .. "@"
            elseif cell == WALL then
                line = line .. "#"
            elseif cell == OPEN then
                line = line .. "."
            elseif cell == BOX then
                line = line .. "O"
            elseif cell == LEFTBOX then
                line = line .. "["
            elseif cell == RIGHTBOX then
                line = line .. "]"
            elseif cell == ROBOT then
                line = line .. "@"
            end
        end
        print(line)
    end
end

-- move robot to the next position
local function move_to(from, direction)
    if direction == LEFT then
        return { x = from.x - 1, y = from.y }
    elseif direction == RIGHT then
        return { x = from.x + 1, y = from.y }
    elseif direction == UP then
        return { x = from.x, y = from.y - 1 }
    elseif direction == DOWN then
        return { x = from.x, y = from.y + 1 }
    end
end

local function can_move(map, robot, direction)
    -- we can't move walls
    if map[robot.y][robot.x] == WALL then
        return false
    end

    -- we can move to an open space
    if map[robot.y][robot.x] == OPEN then
        return true
    end

    -- found another box
    -- check if that box can also be moved
    return can_move(map, move_to(robot, direction), direction)
end

local function push_boxes(map, box, direction)
    -- we should never hit this case
    if map[box.y][box.x] ~= BOX then
        return error("Not a box")
    end

    -- update map
    map[box.y][box.x] = OPEN

    -- move boxes
    local next = move_to(box, direction)
    while map[next.y][next.x] == BOX do
        -- update map
        map[next.y][next.x] = BOX
        next = move_to(next, direction)
    end

    map[next.y][next.x] = BOX
end

local function move(map, robot, direction)
    local next = move_to(robot, direction)
    -- move box
    if can_move(map, next, direction) then
        -- move robot as the space is open
        if map[next.y][next.x] == OPEN then
            return map, next
        else -- we hit a box and we can move it
            push_boxes(map, next, direction)
            return map, next
        end
    else -- can't move; stay in the same place
        return map, robot
    end
end

local function calculate_score(map)
    local score = 0
    for y, row in ipairs(map) do
        for x, cell in ipairs(row) do
            if cell == BOX or cell == LEFTBOX then
                -- subtract 1 from x and y as the index starts from 1 in lua
                score = score + (((y - 1) * 100) + (x - 1))
            end
        end
    end

    return score
end

function Day15.part1(content)
    local map, movements = parse(content, false)
    local robot = find_robot(map)

    -- move the robot according to the rules of the game
    for m = 1, #movements do
        map, robot = move(map, robot, movements[m])
    end

    return calculate_score(map)
end

function Day15.part2(content)
    local map, _ = parse(content, true)
    local robot = find_robot(map)

    print_map(map, robot)

    return calculate_score(map)
end

return Day15
