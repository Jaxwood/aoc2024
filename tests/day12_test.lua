local lu = require('luaunit')
local Day12 = require('src.day12')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part12a()
    local content = readFile("data/day12a.txt")
    lu.assertEquals(Day12.part1(content), 140)
end

function TestLibrary.test_part12b()
    local content = readFile("data/day12b.txt")
    lu.assertEquals(Day12.part1(content), 1930)
end

function TestLibrary.test_part12_1()
    local content = readFile("data/day12.txt")
    lu.assertEquals(Day12.part1(content), 1433460)
end

os.exit(lu.LuaUnit.run())

