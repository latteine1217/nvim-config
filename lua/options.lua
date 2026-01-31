--[[
Module: options
Purpose: 編輯器選項設定（擴展 NvChad 預設值）
Dependencies: nvchad.options
Usage: 由 init.lua 自動載入
--]]

require("nvchad.options")

local opt = vim.opt
local g = vim.g

-- === 顯示設定 ===

opt.relativenumber = true  -- 相對行號（便於移動）
opt.wrap = false           -- 不自動換行
opt.scrolloff = 8          -- 游標上下保留 8 行
opt.sidescrolloff = 8      -- 游標左右保留 8 列
opt.cursorline = true      -- 高亮當前行

-- === 縮排設定 ===
opt.expandtab = true       -- 使用空格替代 Tab
opt.shiftwidth = 2         -- 自動縮排寬度
opt.tabstop = 2            -- Tab 寬度
opt.softtabstop = 2        -- 編輯時 Tab 寬度

-- === 搜尋設定 ===
opt.ignorecase = true      -- 搜尋時忽略大小寫
opt.smartcase = true       -- 若包含大寫則區分大小寫

-- === 剪貼板整合 ===
opt.clipboard = "unnamedplus"  -- 使用系統剪貼板

-- === 備份與快取 ===
opt.backup = false         -- 不建立備份檔
opt.writebackup = false    -- 寫入時不建立備份
opt.swapfile = false       -- 不建立 swap 檔案
opt.undofile = true        -- 保留 undo 歷史

-- === 效能設定 ===
opt.updatetime = 300       -- CursorHold 觸發時間（ms）
opt.timeoutlen = 500       -- 按鍵組合等待時間（ms）

-- === 字體設定 ===
g.have_nerd_font = true    -- 啟用 Nerd Font 圖示
