function sec_to_table(sec)
    local ret = {}
    ret.day = math.floor(sec/(3600*24))
    ret.hour = math.floor((sec%(3600*24))/3600)
    ret.min = math.floor((sec%3600)/60)
    ret.sec = math.floor(sec%60)
    return ret
end
