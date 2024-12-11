local lu = require('luaunit')
local Day11 = require('src.day11')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part11a()
    local content = readFile("data/day11a.txt")
    lu.assertEquals(Day11.part1(content, 25), 55312)
end

function TestLibrary.test_part11_1()
    local content = readFile("data/day11.txt")
    lu.assertEquals(Day11.part1(content, 25), 183484)
end

function TestLibrary.test_part11_2()
    local content = readFile("data/day11.txt")
    lu.assertEquals(Day11.part1(content, 75), 218817038947400)
end

os.exit(lu.LuaUnit.run())


