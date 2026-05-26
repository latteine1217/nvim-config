--[[
Module: bufferline
Purpose: 取代 NvChad 的 tabufline（buffer tab 條）
Dependencies: bufferline.nvim, nvim-web-devicons
--]]

local ok, bufferline = pcall(require, "bufferline")
if not ok then
  vim.notify("bufferline 載入失敗", vim.log.levels.ERROR)
  return
end

bufferline.setup({
  options = {
    mode = "buffers",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or " "
      return icon .. count
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "left",
        separator = true,
      },
    },
    show_buffer_close_icons = false,
    show_close_icon         = false,
    separator_style         = "thin",
    always_show_bufferline  = true,
  },
})

-- 快捷鍵（同 NvChad <S-h>/<S-l> 與 <leader>x 關 buffer）
local map = vim.keymap.set
map("n", "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",   { desc = "Prev buffer" })
map("n", "<S-l>",      "<cmd>BufferLineCycleNext<cr>",   { desc = "Next buffer" })
map("n", "[b",         "<cmd>BufferLineCyclePrev<cr>",   { desc = "Prev buffer" })
map("n", "]b",         "<cmd>BufferLineCycleNext<cr>",   { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>",   { desc = "Pin buffer" })
map("n", "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", { desc = "Close non-pinned" })
map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close other buffers" })
map("n", "<leader>x",  "<cmd>bdelete<cr>",               { desc = "Close current buffer" })
