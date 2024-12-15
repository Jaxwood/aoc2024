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

local function get_matching_side(map, box, direction)
    local tile = map[box.y][box.x]

    if tile == LEFTBOX then
        return { x = box.x + 1, y = box.y }
    else
        return { x = box.x - 1, y = box.y }
    end
end

local function can_move_wide(map, robot, direction)
    -- we can't move walls
    if map[robot.y][robot.x] == WALL then
        return false
    end

    -- we can move to an open space
    if map[robot.y][robot.x] == OPEN then
        return true
    end

    -- found box
    -- find match side for the box
    local side = get_matching_side(map, robot, direction)

    if direction == LEFT or direction == RIGHT then
        return can_move_wide(map, move_to(robot, direction), direction)
    else
        return can_move_wide(map, move_to(robot, direction), direction) and
            can_move_wide(map, move_to(side, direction), direction)
    end
end

local function contains(list, item)
    for _, i in ipairs(list) do
        if i.x == item.x and i.y == item.y then
            return true
        end
    end

    return false
end

local function push(map, side1, side2, direction)
    local queue = { side1, side2 }
    local boxes_to_move = {}

    -- find all the boxes that needs moving
    while #queue > 0 do
        local box = table.remove(queue, 1)

        if not contains(boxes_to_move, box) then
            table.insert(boxes_to_move, box)
        end

        local next = move_to(box, direction)

        if map[next.y][next.x] == RIGHTBOX or map[next.y][next.x] == LEFTBOX then
            local side = get_matching_side(map, next, direction)
            table.insert(queue, next)
            table.insert(queue, side)
        end
    end

    -- sort the boxes to avoid overriding the boxes
    table.sort(boxes_to_move, function(a, b)
        if direction == UP then
            return a.y < b.y
        else
            return a.y > b.y
        end
    end)

    -- now we can move the boxes
    for _, box in ipairs(boxes_to_move) do
        local next = move_to(box, direction)
        map[next.y][next.x] = map[box.y][box.x]
        map[box.y][box.x] = OPEN
    end
end

local function push_boxes_wide(map, box, direction)
    -- we should never hit this case
    if map[box.y][box.x] ~= LEFTBOX and map[box.y][box.x] ~= RIGHTBOX then
        return error("Not a box")
    end

    -- next box to move
    local next = move_to(box, direction)

    -- handle case for pushing boxes up or down
    if direction == UP or direction == DOWN then
        local side = get_matching_side(map, box, direction)
        push(map, box, side, direction)
    else -- moving left or right
        while map[next.y][next.x] == LEFTBOX or map[next.y][next.x] == RIGHTBOX do
            -- update map
            if map[next.y][next.x] == LEFTBOX then
                map[next.y][next.x] = RIGHTBOX
            else
                map[next.y][next.x] = LEFTBOX
            end
            next = move_to(next, direction)
        end

        -- update map
        map[box.y][box.x] = OPEN

        map[next.y][next.x] = direction == RIGHT and RIGHTBOX or LEFTBOX
    end
end

local function move_wide(map, robot, direction)
    local next = move_to(robot, direction)
    -- move box
    if can_move_wide(map, next, direction) then
        -- move robot as the space is open
        if map[next.y][next.x] == OPEN then
            return map, next
        else -- we hit a box and we can move it
            push_boxes_wide(map, next, direction)
            return map, next
        end
    else -- can't move; stay in the same place
        return map, robot
    end
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
    local map, movements = parse(content, true)
    local robot = find_robot(map)

    -- move the robot according to the rules of the game
    for m = 1, #movements do
        map, robot = move_wide(map, robot, movements[m])
    end

    return calculate_score(map)
end

return Day15

