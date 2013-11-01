-- print lua variable in well-formatted format, especially for table

local function plua(v)
    local function str(t)
        return type(t)=="string" and ('"' .. string.gsub(t,"\n","\\n") .. '"') or tostring(t)
    end

    local reg = {}
    local ret = {}
    local function _plua(k,t,tab)
        if type(t)=="table" then
            if reg[t]~=nil then
                ret[#ret+1] = reg[t] .. "\n"
            else
                reg[t] = tostring(k) .. "(" .. tostring(t) .. "),"
                ret[#ret+1] = "{\n"
                local old = tab
                tab = tab .. "    "
                for k,v in pairs(t) do
                    ret[#ret+1] = tab .. tostring(k) .. " = "
                    _plua(k,v,tab)
                end
                ret[#ret+1] = old .. "}, --" .. tostring(k) .. "\n"
            end
        else
            ret[#ret+1] = str(t) .. ",\n"
        end
    end

    _plua("root", v, "")
    return table.concat(ret)
end

-- test
print(plua(_G))
