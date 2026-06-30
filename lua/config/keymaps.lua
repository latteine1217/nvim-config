--[[
Module: config.keymaps
Purpose: 個人 keymap delta；檔案/搜尋/視窗/git 等標準鍵位交給 LazyVim。
Note: 由 LazyVim 自動載入，在其預設 keymaps 之後執行。
--]]

local map = vim.keymap.set

-- 個人習慣：免按 Shift 進命令模式
map("n", ";", ":", { desc = "Enter command mode" })

-- 個人習慣：jk 退出 insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Visual mode 搬移選取並保持選取（覆寫預設 J=join、K=man）
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
