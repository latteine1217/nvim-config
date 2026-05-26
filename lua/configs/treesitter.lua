--[[
Module: treesitter
Purpose: 接管 NvChad chadrc 的 treesitter 設定
Dependencies: nvim-treesitter
--]]

local ok, ts = pcall(require, "nvim-treesitter.configs")
if not ok then
  vim.notify("nvim-treesitter 載入失敗", vim.log.levels.ERROR)
  return
end

ts.setup({
  ensure_installed = {
    "vim", "vimdoc", "lua", "luadoc",
    "c", "cpp",
    "python",
    "javascript", "typescript", "tsx",
    "html", "css",
    "json", "yaml", "toml",
    "markdown", "markdown_inline",
    "bash", "regex",
    "query",
  },
  sync_install = false,
  auto_install = true,

  highlight  = { enable = true, additional_vim_regex_highlighting = false },
  indent     = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection    = "<C-space>",
      node_incremental  = "<C-space>",
      scope_incremental = false,
      node_decremental  = "<bs>",
    },
  },
})
