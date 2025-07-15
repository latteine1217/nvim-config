local nvchad_lsp = require("nvchad.configs.lspconfig")
local lspconfig = require("lspconfig")

local on_attach = nvchad_lsp.on_attach
local on_init = nvchad_lsp.on_init
local capabilities = nvchad_lsp.capabilities

local function setup_lsp(server, config)
  local default_config = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
  
  if config then
    default_config = vim.tbl_deep_extend("force", default_config, config)
  end
  
  lspconfig[server].setup(default_config)
end

local basic_servers = {
  "html",
  "cssls",
}

for _, server in ipairs(basic_servers) do
  setup_lsp(server)
end

setup_lsp("ts_ls", {
  settings = {
    typescript = {
      preferences = {
        disableSuggestions = false,
      },
    },
  },
})
