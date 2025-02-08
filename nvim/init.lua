vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
-- 保持相对行号
vim.opt.relativenumber = true

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- custom seeting
--
-- local autocmd = vim.api.nvim_create_autocmd
if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.g.neovide_input_use_logo = false -- true on macOS
  vim.g.neovide_input_macos_option_key_is_meta = "both"
  vim.g.neovide_scale_factor = 0.85
  vim.g.neovide_fullscreen = false

  vim.keymap.set("n", "<D-v>", '"+P')         -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P')         -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+")      -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

  vim.o.guifont = "FiraCode Nerd Font Propo"       -- text below applies for VimScript

  -- Allow clipboard copy paste in neovim
  vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
end

vim.g.copilot_assume_mapped = true

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--

-- utf8
vim.g.encoding = "UTF-8"
-- jkhl 移动时光标周围保留8行
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

vim.api.nvim_create_autocmd({ "WinNew", "VimEnter" }, {
  pattern = "*",
  callback = function()
    vim.w.my_foldlevel = 1
  end,
})
-- 记录当前输入法
-- Current_input_method = vim.fn.system "/usr/local/bin/macism"
Current_input_method = vim.fn.system "/opt/homebrew/bin/macism"


-- 切换到英文输入法
function Switch_to_English_input_method()
  -- Current_input_method = vim.fn.system "/usr/local/bin/macism"
  Current_input_method = vim.fn.system "/opt/homebrew/bin/macism"
  if Current_input_method ~= "com.apple.keylayout.ABC\n" then
    vim.fn.system "/opt/homebrew/bin/macism com.apple.keylayout.ABC"
  end
end

-- 设置输入法
function Set_input_method()
  if Current_input_method ~= "com.apple.keylayout.ABC\n" then
    vim.fn.system("/opt/homebrew/bin/macism " .. string.gsub(Current_input_method, "\n", ""))
  end
end

-- 进入 normal 模式时切换为英文输入法
vim.cmd [[
augroup input_method
  autocmd!
  autocmd InsertEnter * :lua Set_input_method()
  autocmd InsertLeave * :lua Switch_to_English_input_method()
augroup END
]]

vim.cmd [[
augroup input_method
  autocmd BufNewFile,BufRead *.wxml set filetype=xml
  autocmd BufNewFile,BufRead *.wxss set filetype=css
augroup END
]]

-- Keyboard users
vim.keymap.set("n", "<C-t>", function()
  require("menu").open "default"
end, {})

-- mouse users + nvimtree users!
vim.keymap.set("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

-- 终端填充
local autocmd = vim.api.nvim_create_autocmd

autocmd("VimEnter", {
  command = ":silent !kitty @ set-spacing padding=0 margin=0",
})

autocmd("VimLeavePre", {
  command = ":silent !kitty @ set-spacing padding=20 margin=10",
})

-- 此自动命令将恢复文件打开时的光标位置
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
        line > 1
        and line <= vim.fn.line "$"
        and vim.bo.filetype ~= "commit"
        and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})
