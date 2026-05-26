--[[
Module: mason-tool-installer
Purpose: 接管 NvChad chadrc 的 ensure_installed 清單
Dependencies: mason.nvim, mason-tool-installer.nvim
--]]

local ok, mti = pcall(require, "mason-tool-installer")
if not ok then
  vim.notify("mason-tool-installer 載入失敗", vim.log.levels.ERROR)
  return
end

mti.setup({
  ensure_installed = {
    -- Lua
    "lua-language-server",
    "stylua",

    -- Web
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "prettier",
    "eslint-lsp",

    -- C / C++
    "clangd",
    "clang-format",

    -- Python
    "pyright",
    "black",
    "mypy",
    "debugpy",
  },
  auto_update = false,
  run_on_start = true,
  start_delay = 3000,
})
