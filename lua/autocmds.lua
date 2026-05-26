--[[
Module: autocmds
Purpose: 自訂 autocommand（已脫離 nvchad.autocmds）
Usage: 由 init.lua 載入
--]]

local augroup = function(name) return vim.api.nvim_create_augroup("user_" .. name, { clear = true }) end

-- =============================================================
-- yank 高亮
-- =============================================================
vim.api.nvim_create_autocmd("TextYankPost", {
  group    = augroup("highlight_yank"),
  callback = function() vim.hl.on_yank({ timeout = 250 }) end,
})

-- =============================================================
-- 重開檔案時恢復游標位置
-- =============================================================
vim.api.nvim_create_autocmd("BufReadPost", {
  group    = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then return end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- =============================================================
-- 寫入時自動建立缺失目錄
-- =============================================================
vim.api.nvim_create_autocmd("BufWritePre", {
  group    = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- =============================================================
-- 視窗大小變更時平均分配
-- =============================================================
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group    = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- =============================================================
-- 進入終端機 buffer 自動進 insert
-- =============================================================
vim.api.nvim_create_autocmd("TermOpen", {
  group    = augroup("terminal_settings"),
  callback = function()
    vim.opt_local.number         = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn     = "no"
    vim.cmd("startinsert")
  end,
})

-- =============================================================
-- 關閉某些 filetype 的 q 鍵以 :close 行為
-- =============================================================
vim.api.nvim_create_autocmd("FileType", {
  group   = augroup("close_with_q"),
  pattern = {
    "help", "lspinfo", "man", "qf", "checkhealth", "notify",
    "startuptime", "tsplayground", "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
