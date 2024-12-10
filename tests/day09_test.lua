local lu = require('luaunit')
local Day09 = require('src.day09')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part09a()
    local content = readFile("data/day09a.txt")
    lu.assertEquals(Day09.part1(content), 1928)
end

function TestLibrary.test_part09b()
    local content = readFile("data/day09a.txt")
    lu.assertEquals(Day09.part2(content), 2858)
end

function TestLibrary.test_part09_1()
    local content = readFile("data/day09.txt")
    lu.assertEquals(Day09.part1(content), 6366665108136)
end

function TestLibrary.test_part09_2()
    local content = readFile("data/day09.txt")           -- too low    96671935444
    lu.assertEquals(Day09.part2(content), 8607352322743) -- too high 8607352322743
end

os.exit(lu.LuaUnit.run())

