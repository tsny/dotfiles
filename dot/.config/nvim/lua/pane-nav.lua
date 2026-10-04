-- Ctrl-h/j/k/l moves between nvim splits, then hands off to Zellij or tmux
-- at an edge. Zellij stays locked while nvim has focus so the keys reach nvim.

local zellij_dirs = { h = "left", j = "down", k = "up", l = "right" }
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
    zellij({ "move-focus", zellij_dirs[dir] })
  elseif vim.env.TMUX then
    vim.cmd(tmux_cmds[dir])
  end
end

for dir in pairs(zellij_dirs) do
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

local group = vim.api.nvim_create_augroup("ZellijPaneNavigation", {})

vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained", "VimResume" }, {
  group = group,
  callback = function() zellij({ "switch-mode", "locked" }) end,
})

vim.api.nvim_create_autocmd({ "FocusLost", "VimLeavePre", "VimSuspend" }, {
  group = group,
  -- Wait so the mode switch lands before nvim exits.
  callback = function()
    local job = zellij({ "switch-mode", "normal" })
    if job then job:wait(500) end
  end,
})
