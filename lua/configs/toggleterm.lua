--[[
Module: toggleterm
Purpose: 浮動終端管理（支援多終端、方向切換）
Dependencies: toggleterm.nvim
Usage: 由 plugins/init.lua 按需載入
--]]

local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
  vim.notify("toggleterm.nvim 載入失敗", vim.log.levels.ERROR)
  return
end

toggleterm.setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<C-\>]], -- Ctrl+\ 切換終端（避免與 tmux 衝突）
  hide_numbers = true, -- 隱藏行號
  shade_terminals = true, -- 終端背景變暗
  shading_factor = 2,
  start_in_insert = true, -- 開啟時進入插入模式
  insert_mappings = true, -- 插入模式也可用 open_mapping
  terminal_mappings = true, -- 終端模式可用 open_mapping
  persist_size = true,
  persist_mode = true, -- 記住上次的模式
  direction = "float", -- 預設方向: float, horizontal, vertical, tab
  close_on_exit = true, -- 程式結束時關閉終端
  shell = vim.o.shell, -- 使用預設 shell
  auto_scroll = true,

  -- 浮動終端配置
  float_opts = {
    border = "curved", -- 邊框樣式: single, double, shadow, curved
    width = function()
      return math.floor(vim.o.columns * 0.8)
    end,
    height = function()
      return math.floor(vim.o.lines * 0.8)
    end,
    winblend = 3, -- 透明度
  },

  -- 高亮組
  highlights = {
    Normal = {
      link = "Normal",
    },
    NormalFloat = {
      link = "NormalFloat",
    },
    FloatBorder = {
      link = "FloatBorder",
    },
  },
})

-- 快速指令
local Terminal = require("toggleterm.terminal").Terminal

-- Lazygit 整合
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "curved",
  },
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

-- Python REPL
local python = Terminal:new({ cmd = "python3", hidden = true })
function _python_toggle()
  python:toggle()
end

-- Node REPL
local node = Terminal:new({ cmd = "node", hidden = true })
function _node_toggle()
  node:toggle()
end

-- 快捷鍵
local map = vim.keymap.set
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle Float Terminal" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Toggle Horizontal Terminal" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Toggle Vertical Terminal" })
map("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", { desc = "Toggle Lazygit" })
map("n", "<leader>tp", "<cmd>lua _python_toggle()<CR>", { desc = "Toggle Python REPL" })
map("n", "<leader>tn", "<cmd>lua _node_toggle()<CR>", { desc = "Toggle Node REPL" })

-- 終端模式按鍵映射
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  map("t", "<esc>", [[<C-\><C-n>]], opts) -- Esc 退出終端模式
  map("t", "jk", [[<C-\><C-n>]], opts)
  map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
