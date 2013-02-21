local import = function(t)
    local ret = { }
    if type(t[1]) == 'table' then
        ret = table.remove(t, 1)
    end
    
    local function patchName(n)
        if string.find(n, '.', 1, true) then
            local ret
            n:gsub("%.(.*)", function(x) ret = x end)
            return assert(ret, "import: internal error: unable to extract module name past '.'")
        end
        return n
    end
    
    for k, v in pairs(t) do
        if type(k) == 'number' then
            ret[patchName(v)] = require(v)
        else
            ret[patchName(k)] = require(v)
        end
    end
    return ret
end

_ENV = { }
--for k, v in pairs(
import{ _ENV,
        "math",
        os_table = 'os',
        'foo.bar',
        baz = 'foo.bar',
    }
--   ) do
for k, v in pairs(_ENV) do
    print(k, v)
end
    
