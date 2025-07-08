local functions = require("functions")

-- Keybindings 
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })

-- Moving quickly around splits
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

vim.keymap.set("n", ";", ":", { noremap = true })

-- Add line below current
vim.keymap.set("n", "K", "o<ESC>k", { noremap = true, silent = true })


-- Clear highlight
vim.keymap.set("n", "<C-c>", ":noh<CR>", { noremap = true, silent = true })

-- Splitting windows
vim.keymap.set("n", "<leader>vs", ":vsp<CR>", { noremap = true, silent = true })  -- Vertical split
vim.keymap.set("n", "<leader>hs", ":split<CR>", { noremap = true, silent = true }) -- Horizontal split

-- File explorer
vim.keymap.set("n", "<leader>oe", ":NvimTreeOpen<CR>", { noremap = true, silent = true }) -- Open netrw

-- FZF keybindings
vim.keymap.set("n", "<C-f>", ":RG<CR>", { noremap = true, silent = true })  -- Switch buffers
vim.keymap.set("n", "<C-p>", ":Files<CR>", { noremap = true, silent = true })    -- Find files
vim.keymap.set("n", "<C-h>", ":History<CR>", { noremap = true, silent = true })  -- Open command history
vim.keymap.set("n", "<leader>ff", ":Files ~/dev<CR>", { noremap = true, silent = true }) -- Find files in ~/dev
vim.keymap.set("n", "H", ":History<CR>", { noremap = true, silent = true }) -- History command

vim.keymap.set("n", "<leader>cfp", functions.CopyFilePath, { noremap = true, silent = true }) -- Copy file path

-- Remap <S-V> and v
vim.keymap.set("n", "v", "<S-V>", { noremap = true, silent = true }) -- Normal mode: v to <S-V>
vim.keymap.set("n", "<S-V>", "v", { noremap = true, silent = true }) -- Normal mode: <S-V> to v

vim.keymap.set("v", "v", "<S-V>", { noremap = true, silent = true }) -- Visual mode: v to <S-V>
vim.keymap.set("v", "<S-V>", "v", { noremap = true, silent = true }) -- Visual mode: <S-V> to v

-- Hop
vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_char2()<cr>", {})
