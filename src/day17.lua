local Day17 = {}

local A = 4
local B = 5
local C = 6

local function parse(content)
    local newline = false
    local ops = {}
    local registers = {}
    for _, line in ipairs(content) do
        if not newline then
            local register, num = line:match("Register%s([A-Z]):%s(%d+)")

            if not register then
                newline = not register
            else
                if register == 'A' then
                    registers[4] = tonumber(num)
                elseif register == 'B' then
                    registers[5] = tonumber(num)
                elseif register == 'C' then
                    registers[6] = tonumber(num)
                else
                    assert(false, "Unknown register: " .. register)
                end
            end
        else
            local idx = 0
            for num in line:gmatch("(%d+)") do
                ops[idx] = tonumber(num)
                idx = idx + 1
            end
        end
    end
    return registers, ops
end

local function read(register, operand)
    assert(operand ~= 7, "A valid program should not use operand 7")
    if register[operand] then
        return register[operand]
    else
        return tonumber(operand)
    end
end

function handle(opcode, operand, register, result)
    if opcode == 0 then -- division store in register A
        register[A] =  math.floor(register[A] / (2 ^ read(register, operand)))
    elseif opcode == 1 then -- bitwise XOR
        register[B] = register[B] ~ operand
    elseif opcode == 2 then -- modulus
        register[B] = (read(register, operand) % 8)
    elseif opcode == 3 then -- jump if register A is not zero
        return register[A] ~= 0, operand
    elseif opcode == 4 then -- bitwise XOR
        register[B] = register[B] ~ register[C]
    elseif opcode == 5 then -- output
        table.insert(result, read(register, operand) % 8)
    elseif opcode == 6 then -- division store in register B
        register[B] =  math.floor(register[A] / (2 ^ read(register, operand)))
    elseif opcode == 7 then -- division store in register C
        register[C] =  math.floor(register[A] / (2 ^ read(register, operand)))
    else
        assert(false, "A valid program should not use opcode 8")
    end

    return false, 0
end

function Day17.part1(content)
    local registers, program = parse(content)
    local result = {}
    local pointer = 0

    while pointer <= #program do
        local opcode = program[pointer]
        local operand = program[pointer + 1]
        local succss, ptr = handle(opcode, operand, registers, result)
        if succss then
            pointer = ptr
        else
            pointer = pointer + 2
        end
    end

    return table.concat(result, ",")
end

return Day17

