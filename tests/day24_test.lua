local lu = require('luaunit')
local Day24 = require('src.day24')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part24a_1()
    local content = readFile("data/day24a.txt")
    lu.assertEquals(Day24.part1(content), 2024)
end

function TestLibrary.test_part24_1()
    local content = readFile("data/day24.txt")
    lu.assertEquals(Day24.part1(content), 57344080719736)
end

function TestLibrary.test_part24_2()
    local content = readFile("data/day24.txt")
    lu.assertEquals(Day24.part2(content), "cgq,fnr,kqk,nbc,svm,z15,z23,z39")
end

os.exit(lu.LuaUnit.run())
