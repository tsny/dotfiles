-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- leader
vim.g.mapleader = ","

-- Basic settings
vim.opt.number = true       -- Show line numbers
vim.opt.signcolumn = "yes"  -- Always reserve gutter for git signs
vim.opt.expandtab = true    -- Use spaces instead of tabs
vim.opt.smartindent = true  -- Auto-indent new lines

vim.opt.ignorecase = true  
vim.opt.smartcase = true  

vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.termguicolors = true -- Enable 24-bit colors

vim.opt.swapfile = false
vim.opt.backup = false

vim.cmd("filetype plugin indent on")

vim.opt.shiftwidth = 2      
vim.opt.tabstop = 2        

vim.opt.cursorline = true
vim.opt.cursorlineopt = "line,number"
vim.opt.scrolloff = 20
vim.opt.syntax = "enable"

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

require("keymaps")
require("lazy").setup("plugins")

vim.cmd.colorscheme("moonfly")

-- Keep the cursorline as a second, subtle focus marker in the active split.
local active_window_group = vim.api.nvim_create_augroup("ActiveWindow", { clear = true })

vim.api.nvim_create_autocmd("WinEnter", {
  group = active_window_group,
  callback = function()
    vim.wo.cursorline = true
  end,
})

vim.api.nvim_create_autocmd("WinLeave", {
  group = active_window_group,
  callback = function()
    vim.wo.cursorline = false
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".tmux.conf",
  callback = function()
    vim.bo.filetype = "tmux"
    vim.bo.syntax = "tmux"
  end,
})

require("nvim-tree-config")
