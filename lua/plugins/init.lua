return {
  -- 修復 LuaSnip jsregexp submodule 問題
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp", -- 正確的 build 步驟
    dependencies = "rafamadriz/friendly-snippets",
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("configs.conform")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require("configs.lspconfig")
    end,
  },

  {
    "williamboman/mason.nvim",
    -- ensure_installed 已移至 chadrc.lua 統一管理
  },

  {
    "nvim-treesitter/nvim-treesitter",
    -- ensure_installed 已移至 chadrc.lua 統一管理
  },

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

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = {
          enabled = false,
          silent = true,
        },
        signature = {
          enabled = false,
          auto_open = {
            enabled = true,
            trigger = true,
            luasnip = true,
            throttle = 50,
          },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("configs.copilot")
    end,
  },

  -- ========================================
  -- 🎨 視覺與操作增強插件（推薦安裝）
  -- ========================================

  -- 超快速跳轉（取代 f/t）
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
    config = function()
      require("configs.flash")
    end,
  },

  -- TODO/FIXME 高亮與快速搜尋
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("configs.todo-comments")
    end,
  },

  -- 括號/引號快速操作
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("configs.surround")
    end,
  },

  -- 診斷/錯誤面板
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("configs.trouble")
    end,
  },

  -- 浮動終端管理
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    config = function()
      require("configs.toggleterm")
    end,
  },

  -- ========================================
  -- 🎯 可選增強插件（視需求安裝）
  -- ========================================

  -- 美化 UI 輸入框
  -- {
  --   "stevearc/dressing.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("configs.dressing")
  --   end,
  -- },

  -- 高亮游標下相同詞
  -- {
  --   "RRethy/vim-illuminate",
  --   event = "BufReadPost",
  --   config = function()
  --     require("configs.illuminate")
  --   end,
  -- },

  -- 現代化代碼折疊
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   dependencies = "kevinhwang91/promise-async",
  --   event = "BufReadPost",
  --   config = function()
  --     require("configs.ufo")
  --   end,
  -- },

}
