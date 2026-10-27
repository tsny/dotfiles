-- Ctrl-h/j/k/l moves between nvim splits, then hands off to Zellij or tmux
-- at an edge whenever the multiplexer passes the keys through to nvim.

local zellij_cmds = {
  h = { "move-focus-or-tab", "left" },
  j = { "move-focus", "down" },
  k = { "move-focus", "up" },
  l = { "move-focus-or-tab", "right" },
}
local tmux_cmds = { h = "TmuxNavigateLeft", j = "TmuxNavigateDown", k = "TmuxNavigateUp", l = "TmuxNavigateRight" }

local function zellij(args)
  if vim.env.ZELLIJ then
    return vim.system(vim.list_extend({ "zellij", "action" }, args))
  end
end

local function navigate(dir)
  local prev = vim.api.nvim_get_current_win()
  vim.cmd.wincmd(dir)

  if vim.api.nvim_get_current_win() ~= prev then
    return
  end

  if vim.env.ZELLIJ then
    zellij(zellij_cmds[dir])
  elseif vim.env.TMUX then
    vim.cmd(tmux_cmds[dir])
  end
end

for dir in pairs(zellij_cmds) do
  local fn = function() navigate(dir) end
  vim.keymap.set("n", "<C-" .. dir .. ">", fn, { silent = true })
  vim.keymap.set("t", "<C-" .. dir .. ">", fn, { silent = true })
end

-- fzf windows use Ctrl-j/k to move through results

vim.api.nvim_create_autocmd("FileType", {
  pattern = "fzf",
  callback = function(args)
    vim.keymap.set("t", "<C-j>", "<C-j>", { buffer = args.buf })
    vim.keymap.set("t", "<C-k>", "<C-k>", { buffer = args.buf })
  end,
})
