local lu = require('luaunit')
local Day17 = require('src.day17')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part17a()
    local content = readFile("data/day17a.txt")
    lu.assertEquals(Day17.part1(content), "4,6,3,5,6,3,5,2,1,0")
end

function TestLibrary.test_part17_1()
    local content = readFile("data/day17.txt")
    lu.assertEquals(Day17.part1(content), "2,3,6,2,1,6,1,2,1")
end

os.exit(lu.LuaUnit.run())

