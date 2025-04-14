-- ~/.config/nvim/lua/functions.lua

local M = {}

function M.CopyFilePath()
  local path = vim.fn.expand("%:p")

  if vim.fn.has("win32unix") == 1 then
    path = path:gsub("/", "\\")
    path = path:sub(2, 2) .. ":" .. path:sub(3)
  elseif vim.fn.has("win32") == 1 then
    path = path:gsub("/", "\\")
  end

  vim.fn.setreg("+", path)
  print("Copied path: " .. path)
end

function M.CopyFileName()
  local filename = vim.fn.expand("%")
  vim.fn.setreg("+", filename)
  print("Copied filename: " .. filename)
end

function M.CopyDir()
  local dir = vim.fn.expand("%:p:h")
  vim.fn.setreg("+", dir)
  print("Copied dir: " .. dir)
end

function M.get_mac_theme()
  local handle = io.popen([[defaults read -g AppleInterfaceStyle 2>/dev/null]])
  if handle then
    local result = handle:read("*a")
    handle:close()
    local theme = result:match("Dark") and "dark" or "light"
    return theme
  else
    return "light"
  end
end

function M.get_cat_theme()
  local theme = M.get_mac_theme()
  return theme == "dark" and "mocha" or "latte"
end

return M
