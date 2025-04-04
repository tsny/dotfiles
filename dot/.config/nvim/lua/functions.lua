-- Function to copy the absolute file path
function CopyFilePath()
    local path = vim.fn.expand("%:p")

    -- Convert to Windows-style path if needed
    if vim.fn.has("win32unix") == 1 then
        path = path:gsub("/", "\\")
        path = path:sub(2, 2) .. ":" .. path:sub(3)
    elseif vim.fn.has("win32") == 1 then
        path = path:gsub("/", "\\")
    end

    -- Copy to system clipboard
    vim.fn.setreg("+", path)
    print("Copied path: " .. path)
end

-- Function to copy just the filename
function CopyFileName()
    local filename = vim.fn.expand("%")
    vim.fn.setreg("+", filename)
    print("Copied filename: " .. filename)
end

-- Function to copy the directory path
function CopyDir()
    local dir = vim.fn.expand("%:p:h")
    vim.fn.setreg("+", dir)
    print("Copied dir: " .. dir)
end
