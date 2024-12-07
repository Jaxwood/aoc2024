local lu = require('luaunit')
local Day07 = require('src.day07')

TestLibrary = {}

function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_parta()
    local content = readFile("data/day07a.txt")
    lu.assertEquals(Day07.part1(content), 3749)
end

os.exit(lu.LuaUnit.run())


