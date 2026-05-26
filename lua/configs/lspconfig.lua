--[[
Module: lspconfig
Purpose: 自有 LSP 設定（已脫離 nvchad.configs.lspconfig）
Dependencies: nvim-lspconfig, blink.cmp
Usage: 由 plugins/init.lua 在 BufReadPre/BufNewFile 載入
Note: 使用 Neovim 0.11+ 的 vim.lsp.config / vim.lsp.enable API
--]]

-- =============================================================
-- Diagnostic 顯示
-- =============================================================
vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN]  = " ",
      [vim.diagnostic.severity.INFO]  = " ",
      [vim.diagnostic.severity.HINT]  = " ",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = true },
})

-- 浮動視窗統一圓角邊框
vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

-- =============================================================
-- 共用 capabilities（blink.cmp 提供補全能力）
-- =============================================================
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink then
  capabilities = blink.get_lsp_capabilities(capabilities, true)
end

-- =============================================================
-- 共用 on_attach：buffer 內 LSP 快捷鍵
-- =============================================================
local function on_attach(_, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. desc })
  end

  map("n", "gd",         vim.lsp.buf.definition,      "Go to definition")
  map("n", "gD",         vim.lsp.buf.declaration,     "Go to declaration")
  map("n", "gi",         vim.lsp.buf.implementation,  "Go to implementation")
  map("n", "gr",         vim.lsp.buf.references,      "References")
  map("n", "gy",         vim.lsp.buf.type_definition, "Type definition")
  map("n", "K",          vim.lsp.buf.hover,           "Hover docs")
  map("n", "<C-k>",      vim.lsp.buf.signature_help,  "Signature help")
  map("n", "<leader>rn", vim.lsp.buf.rename,          "Rename symbol")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
  map("n", "<leader>cd", vim.diagnostic.open_float,   "Show diagnostic")
  map("n", "[d",         function() vim.diagnostic.jump({ count = -1 }) end, "Prev diagnostic")
  map("n", "]d",         function() vim.diagnostic.jump({ count = 1 })  end, "Next diagnostic")
end

-- =============================================================
-- 啟動 LSP server（0.11+ API）
-- =============================================================
--- @param server string LSP server 名稱（例如 "pyright", "ts_ls"）
--- @param opts? table 額外設定，會與預設合併
local function setup_lsp(server, opts)
  vim.validate({
    server = { server, "string" },
    opts   = { opts,   "table", true },
  })

  local config = vim.tbl_deep_extend("force", {
    capabilities = capabilities,
    on_attach    = on_attach,
  }, opts or {})

  local ok, err = pcall(vim.lsp.config, server, config)
  if not ok then
    vim.notify(("vim.lsp.config(%s) 失敗: %s"):format(server, err), vim.log.levels.WARN)
    return
  end

  local ok2, err2 = pcall(vim.lsp.enable, server)
  if not ok2 then
    vim.notify(("vim.lsp.enable(%s) 失敗: %s"):format(server, err2), vim.log.levels.WARN)
  end
end

-- =============================================================
-- 基本 LSP servers
-- =============================================================
for _, server in ipairs({
  "html",
  "cssls",
  "pyright",
  "clangd",
}) do
  setup_lsp(server)
end

-- TypeScript LSP
setup_lsp("ts_ls", {
  settings = {
    typescript = {
      preferences = { disableSuggestions = false },
    },
  },
})

-- Lua LSP（neovim 環境）
setup_lsp("lua_ls", {
  settings = {
    Lua = {
      runtime    = { version = "LuaJIT" },
      workspace  = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry  = { enable = false },
      diagnostics = { globals = { "vim" } },
    },
  },
})
