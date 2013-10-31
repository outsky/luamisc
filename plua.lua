-- print lua variable in well-formatted format, especially for table

local function plua(v)
    local function str(t)
        return type(t)=="string" and ('"' .. string.gsub(t,"\n","\\n") .. '"') or tostring(t)
    end

    local reg = {}
    local function _plua(k,t,tab)
        local ret = ""
        if type(t)=="table" then
            if reg[t]~=nil then
                ret = ret .. reg[t] .. "\n"
            else
                reg[t] = tostring(k) .. "(" .. tostring(t) .. "),"
                ret = ret .. "{\n"
                local old = tab
                tab = tab .. "    "
                for k,v in pairs(t) do
                    ret = ret .. tab .. tostring(k) .. " = " .. _plua(k,v,tab)
                end
                ret = ret .. old .. "}, --" .. tostring(k) .. "\n"
            end
        else
            ret = ret .. str(t) .. ",\n"
        end
        return ret
    end

    return _plua("root", v, "")
end

-- test
print(plua(_G))
