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

os.exit(lu.LuaUnit.run())

