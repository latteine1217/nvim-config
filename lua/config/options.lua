--[[
Module: config.options
Purpose: 個人 option delta；LazyVim 已設好絕大多數預設（number/relativenumber/
         clipboard/undofile/splitright 等），此處只覆寫與 LazyVim 不同的偏好。
Note: 由 LazyVim 自動載入，在其預設 options 之後執行。
--]]

local opt = vim.opt

-- 0.11+：所有浮動視窗統一圓角邊框
opt.winborder = "rounded"

-- 個人偏好：稍長的 mapped sequence 等待時間（LazyVim 預設 300）
opt.timeoutlen = 500
