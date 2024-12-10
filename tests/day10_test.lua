local lu = require('luaunit')
local Day10 = require('src.day10')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part10a()
    local content = readFile("data/day10a.txt")
    lu.assertEquals(Day10.part1(content), 36)
end

function TestLibrary.test_part10b()
    local content = readFile("data/day10a.txt")
    lu.assertEquals(Day10.part2(content), 81)
end

function TestLibrary.test_part10_1()
    local content = readFile("data/day10.txt")
    lu.assertEquals(Day10.part1(content), 468)
end

function TestLibrary.test_part10_2()
    local content = readFile("data/day10.txt")
    lu.assertEquals(Day10.part2(content), 966)
end

os.exit(lu.LuaUnit.run())

