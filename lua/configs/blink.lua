--[[
Module: blink
Purpose: blink.cmp 補全引擎設定（取代 nvim-cmp，效能大幅提升）
Dependencies: blink.cmp, LuaSnip, friendly-snippets
Usage: 由 plugins/init.lua 在 InsertEnter / CmdlineEnter 載入

設計取捨：
- snippet 走 LuaSnip preset，沿用既有 friendly-snippets
- keymap 用 "default" preset（C-Space 觸發、C-n/C-p 切換、CR 接受）
- 額外保留 Tab/S-Tab 用於 snippet jump（避免與 Copilot ghost-text 衝突：Copilot 用 M-l）
- cmdline 也啟用補全（取代 noice 之外的指令列補全體驗）
--]]

local ok, blink = pcall(require, "blink.cmp")
if not ok then
  vim.notify("blink.cmp 載入失敗", vim.log.levels.ERROR)
  return
end

blink.setup({
  -- 基礎 keymap preset
  keymap = {
    preset = "default",

    -- Tab / S-Tab：在 snippet 內跳轉、無 snippet 時保留預設行為
    ["<Tab>"] = {
      function(cmp)
        if cmp.snippet_active() then return cmp.accept() end
        return cmp.select_next()
      end,
      "snippet_forward",
      "fallback",
    },
    ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },

    -- 文件預覽切換
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    ["<C-u>"] = { "scroll_documentation_up", "fallback" },
  },

  -- snippet 後端：LuaSnip
  snippets = { preset = "luasnip" },

  -- 補全 UI
  appearance = {
    nerd_font_variant = "mono",
    use_nvim_cmp_as_default = false, -- 用 blink 原生 highlight group
  },

  completion = {
    -- accept 行為
    accept = {
      auto_brackets = { enabled = true }, -- LSP 提示函式時自動補括號
    },

    -- 觸發
    trigger = {
      show_in_snippet = true,
    },

    -- 選單顯示（kind icon 來自 lspkind，font 與 NerdFont 對齊）
    menu = {
      border = "rounded",
      draw = {
        treesitter = { "lsp" }, -- 用 treesitter 高亮 lsp 項目
        columns = {
          { "kind_icon", "label", gap = 1 },
          { "kind" },
        },
        components = {
          kind_icon = {
            text = function(ctx)
              local ok_lk, lspkind = pcall(require, "lspkind")
              if ok_lk then
                local icon = lspkind.symbolic(ctx.kind, { mode = "symbol" })
                if icon and icon ~= "" then return icon .. " " end
              end
              return ctx.kind_icon .. ctx.icon_gap
            end,
            highlight = function(ctx) return "BlinkCmpKind" .. ctx.kind end,
          },
        },
      },
    },

    -- 文件預覽
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = { border = "rounded" },
    },

    -- ghost text（顯示完整建議的灰字提示）
    ghost_text = { enabled = false }, -- 關閉避免與 Copilot ghost-text 重疊
  },

  -- 補全 source
  sources = {
    default = { "lsp", "snippets", "path", "buffer" },
    providers = {
      buffer = { score_offset = -3 }, -- buffer 優先級降低
      path   = { opts = { trailing_slash = true } },
    },
  },

  -- cmdline 補全
  cmdline = {
    keymap = {
      preset = "cmdline",
      ["<Tab>"]   = { "show_and_insert", "select_next" },
      ["<S-Tab>"] = { "show_and_insert", "select_prev" },
      ["<CR>"]    = { "accept_and_enter", "fallback" },
    },
    completion = { menu = { auto_show = true } },
  },

  -- signature help（取代 NvChad/noice 的 signature；可選關閉避免重疊）
  signature = {
    enabled = false, -- noice 已處理；想用 blink 內建可改 true
  },

  -- fuzzy matcher：使用預編 Rust binary（取自 release）
  fuzzy = { implementation = "prefer_rust_with_warning" },
})
