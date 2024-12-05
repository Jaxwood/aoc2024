local lu = require('luaunit')
local Day05 = require('src.day05')

TestLibrary = {}

function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_parta()
    local content = readFile("data/day05a.txt")
    lu.assertEquals(Day05.part1(content), 143)
end

os.exit(lu.LuaUnit.run())


