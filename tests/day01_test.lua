local lu = require('luaunit')
local Day01 = require('src.day01')

TestLibrary = {}

function TestLibrary.test_part1()
    lu.assertEquals(0, Day01.part1())
end

os.exit(lu.LuaUnit.run())

