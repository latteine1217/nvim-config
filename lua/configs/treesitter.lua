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
  -- incremental selection 改用 gr-prefix（與 0.11+ 內建 grn/grr/gra 系列風格一致）
  -- 避免和 blink.cmp 的 <C-Space> 觸發鍵衝突
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection    = "grn", -- start
      node_incremental  = "grn", -- expand
      scope_incremental = "grs", -- expand to scope
      node_decremental  = "grm", -- shrink
    },
  },
})
