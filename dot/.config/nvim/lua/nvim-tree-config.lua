-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
local function tab_win_closed(winnr)
  local api = require"nvim-tree.api"
  local tabnr = vim.api.nvim_win_get_tabpage(winnr)
  local bufnr = vim.api.nvim_win_get_buf(winnr)
  local buf_info = vim.fn.getbufinfo(bufnr)[1]
  local tab_wins = vim.tbl_filter(function(w) return w~=winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
  local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
  if buf_info.name:match(".*NvimTree_%d*$") then            -- close buffer was nvim tree
    -- Close all nvim tree on :q
    if not vim.tbl_isempty(tab_bufs) then                      -- and was not the last window (not closed automatically by code below)
      api.tree.close()
    end
  else                                                      -- else closed buffer was normal buffer
    if #tab_bufs == 1 then                                    -- if there is only 1 buffer left in the tab
      local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
      if last_buf_info.name:match(".*NvimTree_%d*$") then       -- and that buffer is nvim tree
        vim.schedule(function ()
          if #vim.api.nvim_list_wins() == 1 then                -- if its the last buffer in vim
            vim.cmd "quit"                                        -- then close all of vim
          else                                                  -- else there are more tabs open
            vim.api.nvim_win_close(tab_wins[1], true)             -- then close only the tab
          end
        end)
      end
    end
  end
end

vim.api.nvim_create_autocmd("WinClosed", {
  callback = function ()
    local winnr = tonumber(vim.fn.expand("<amatch>"))
    vim.schedule_wrap(tab_win_closed(winnr))
  end,
  nested = true
})


-- Function to check if running inside special editing contexts
local function is_special_edit()
    local filename = vim.fn.expand("%:p")
    local env = vim.fn.environ()

    -- Check common patterns for git
    if filename:match("/%.git/COMMIT_EDITMSG$") or
       filename:match("/%.git/MERGE_MSG$") or
       filename:match("/%.git/REBASE_EDITMSG$") then
        return true
    end

    -- Check for kubectl: often uses temp files
    if env.KUBECTL_COMMAND or filename:match("kubectl%-edit") or filename:match("kubectl.*%.yaml$") then
        return true
    end

    -- Check for other temp file contexts if needed

    return false
end

-- Open nvim-tree on startup unless in kubectl edit
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if not is_special_edit() then
            require("nvim-tree.api").tree.open()
            vim.cmd("wincmd p") -- Switch to the previous window
        end
    end
})

