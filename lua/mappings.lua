--[[
Module: mappings
Purpose: 自訂按鍵映射（擴展 NvChad 預設）
Dependencies: nvchad.mappings
Usage: 由 init.lua 延遲載入（vim.schedule）
--]]

require("nvchad.mappings")

local map = vim.keymap.set

-- === 基本編輯 ===

map("n", ";", ":", { desc = "Enter command mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- === 檔案操作 ===
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- === 窗口導航 ===
-- 已由 tmux-navigator 插件處理 (<C-h/j/k/l>)

-- === Visual 模式增強 ===
map("v", "<", "<gv", { desc = "Indent left and keep selection" })
map("v", ">", ">gv", { desc = "Indent right and keep selection" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- === GitHub Copilot ===
-- 建議接受: Alt+l (避免與 Tab 衝突)
-- 下一個建議: Alt+]
-- 上一個建議: Alt+[
-- 關閉建議: Ctrl+]
-- 開啟面板: Alt+Enter
-- 詳見 lua/configs/copilot.lua
