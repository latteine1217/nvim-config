--[[
Module: conform
Purpose: 配置代碼格式化器（自動格式化保存）
Dependencies: conform.nvim
Usage: 由 plugins/init.lua 在 BufWritePre 事件載入
--]]

local options = {
  formatters_by_ft = {
    lua = { "stylua" },

    -- JavaScript/TypeScript 生態系
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },

    -- Web 前端
    css = { "prettier" },
    html = { "prettier" },

    -- 資料格式
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },

    -- Python
    python = { "black" },
  },

  -- 保存時自動格式化
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true, -- 若無 formatter 則使用 LSP 格式化
  },
}

-- 安全載入 conform
local ok, conform = pcall(require, "conform")
if not ok then
  vim.notify("conform.nvim 載入失敗", vim.log.levels.ERROR)
  return
end

return conform.setup(options)
