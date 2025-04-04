-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- leader
vim.g.mapleader = ","

-- Basic settings
vim.opt.number = true       -- Show line numbers
vim.opt.expandtab = true    -- Use spaces instead of tabs
vim.opt.smartindent = true  -- Auto-indent new lines
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.termguicolors = true -- Enable 24-bit colors

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.shiftwidth = 2      -- Indent by 4 spaces
vim.opt.tabstop = 2         -- A tab is 4 spaces

vim.opt.cursorline = true
vim.opt.scrolloff = 20

vim.opt.fillchars:append({ eob = " " })

vim.cmd.colorscheme("slate")


-- Plugin manager setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("functions")
require("keymaps")
require("lazy").setup("plugins")

vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.bo.filetype == "NvimTree" then
      vim.cmd("quit")
    end
  end,
})

-- Function to check if running inside "kubectl edit"
local function is_kubectl_edit()
    local args = vim.v.argv
    for _, arg in ipairs(args) do
        if arg:match("kubectl") and arg:match("edit") then
            return true
        end
    end
    return false
end

-- Open nvim-tree on startup unless in kubectl edit
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if not is_kubectl_edit() then
            require("nvim-tree.api").tree.open()
            vim.cmd("wincmd p") -- Switch to the previous window
        end
    end
})
