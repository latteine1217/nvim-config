--[[
Module: plugins.ai
Purpose: AI 堆疊 override（插件本體由 LazyVim ai.* extras 提供）。
  - ai.copilot / ai.copilot-chat：補全 + chat（取代原 codecompanion）
  - ai.avante：Cursor 風格 sidebar（diff-first），此處只覆寫 opts 與快捷鍵
Note: avante provider 沿用 Copilot 認證；selector 用 snacks（picker 已換 snacks）。
--]]

return {
  {
    "yetone/avante.nvim",
    opts = {
      provider = "copilot",
      providers = {
        copilot = {
          model = "claude-sonnet-4",
          timeout = 30000,
          extra_request_body = {
            temperature = 0,
            max_tokens = 8192,
          },
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = true,
        minimize_diff = true,
        enable_token_counting = true,
      },
      windows = {
        position = "right",
        width = 35,
        sidebar_header = { align = "center", rounded = true },
        input = { prefix = "> ", height = 8 },
        edit = { border = "rounded", start_insert = true },
        ask = { floating = false, start_insert = true, border = "rounded", focus_on_apply = "ours" },
      },
      diff = { autojump = true, list_opener = "copen" },
      hints = { enabled = true },
      selector = { provider = "snacks" },
    },
    -- 命名空間 <leader>A*（與 LazyVim 的 <leader>a* AI 群組區隔）
    keys = {
      { "<leader>Aa", "<cmd>AvanteAsk<cr>", mode = { "n", "v" }, desc = "Avante: Ask" },
      { "<leader>Ae", "<cmd>AvanteEdit<cr>", mode = { "n", "v" }, desc = "Avante: Edit" },
      { "<leader>At", "<cmd>AvanteToggle<cr>", desc = "Avante: Toggle Sidebar" },
      { "<leader>Ar", "<cmd>AvanteRefresh<cr>", desc = "Avante: Refresh" },
      { "<leader>Am", "<cmd>AvanteModels<cr>", desc = "Avante: Switch Model" },
    },
  },
}
