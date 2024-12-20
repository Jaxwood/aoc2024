local lu = require('luaunit')
local Day18 = require('src.day18')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part18a()
    local content = readFile("data/day18a.txt")
    lu.assertEquals(Day18.part1(content, 12, 6), 22)
end

function TestLibrary.test_part18_1()
    local content = readFile("data/day18.txt")
    lu.assertEquals(Day18.part1(content, 1024, 70), 326)
end

os.exit(lu.LuaUnit.run())

