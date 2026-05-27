--[[
Module: gitsigns
Purpose: 邊欄 diff 標示 + hunk 操作 + inline blame
Dependencies: gitsigns.nvim
--]]

local ok, gs = pcall(require, "gitsigns")
if not ok then
  vim.notify("gitsigns 載入失敗", vim.log.levels.ERROR)
  return
end

gs.setup({
  signs = {
    add          = { text = "▎" },
    change       = { text = "▎" },
    delete       = { text = "" },
    topdelete    = { text = "" },
    changedelete = { text = "▎" },
    untracked    = { text = "▎" },
  },
  signcolumn               = true,
  numhl                    = false,
  linehl                   = false,
  word_diff                = false,
  current_line_blame       = false, -- 預設關，<leader>tb toggle
  current_line_blame_opts  = {
    virt_text         = true,
    virt_text_pos     = "eol",
    delay             = 300,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = "<author>, <author_time:%R> · <summary>",
  preview_config = { border = "rounded" },

  on_attach = function(bufnr)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "Git: " .. desc })
    end

    -- hunk 跳轉
    map("n", "]c", function()
      if vim.wo.diff then return "]c" end
      vim.schedule(gs.next_hunk)
      return "<Ignore>"
    end, "Next hunk")
    map("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(gs.prev_hunk)
      return "<Ignore>"
    end, "Prev hunk")

    -- hunk 操作
    map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>",  "Stage hunk")
    map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>",  "Reset hunk")
    map("n", "<leader>gS", gs.stage_buffer,                       "Stage buffer")
    map("n", "<leader>gR", gs.reset_buffer,                       "Reset buffer")
    map("n", "<leader>gu", gs.undo_stage_hunk,                    "Undo stage hunk")
    map("n", "<leader>gp", gs.preview_hunk,                       "Preview hunk")
    map("n", "<leader>gd", gs.diffthis,                           "Diff this")
    map("n", "<leader>gD", function() gs.diffthis("~") end,       "Diff against HEAD~")

    -- blame
    map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line (full)")
    map("n", "<leader>tb", gs.toggle_current_line_blame,            "Toggle git blame line")

    -- textobject
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Inner hunk")
  end,
})
