local lu = require('luaunit')
local Day20 = require('src.day20')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part20a()
    local content = readFile("data/day20a.txt")
    lu.assertEquals(Day20.part1(content, 2, 0), 211)
end

function TestLibrary.test_part20b()
    local content = readFile("data/day20a.txt")
    lu.assertEquals(Day20.part1(content, 20, 50), 285)
end

function TestLibrary.test_part20_1()
    local content = readFile("data/day20.txt")
    lu.assertEquals(Day20.part1(content, 2, 100), 1293)
end

function TestLibrary.test_part20_2()
    local content = readFile("data/day20.txt")
    lu.assertEquals(Day20.part1(content, 20, 100), 977747)
end

os.exit(lu.LuaUnit.run())


