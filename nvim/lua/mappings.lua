require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
map("v", "p", "pgvy")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- 添加诊断浮动窗口快捷键
map("n", "<C-k>", function()
  vim.diagnostic.open_float({
    border = "rounded",
    header = "",      -- 不显示标题
    prefix = "",      -- 不显示前缀
    source = true,    -- 显示诊断来源
    focus = false,    -- 不自动聚焦到浮动窗口
    scope = "cursor", -- 只显示光标所在位置的诊断
  })
end, { desc = "显示诊断浮动窗口" })
