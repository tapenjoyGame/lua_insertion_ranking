-- lua_flatbuffers test


function var_dump(data, max_level, prefix)
    if type(prefix) ~= "string" then
        prefix = ""
    end

    if type(data) ~= "table" then
        print(prefix .. tostring(data))
    else
        print(data)
        if max_level ~= 0 then
            local prefix_next = prefix .. "    "
            print(prefix .. "{")
            for k,v in pairs(data) do
                io.stdout:write(prefix_next .. k .. " = ")
                if type(v) ~= "table" or (type(max_level) == "number" and max_level <= 1) then
                    print(v)
                else
                    if max_level == nil then
                        var_dump(v, nil, prefix_next)
                    else
                        var_dump(v, max_level - 1, prefix_next)
                    end
                end
            end
            print(prefix .. "}")
        end
    end
end

--[[
    eg: local b = {aaa="aaa",bbb="bbb",ccc="ccc"}
]]
function vd(data, max_level)
    var_dump(data, max_level or 20)
end

local MIN_RAND = 0
local MAX_RAND = 200
math.randomseed( os.time() )

local Lir = require "lua_insertion_ranking"

local lir = Lir( "test.lir","name","age","rate" )

for key_id = 1,10 do
    local factor1 = math.random( MIN_RAND,MAX_RAND )
    local factor2 = math.random( MIN_RAND,MAX_RAND )
    lir:set_factor( key_id,factor1,factor2 );
end

lir:set_one_value( 5,"name","lir5" )

lir:dump()
-- lir:dump( "test.lir" )
-- print( string.format("simple benchmark test %d times,encode elapsed time: %.2f second,decode elapsed time: %.2f second",
--     max,sy - sx,ey - ex))
