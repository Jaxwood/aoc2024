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

os.exit(lu.LuaUnit.run())



