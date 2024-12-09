local Day09 = {}

local function parse(content)
    local blocks = {}
    local idx = 0

    for i = 1, #content, 2 do
        local block = content:sub(i, i)
        local free = content:sub(i + 1, i + 1)
        if tonumber(free) == nil then
            free = 0
        end
        table.insert(blocks, { id = idx, block = tonumber(block), free = tonumber(free), storage = {} })
        idx = idx + 1
    end

    return blocks
end

local function reverse(disk)
    local reversed = {}

    for i = #disk, 1, -1 do
        table.insert(reversed, disk[i])
    end

    return reversed
end

function Day09.part1(content)
    local disk = parse(content[1])
    local reversed = reverse(disk)
    local movedBlock = 0

    for i = 1, #reversed do
        local block = reversed[i]

        -- go through the disk and find the first disk that has free space
        for _ = 1, block.block do
            for k = 1, #disk do
                if disk[k].free > 0 then
                    table.insert(disk[k].storage, block.id)
                    disk[k].free = disk[k].free - 1
                    movedBlock = movedBlock + 1
                    break
                end
            end
        end
    end

    local line = ""
    for i = 1, #disk do
        -- print the block id
        for j = 1, disk[i].block do
            line = line .. disk[i].id
        end
        -- print the block id in storage
        for j = 1, #disk[i].storage do
            line = line .. disk[i].storage[j]
        end
    end

    local total = 0
    local size = #line - movedBlock
    for i = 1, size do
        local val = tonumber(line:sub(i, i))
        total = total + (val * (i - 1))
    end

    return total
end

return Day09

