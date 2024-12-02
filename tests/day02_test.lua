local lu = require('luaunit')
local Day02 = require('src.day01')

TestLibrary = {}

function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_parta()
    local content = readFile("data/day02a.txt")
    lu.assertEquals(2, Day02.part1(content))
end

os.exit(lu.LuaUnit.run())


