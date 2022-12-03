-- [JSON Parser with JavaScript](https://lihautan.com/json-parser-with-javascript)

local M = {}

local index = 1
local json = ""
local init = false

function M:readChar(str, i)
  return string.sub(str, i, i)
end

function M:read()
  return M:readChar(json, index)
end

function M:peek(str, i, j)
  if not j then
    j = 1
  end
  return M:readChar(str, i + j)
end

function M:advance(i)
  if not i then
    i = 1
  end
  index = index + i
end

function M:skipWhitespace()
  while
    M:read() == " "
    or M:read() == "\n"
    or M:read() == "\t"
    or M:read() == "\r"
  do
    M:advance()
  end
end

function M:skipComma()
  if M:read() ~= "," then
    error "Expected ,"
  end
  M:advance()
end

function M:skipColon()
  if M:read() ~= ":" then
    error "Expected :"
  end
  M:advance()
end

function M:isHex(c)
  local is0To9 = c >= "0" and c <= "9"
  local is_a_to_f = string.lower(c) >= "a" and string.lower(c) <= "f"
  return is0To9 or is_a_to_f
end

function M:parseString()
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

  if M:read() == '"' then
    M:advance()
    local result
    while M:read() ~= '"' do
      if M:read() == "\\" then
        local c = M:peek(json, index)
        if isSpecialChar(c) then
          result = (result or "") .. c
          M:advance()
        elseif c == "u" then
          if
            M:isHex(M:peek(json, index, 2))
            and M:isHex(M:peek(json, index, 3))
            and M:isHex(M:peek(json, index, 4))
            and M:isHex(M:peek(json, index, 5))
          then
            result = (result or "") .. string.sub(json, index + 2, index + 5)
            M:advance(5)
          end
        end
      else
        result = (result or "") .. M:read()
      end
      M:advance()
    end
    if tonumber(result) ~= nil then
      result = tonumber(result)
    end
    M:advance()
    return result
  end
  return nil
end

function M:parseNumeric()
  local start = index

  local readNumeric = function()
    while M:read() >= "0" and M:read() <= "9" do
      M:advance()
    end
  end

  if M:read() == "-" then
    M:advance()
  end
  if M:read() == "0" then
    M:advance()
  elseif M:read() >= "1" and M:read() <= "9" then
    M:advance()
    readNumeric()
  end

  if M:read() == "." then
    M:advance()
    readNumeric()
  end

  if M:read() == "e" or M:read() == "E" then
    M:advance()
    if M:read() == "-" or M:read() == "+" then
      M:advance()
    end
    readNumeric()
  end

  if index > start then
    return tonumber(string.sub(json, start, index - 1))
  end

  return nil
end

function M:parseKw(name, value)
  if string.sub(json, index, index + #name - 1) == name then
    index = index + #name
    return value
  end
end

function M:parseObject()
  if M:read() == "{" then
    M:advance()
    M:skipWhitespace()
    local result = {}
    local tail = false

    while M:read() ~= "}" do
      if tail then
        M:skipComma()
        M:skipWhitespace()
      end

      local key = M:parseString()
      M:skipWhitespace()
      M:skipColon()
      local value = M:parseValue()
      if key then
        result[key] = value
      end
      tail = true
    end
    M:advance()
    return result
  end
  return nil
end

function M:parseArray()
  if M:read() == "[" then
    M:advance()
    M:skipWhitespace()
    local result = {}
    init = true

    while M:read() ~= "]" do
      if not init then
        M:skipComma()
      end

      local value = M:parseValue()
      table.insert(result, value)
      init = false
    end
    M:advance()
    return result
  end
  return nil
end

function M:parseValue()
  M:skipWhitespace()
  local value
  local str = M:parseString()
  local num = M:parseNumeric()
  local obj = M:parseObject()
  local arr = M:parseArray()
  local yes = M:parseKw("true", true)
  local no = M:parseKw("false", false)
  local null = M:parseKw("null", nil)

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

  M:skipWhitespace()
  return value
end

M.parse = function(input)
  local file = io.open(input, "r")
  if file then
    json = file:read "*a"
    file:close()
    local value = M:parseValue()
    if value then
      return true, value
    end
  end

  return false, {}
end

return M
