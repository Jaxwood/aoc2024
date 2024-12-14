local lu = require('luaunit')
local Day14 = require('src.day14')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part14a()
    local content = readFile("data/day14a.txt")
    lu.assertEquals(Day14.part1(content, 11, 7, 100), 12)
end

function TestLibrary.test_part14_1()
    local content = readFile("data/day14.txt")
    lu.assertEquals(Day14.part1(content, 101, 103, 100), 229632480)
end

os.exit(lu.LuaUnit.run())

