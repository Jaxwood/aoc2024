local Day09 = {}

local function parse(content)
    local blocks = {}
    local idx = 0
    local totalBlocks = 0

    for _, line in ipairs(content) do
        for i = 1, #line, 2 do
            local block = line:sub(i, i)
            local free = line:sub(i + 1, i + 1)
            if tonumber(free) == nil then
                free = 0
            end
            totalBlocks = totalBlocks + tonumber(block) + tonumber(free)
            table.insert(blocks,
                { id = idx, block = tonumber(block), free = tonumber(free), storage = {}, moved = false })
            idx = idx + 1
        end
    end

    return blocks, totalBlocks
end

function Day09.part1(content)
    local disk, totalBlocks = parse(content)
    local movedBlocks = 0

    -- move blocks to free space
    -- from the end to the beginning
    for i = #disk, 1, -1 do
        local block = disk[i]

        -- move block to free space
        for _ = 1, block.block do
            for j = 1, #disk do
                if disk[j].free > 0 then
                    table.insert(disk[j].storage, block.id)
                    disk[j].free = disk[j].free - 1
                    movedBlocks = movedBlocks + 1
                    break
                end
            end
        end
    end

    -- calculate total
    local idx = 0
    local total = 0
    for i = 1, #disk do
        -- add blocks to total
        for _ = 1, disk[i].block do
            if idx < totalBlocks - movedBlocks then
                total = total + (disk[i].id * idx)
                idx = idx + 1
            end
        end
        -- add storage to total
        for j = 1, #disk[i].storage do
            if idx < totalBlocks - movedBlocks then
                total = total + (disk[i].storage[j] * idx)
                idx = idx + 1
            end
        end
    end

    return total
end

function Day09.part2(content)
    local disk, _ = parse(content)

    -- move blocks to free space
    -- from the end to the beginning
    for i = #disk, 1, -1 do
        local block = disk[i]

        -- move whole block to free space
        for j = 1, #disk do
            if disk[j].free >= block.block then
                for _ = 1, block.block do
                    table.insert(disk[j].storage, block.id)
                    disk[j].free = disk[j].free - 1
                end
                disk[i].moved = true
                break
            end
        end
    end

    -- calculate total
    local idx = 0
    local total = 0
    for i = 1, #disk do
        for j = 1, disk[i].block do
            if disk[i].moved then
            else
                total = total + (disk[i].id * idx)
            end
            idx = idx + 1
        end
        for j = 1, #disk[i].storage do
            total = total + (disk[i].storage[j] * idx)
            idx = idx + 1
        end
        for j = 1, disk[i].free do
            total = (total + 0 * idx)
            idx = idx + 1
        end
    end

    return total
end

return Day09
