local lu = require('luaunit')
local Day04 = require('src.day04')

TestLibrary = {}

function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_parta()
    local content = readFile("data/day04a.txt")
    lu.assertEquals(Day04.part1(content), 18)
end

os.exit(lu.LuaUnit.run())

