--[[
Module: trouble
Purpose: 美化的診斷/錯誤/警告/TODO 面板
Dependencies: trouble.nvim
Usage: 由 plugins/init.lua 按需載入
--]]

local ok, trouble = pcall(require, "trouble")
if not ok then
  vim.notify("trouble.nvim 載入失敗", vim.log.levels.ERROR)
  return
end

trouble.setup({
  position = "bottom", -- 面板位置: bottom, top, left, right
  height = 10, -- 面板高度
  width = 50, -- 側邊面板寬度
  icons = true,
  mode = "workspace_diagnostics", -- 預設模式
  fold_open = "", -- 展開圖示
  fold_closed = "", -- 收合圖示
  group = true, -- 依檔案分組
  padding = true,
  action_keys = {
    close = "q", -- 關閉面板
    cancel = "<esc>",
    refresh = "r", -- 重新整理
    jump = { "<cr>", "<tab>" }, -- 跳轉到錯誤位置
    open_split = { "<c-x>" }, -- 水平分割開啟
    open_vsplit = { "<c-v>" }, -- 垂直分割開啟
    open_tab = { "<c-t>" },
    jump_close = { "o" }, -- 跳轉並關閉
    toggle_mode = "m", -- 切換模式
    toggle_preview = "P", -- 切換預覽
    hover = "K", -- hover 資訊
    preview = "p", -- 預覽
    close_folds = { "zM", "zm" }, -- 收合所有
    open_folds = { "zR", "zr" }, -- 展開所有
    toggle_fold = { "zA", "za" }, -- 切換折疊
    previous = "k",
    next = "j",
  },
  indent_lines = true, -- 顯示縮排線
  auto_open = false, -- 不自動開啟
  auto_close = false,
  auto_preview = true, -- 自動預覽
  auto_fold = false,
  use_diagnostic_signs = true, -- 使用 LSP 診斷圖示
})

-- 快捷鍵
local map = vim.keymap.set
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })
map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace Diagnostics" })
map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document Diagnostics" })
map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix" })
map("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { desc = "LSP References" })
