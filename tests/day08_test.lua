local lu = require('luaunit')
local Day08 = require('src.day08')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part8a()
    local content = readFile("data/day08a.txt")
    lu.assertEquals(Day08.part1(content), 14)
end

function TestLibrary.test_part8b()
    local content = readFile("data/day08b.txt")
    lu.assertEquals(Day08.part2(content), 9)
end

function TestLibrary.test_part8bb()
    local content = readFile("data/day08a.txt")
    lu.assertEquals(Day08.part2(content), 34)
end

function TestLibrary.test_part8_1()
    local content = readFile("data/day08.txt")
    lu.assertEquals(Day08.part1(content), 259)
end
function TestLibrary.test_part8_2()
    local content = readFile("data/day08.txt")
    lu.assertEquals(Day08.part2(content), 927)
end

os.exit(lu.LuaUnit.run())


