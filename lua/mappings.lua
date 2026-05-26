--[[
Module: mappings
Purpose: 全域按鍵（已脫離 nvchad.mappings，補回常用的 NvChad 預設）
Usage: 由 init.lua 在 vim.schedule 中載入
--]]

local map = vim.keymap.set

-- =============================================================
-- 基本編輯
-- =============================================================
map("n", ";",     ":",              { desc = "Enter command mode" })
map("i", "jk",    "<ESC>",          { desc = "Exit insert mode" })
map("n", "<Esc>", "<cmd>noh<cr>",   { desc = "Clear search highlight" })

-- =============================================================
-- 檔案操作
-- =============================================================
map("n", "<leader>w", "<cmd>w<cr>",    { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<cr>",    { desc = "Quit" })
map("n", "<leader>n", "<cmd>enew<cr>", { desc = "New file" })

-- =============================================================
-- Visual 模式
-- =============================================================
map("v", "<", "<gv",              { desc = "Indent left, keep selection" })
map("v", ">", ">gv",              { desc = "Indent right, keep selection" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- =============================================================
-- Telescope（取代 NvChad Spc f *）
-- =============================================================
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>",  { desc = "Find word (live grep)" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>",    { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>",  { desc = "Find help" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>",   { desc = "Find recent files" })
map("n", "<leader>fm", "<cmd>Telescope marks<cr>",      { desc = "Find marks" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>",    { desc = "Find keymaps" })
map("n", "<leader>fr", "<cmd>Telescope resume<cr>",     { desc = "Resume last picker" })

-- =============================================================
-- File explorer（nvim-tree；oil 走 - 進父目錄）
-- =============================================================
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>",   { desc = "Toggle file tree" })
map("n", "<leader>E", "<cmd>NvimTreeFindFile<cr>", { desc = "Reveal in tree" })

-- =============================================================
-- Window split（<C-h/j/k/l> 由 tmux-navigator 接管）
-- =============================================================
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<leader>sh", "<cmd>split<cr>",  { desc = "Horizontal split" })
map("n", "<leader>sx", "<cmd>close<cr>",  { desc = "Close split" })

-- =============================================================
-- Lazy / Mason 管理
-- =============================================================
map("n", "<leader>L", "<cmd>Lazy<cr>",  { desc = "Lazy plugin manager" })
map("n", "<leader>M", "<cmd>Mason<cr>", { desc = "Mason package manager" })

-- =============================================================
-- 退出 terminal mode
-- =============================================================
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
