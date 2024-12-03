local lu = require('luaunit')
local Day03 = require('src.day03')

TestLibrary = {}

function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_parta()
    local content = readFile("data/day03a.txt")
    lu.assertEquals(Day03.part1(content), 161)
end

os.exit(lu.LuaUnit.run())



