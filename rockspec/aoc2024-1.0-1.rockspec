package = "aoc2024"
version = "1.0-1"

source = {
    url = "git://github.com/jaxwood/aoc2024.git",
    tag = "v1.0"
}

description = {
    summary = "Advent of Code 2024",
    license = "MIT"
}

dependencies = {
    "lua >= 5.4",
    "luaunit >= 3.4"
}

build = {
   type = "builtin",
   modules = (function()
      local modules = {}
      for file in io.popen("find src -name '*.lua'"):lines() do
         local module_name = file:gsub("^src/", ""):gsub("%.lua$", ""):gsub("/", ".")
         modules[module_name] = file
      end
      return modules
   end)()
}
