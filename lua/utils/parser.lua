-- [JSON Parser with JavaScript](https://lihautan.com/json-parser-with-javascript)

local M = {}
local Private = {}

local index = 1
local json = ""

function Private:readChar(str, i)
  return string.sub(str, i, i)
end

function Private:read()
  return Private:readChar(json, index)
end

function Private:peek(str, i, j)
  if not j then
    j = 1
  end
  return Private:readChar(str, i + j)
end

function Private:advance(i)
  if not i then
    i = 1
  end
  index = index + i
end

function Private:skipWhitespace()
  while
    Private:read() == " "
    or Private:read() == "\n"
    or Private:read() == "\t"
    or Private:read() == "\r"
  do
    Private:advance()
  end
end

function Private:skipComma()
  if Private:read() ~= "," then
    error "Expected ,"
  end
  Private:advance()
end

function Private:skipColon()
  if Private:read() ~= ":" then
    error "Expected :"
  end
  Private:advance()
end

function Private:isHex(c)
  local is0To9 = c >= "0" and c <= "9"
  local is_a_to_f = string.lower(c) >= "a" and string.lower(c) <= "f"
  return is0To9 or is_a_to_f
end

function Private:parseString()
  local isSpecialChar = function(ch)
    return ch == '"'
      or ch == "\\"
      or ch == "/"
      or ch == "b"
      or ch == "f"
      or ch == "n"
      or ch == "r"
      or ch == "t"
  end

  if Private:read() == '"' then
    Private:advance()
    local result
    while Private:read() ~= '"' do
      if Private:read() == "\\" then
        local c = Private:peek(json, index)
        if isSpecialChar(c) then
          result = (result or "") .. c
          Private:advance()
        elseif c == "u" then
          if
            Private:isHex(Private:peek(json, index, 2))
            and Private:isHex(Private:peek(json, index, 3))
            and Private:isHex(Private:peek(json, index, 4))
            and Private:isHex(Private:peek(json, index, 5))
          then
            result = (result or "") .. string.sub(json, index + 2, index + 5)
            Private:advance(5)
          end
        end
      else
        result = (result or "") .. Private:read()
      end
      Private:advance()
    end
    if tonumber(result) ~= nil then
      result = tonumber(result)
    end
    Private:advance()
    return result
  end
  return nil
end

function Private:parseNumeric()
  local start = index

  local readNumeric = function()
    while Private:read() >= "0" and Private:read() <= "9" do
      Private:advance()
    end
  end

  if Private:read() == "-" then
    Private:advance()
  end
  if Private:read() == "0" then
    Private:advance()
  elseif Private:read() >= "1" and Private:read() <= "9" then
    Private:advance()
    readNumeric()
  end

  if Private:read() == "." then
    Private:advance()
    readNumeric()
  end

  if Private:read() == "e" or Private:read() == "E" then
    Private:advance()
    if Private:read() == "-" or Private:read() == "+" then
      Private:advance()
    end
    readNumeric()
  end

  if index > start then
    return tonumber(string.sub(json, start, index - 1))
  end

  return nil
end

function Private:parseKw(name, value)
  if string.sub(json, index, index + #name - 1) == name then
    index = index + #name
    return value
  end
end

function Private:parseObject()
  if Private:read() == "{" then
    Private:advance()
    Private:skipWhitespace()
    local result = {}
    local tail = false

    while Private:read() ~= "}" do
      if tail then
        Private:skipComma()
        Private:skipWhitespace()
      end

      local key = Private:parseString()
      Private:skipWhitespace()
      Private:skipColon()
      local value = Private:parseValue()
      if key then
        result[key] = value
      end
      tail = true
    end
    Private:advance()
    return result
  end
  return nil
end

function Private:parseArray()
  if Private:read() == "[" then
    Private:advance()
    Private:skipWhitespace()
    local result = {}
    local tail = false

    while Private:read() ~= "]" do
      if tail then
        Private:skipComma()
      end

      local value = Private:parseValue()
      table.insert(result, value)
      tail = true
    end
    Private:advance()
    return result
  end
  return nil
end

function Private:parseValue()
  Private:skipWhitespace()
  local value
  local str = Private:parseString()
  local num = Private:parseNumeric()
  local obj = Private:parseObject()
  local arr = Private:parseArray()
  local yes = Private:parseKw("true", true)
  local no = Private:parseKw("false", false)
  local null = Private:parseKw("null", nil)

  if str ~= nil then
    value = str
  elseif num ~= nil then
    value = num
  elseif obj ~= nil then
    value = obj
  elseif arr ~= nil then
    value = arr
  elseif yes == true then
    value = yes
  elseif no == false then
    value = no
  elseif null == nil then
    value = null
  end

  Private:skipWhitespace()
  return value
end

function M:parse(input)
  local file = io.open(input, "r")
  if file then
    json = file:read "*a"
    file:close()
    local value = Private:parseValue()
    if value then
      return true, value
    end
  end

  return false, {}
end

return M
