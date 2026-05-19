--[[
Module: trouble
Purpose: 美化的診斷/錯誤/警告/TODO 面板
Dependencies: trouble.nvim v3+
Usage: 由 plugins/init.lua 按需載入
Note: 已更新至 Trouble v3 新 API
--]]

local ok, trouble = pcall(require, "trouble")
if not ok then
  vim.notify("trouble.nvim 載入失敗", vim.log.levels.ERROR)
  return
end

trouble.setup({
  auto_close = false, -- 沒有項目時自動關閉
  auto_open = false, -- 有項目時自動開啟
  auto_preview = true, -- 自動預覽
  auto_refresh = true, -- 自動重新整理
  focus = false, -- 開啟時不自動 focus
  follow = true, -- 跟隨當前項目
  indent_guides = true, -- 顯示縮排線
  max_items = 200, -- 每個 section 最多顯示項目數
  multiline = true, -- 多行訊息渲染
  pinned = false, -- 不固定到當前 buffer
  
  -- 視窗設定
  win = {
    position = "bottom", -- 視窗位置
    size = 10, -- 視窗大小
  },

  -- 預覽設定
  preview = {
    type = "main",
    scratch = true,
  },

  -- 按鍵映射（使用 Trouble v3 action 名稱）
  keys = {
    ["?"] = "help",
    r = "refresh",
    R = "toggle_refresh",
    q = "close",
    o = "jump_close",
    ["<esc>"] = "cancel",
    ["<cr>"] = "jump",
    ["<2-leftmouse>"] = "jump",
    ["<c-s>"] = "jump_split",
    ["<c-v>"] = "jump_vsplit",
    ["}"] = "next",
    ["]]"] = "next",
    ["{"] = "prev",
    ["[["] = "prev",
    dd = "delete",
    d = { action = "delete", mode = "v" },
    i = "inspect",
    p = "preview",
    P = "toggle_preview",
    zo = "fold_open",
    zO = "fold_open_recursive",
    zc = "fold_close",
    zC = "fold_close_recursive",
    za = "fold_toggle",
    zA = "fold_toggle_recursive",
    zm = "fold_more",
    zM = "fold_close_all",
    zr = "fold_reduce",
    zR = "fold_open_all",
    zx = "fold_update",
    zX = "fold_update_all",
    zn = "fold_disable",
    zN = "fold_enable",
    zi = "fold_toggle_enable",
  },

  -- 模式設定
  modes = {
    symbols = {
      desc = "document symbols",
      mode = "lsp_document_symbols",
      focus = false,
      win = { position = "right" },
      filter = {
        ["not"] = { ft = "lua", kind = "Package" },
        any = {
          ft = { "help", "markdown" },
          kind = {
            "Class",
            "Constructor",
            "Enum",
            "Field",
            "Function",
            "Interface",
            "Method",
            "Module",
            "Namespace",
            "Package",
            "Property",
            "Struct",
            "Trait",
          },
        },
      },
    },
  },
})

-- 快捷鍵（使用 Trouble v3 命令格式）
local map = vim.keymap.set
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle Diagnostics (Trouble)" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Workspace Diagnostics" })
map("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Document Diagnostics" })
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List" })
map("n", "gR", "<cmd>Trouble lsp_references toggle<cr>", { desc = "LSP References" })
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
