--[[
Module: plugins.extras
Purpose: 純新增、與 LazyVim 預設不衝突的補充插件。
  - oil.nvim：buffer-style 目錄編輯（按 - 進父目錄），補強 neo-tree 側欄。
  - vim-tmux-navigator：<C-hjkl> 在 nvim split 與 tmux pane 間無縫切換。
--]]

return {
  -- buffer 式檔案編輯；neo-tree 仍為主要側欄樹
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = false, -- 不接管 netrw；neo-tree 為主
      columns = { "icon" },
      buf_options = { buflisted = false, bufhidden = "hide" },
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = false,
      prompt_save_on_select_new_entry = true,
      use_default_keymaps = true,
      view_options = {
        show_hidden = false,
        is_hidden_file = function(name)
          return vim.startswith(name, ".")
        end,
        is_always_hidden = function(name)
          return name == ".." or name == ".git"
        end,
        natural_order = true,
        sort = { { "type", "asc" }, { "name", "asc" } },
      },
      float = {
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = { winblend = 0 },
      },
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Oil: open parent directory" },
      { "<leader>fo", "<cmd>Oil --float<cr>", desc = "Oil: floating explorer" },
    },
  },

  -- tmux / nvim split 無縫導航（覆寫 LazyVim 預設的 <C-hjkl> 視窗移動）
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Navigate Left" },
      { "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Navigate Down" },
      { "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Navigate Up" },
      { "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Navigate Right" },
      { "<C-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Navigate Previous" },
    },
  },
}
