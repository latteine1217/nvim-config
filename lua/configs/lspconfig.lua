--[[
Module: lspconfig
Purpose: 配置 LSP servers 並整合 NvChad 預設設定
Dependencies: nvchad.configs.lspconfig, lspconfig
Usage: 由 plugins/init.lua 自動載入
--]]

local nvchad_lsp = require("nvchad.configs.lspconfig")
local lspconfig = require("lspconfig")

local on_attach = nvchad_lsp.on_attach
local on_init = nvchad_lsp.on_init
local capabilities = nvchad_lsp.capabilities

--- 配置並啟動 LSP server（帶有 NvChad 預設設定）
---@param server string LSP server 名稱（例如 "pyright", "ts_ls"）
---@param opts? table 額外的配置選項，會與預設配置合併
---@return boolean success 是否成功啟動
local function setup_lsp(server, opts)
  -- 驗證參數
  vim.validate({
    server = { server, "string" },
    opts = { opts, "table", true },
  })

  -- 檢查 server 是否存在
  local ok, _ = pcall(function()
    return lspconfig[server]
  end)

  if not ok then
    vim.notify(
      string.format("LSP server '%s' 不存在，請檢查是否已安裝", server),
      vim.log.levels.WARN
    )
    return false
  end

  -- 構建配置
  local config = vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }, opts or {})

  -- 啟動 LSP
  local setup_ok, err = pcall(function()
    lspconfig[server].setup(config)
  end)

  if not setup_ok then
    vim.notify(
      string.format("LSP server '%s' 啟動失敗: %s", server, err),
      vim.log.levels.ERROR
    )
    return false
  end

  return true
end

-- 基本 LSP servers（無額外配置）
local basic_servers = {
  "html",
  "cssls",
}

for _, server in ipairs(basic_servers) do
  setup_lsp(server)
end

-- TypeScript LSP（帶客製化配置）
setup_lsp("ts_ls", {
  settings = {
    typescript = {
      preferences = {
        disableSuggestions = false,
      },
    },
  },
})
