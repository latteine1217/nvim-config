--[[
Module: lualine
Purpose: 復刻 NvChad default statusline 樣式（圓潤 mode/location 塊、平整中段）
Dependencies: lualine.nvim, nvim-web-devicons
--]]

local ok, lualine = pcall(require, "lualine")
if not ok then
  vim.notify("lualine 載入失敗", vim.log.levels.ERROR)
  return
end

-- =============================================================
-- Powerline / NerdFont 字元（用 string.char 構造 UTF-8 位元組，
-- 避免 PUA 字元在某些編輯流程中被剝光）
-- =============================================================
local glyph = function(...) return string.char(...) end
-- Section separators（半圓塊兩端）
local SECT_LEFT  = glyph(0xEE, 0x82, 0xB6) -- U+E0B6
local SECT_RIGHT = glyph(0xEE, 0x82, 0xB4) -- U+E0B4
-- Component separators（細半圓）
local COMP_LEFT  = glyph(0xEE, 0x82, 0xB5) -- U+E0B5
local COMP_RIGHT = glyph(0xEE, 0x82, 0xB7) -- U+E0B7

-- =============================================================
-- 自訂 component
-- =============================================================

-- 當前 buffer 已 attach 的 LSP server（NvChad 顯示在右側、綠色）
local function lsp_clients()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then return "" end
  local names = {}
  for _, c in ipairs(clients) do table.insert(names, c.name) end
  return "  " .. table.concat(names, " ")
end

-- 當前 cwd（顯示父目錄名稱，類似 NvChad 的 cwd 模組）
local function cwd_short()
  local home = vim.uv.os_homedir() or vim.env.HOME or ""
  local pwd  = vim.fn.getcwd()
  if home ~= "" and pwd:sub(1, #home) == home then
    pwd = "~" .. pwd:sub(#home + 1)
  end
  local name = vim.fn.fnamemodify(pwd, ":t")
  return "󰉋 " .. name
end

-- lazy.nvim pending updates（額外 QoL）
local function lazy_updates()
  local ok_lazy, lz = pcall(require, "lazy.status")
  if not ok_lazy then return "" end
  return lz.has_updates() and lz.updates() or ""
end

-- 巨集錄製指示
local function macro_recording()
  local reg = vim.fn.reg_recording()
  if reg == "" then return "" end
  return "  @" .. reg
end

-- =============================================================
-- Lualine setup
-- =============================================================
lualine.setup({
  options = {
    theme        = "catppuccin",
    icons_enabled = true,
    globalstatus  = true,

    -- NvChad 風格：中段平整、無 section/component 分隔符
    -- 圓潤塊只出現在 mode（左端）與 location（右端），透過該元件自身的 separator 套用
    component_separators = { left = "", right = "" },
    section_separators   = { left = "", right = "" },

    disabled_filetypes = {
      statusline = { "dashboard", "snacks_dashboard", "alpha", "starter" },
    },
  },

  sections = {
    -- 左端：mode（只在左側用半圓收邊）
    lualine_a = {
      { "mode", separator = { left = SECT_LEFT, right = "" }, right_padding = 2 },
    },

    -- branch
    lualine_b = {
      { "branch", icon = "" },
    },

    -- file path + diff + diagnostics
    lualine_c = {
      { "filename",
        path    = 1, -- relative path
        symbols = { modified = "● ", readonly = " ", unnamed = "[No Name]" },
      },
      { "diff",
        symbols = { added = " ", modified = " ", removed = " " },
      },
      { "diagnostics",
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
      },
    },

    -- 右側：LSP / encoding / cwd / filetype
    lualine_x = {
      { macro_recording, color = { fg = "#f38ba8", gui = "bold" } },
      { lazy_updates,    color = { fg = "#fab387" } },
      { lsp_clients,     color = { fg = "#a6e3a1" } },
      { "encoding" },
      { cwd_short,       color = { fg = "#89b4fa" } },
      { "filetype" },
    },

    -- progress
    lualine_y = {
      { "progress", separator = "" },
    },

    -- 右端：location（只在右側用半圓收邊）
    lualine_z = {
      { "location", separator = { left = "", right = SECT_RIGHT }, left_padding = 2 },
    },
  },

  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },

  extensions = { "nvim-tree", "trouble", "toggleterm", "mason", "lazy" },
})
