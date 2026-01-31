--[[
Module: illuminate
Purpose: 自動高亮游標下的詞彙（LSP 支援）
Dependencies: vim-illuminate
Usage: 由 plugins/init.lua 自動載入
--]]

local ok, illuminate = pcall(require, "illuminate")
if not ok then
  vim.notify("vim-illuminate 載入失敗", vim.log.levels.ERROR)
  return
end

illuminate.configure({
  -- 提供者優先順序: LSP > Treesitter > Regex
  providers = {
    "lsp",
    "treesitter",
    "regex",
  },

  -- 延遲時間（ms）
  delay = 100,

  -- 排除的檔案類型
  filetypes_denylist = {
    "dirbuf",
    "dirvish",
    "fugitive",
    "NvimTree",
    "TelescopePrompt",
    "alpha",
    "dashboard",
    "DoomInfo",
    "lazy",
    "neogitstatus",
    "Outline",
    "packer",
    "qf",
    "toggleterm",
    "Trouble",
  },

  -- 排除的 buffer 類型
  filetypes_allowlist = {},

  -- 模式配置
  modes_denylist = {},
  modes_allowlist = {},

  -- 提供者特定配置
  providers_regex_syntax_denylist = {},
  providers_regex_syntax_allowlist = {},

  -- 大檔案優化（行數超過此值時停用）
  large_file_cutoff = nil,
  large_file_overrides = nil,

  -- 最小匹配數（少於此數時不高亮）
  min_count_to_highlight = 1,

  -- 是否在游標移動時立即更新
  should_enable = function(bufnr)
    return true
  end,

  -- Case 設定
  case_insensitive_regex = false,
})

-- 快捷鍵：跳轉到下一個/上一個高亮處
local map = vim.keymap.set
map("n", "]]", function()
  require("illuminate").goto_next_reference(false)
end, { desc = "Next Reference" })

map("n", "[[", function()
  require("illuminate").goto_prev_reference(false)
end, { desc = "Prev Reference" })
