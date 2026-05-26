--[[
Module: codecompanion
Purpose: AI chat / inline edit / slash commands，定位為「Cursor-light + 對話」
Dependencies: codecompanion.nvim, plenary.nvim, nvim-treesitter
Usage: 由 plugins/init.lua 透過 :CodeCompanion* 指令觸發載入

策略：
- 採 Copilot adapter，沿用既有 GitHub Copilot 認證（不需另設 API key）
- 與 copilot.lua 共存：copilot.lua 負責 ghost-text 即時補全，CodeCompanion 負責 chat / refactor
- 預設模型 claude-sonnet-4（Copilot 提供）
--]]

local ok, codecompanion = pcall(require, "codecompanion")
if not ok then
  vim.notify("codecompanion.nvim 載入失敗", vim.log.levels.ERROR)
  return
end

codecompanion.setup({
  -- 三種主要模式對應的 adapter（皆使用 Copilot）
  strategies = {
    chat = {
      adapter = "copilot",
      keymaps = {
        send = {
          modes = { n = "<CR>", i = "<C-s>" },
        },
        close = {
          modes = { n = "<C-c>", i = "<C-c>" },
        },
      },
    },
    inline = {
      adapter = "copilot",
    },
    cmd = {
      adapter = "copilot",
    },
  },

  adapters = {
    copilot = function()
      return require("codecompanion.adapters").extend("copilot", {
        schema = {
          model = {
            default = "claude-sonnet-4", -- 可改 "gpt-4o" / "gpt-5" 等 Copilot 支援模型
          },
        },
      })
    end,
  },

  display = {
    chat = {
      window = {
        layout   = "vertical", -- vertical | horizontal | float
        position = "right",
        width    = 0.40,
      },
      show_settings = false,
      show_token_count = true,
      intro_message = "歡迎使用 CodeCompanion. 按 ? 查看快捷鍵.",
    },
    diff = {
      enabled  = true,
      provider = "default", -- 可改 "mini_diff"
    },
  },

  opts = {
    log_level = "ERROR",
    send_code = true, -- 允許將 buffer 內容送至 LLM（local code）
  },
})

-- 快捷鍵
local map = vim.keymap.set

map({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>",      { desc = "CodeCompanion: Toggle Chat" })
map({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<cr>",          { desc = "CodeCompanion: Actions" })
map("v",          "<leader>ae", "<cmd>CodeCompanionChat Add<cr>",         { desc = "CodeCompanion: Add selection to chat" })
map({ "n", "v" }, "<leader>ai", ":CodeCompanion ",                         { desc = "CodeCompanion: Inline prompt" })

-- 將 :CC 設為 :CodeCompanion 的別名，方便快速呼叫
vim.cmd([[cab cc CodeCompanion]])
