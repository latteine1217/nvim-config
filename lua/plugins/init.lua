--[[
Module: plugins/init
Purpose: lazy.nvim plugin spec（已脫離 NvChad，所有插件顯式宣告）
Layout: 依用途分區，每區內按字母 / 啟動相依排序
--]]

return {
  -- =============================================================
  -- Snippets
  -- =============================================================
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = "rafamadriz/friendly-snippets",
  },

  -- =============================================================
  -- Completion: blink.cmp（取代 nvim-cmp）
  -- =============================================================
  { "hrsh7th/nvim-cmp",          enabled = false },
  { "hrsh7th/cmp-nvim-lsp",      enabled = false },
  { "hrsh7th/cmp-nvim-lua",      enabled = false },
  { "hrsh7th/cmp-buffer",        enabled = false },
  { "saadparwaiz1/cmp_luasnip",  enabled = false },
  { "FelipeLema/cmp-async-path", enabled = false },
  {
    "saghen/blink.cmp",
    version = "*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = { "L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets" },
    config = function() require("configs.blink") end,
  },

  -- =============================================================
  -- Theme: catppuccin（取代 base46）
  -- =============================================================
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function() require("configs.catppuccin") end,
  },

  -- =============================================================
  -- UI: statusline / tabline / dashboard
  -- =============================================================
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("configs.lualine") end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("configs.bufferline") end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function() require("configs.snacks") end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function() require("configs.which-key") end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
        hover = { enabled = false, silent = true },
        signature = { enabled = false },
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
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function() require("configs.dressing") end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("configs.todo-comments") end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPost",
    opts = { indent = { char = "│" }, scope = { enabled = false } },
  },

  -- LSP progress 提示（右下角 spinner）
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      progress = {
        display = {
          done_icon = "✓",
          progress_icon = { pattern = "dots", period = 1 },
        },
      },
      notification = {
        window = { winblend = 0, border = "rounded" },
      },
    },
  },

  -- 補全選單 kind icons（lspkind 風格）
  { "onsails/lspkind.nvim", lazy = true },

  -- Treesitter sticky context（長函式內顯示 function header）
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = {
      enable = true,
      max_lines = 3,
      min_window_height = 20,
      line_numbers = true,
      multiline_threshold = 1,
      trim_scope = "outer",
      mode = "cursor",
      separator = "─",
    },
    keys = {
      { "<leader>tc", "<cmd>TSContextToggle<cr>", desc = "Toggle TS context" },
    },
  },

  -- =============================================================
  -- AI
  -- =============================================================
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function() require("configs.copilot") end,
  },
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions", "CodeCompanionCmd" },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    config = function() require("configs.codecompanion") end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    build = "make",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
    },
    config = function() require("configs.avante") end,
  },

  -- =============================================================
  -- LSP / Mason / Formatter
  -- =============================================================
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = {
      ui = {
        border = "rounded",
        icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    config = function() require("configs.mason-tool-installer") end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim", "saghen/blink.cmp" },
    config = function() require("configs.lspconfig") end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function() require("configs.conform") end,
  },

  -- =============================================================
  -- Treesitter
  -- =============================================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function() require("configs.treesitter") end,
  },

  -- =============================================================
  -- Pickers / File / Git
  -- =============================================================
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function() require("configs.telescope") end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
    config = function() require("configs.nvim-tree") end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function() require("configs.gitsigns") end,
  },
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("configs.oil") end,
  },

  -- =============================================================
  -- Editor enhancement
  -- =============================================================
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
    config = function() require("configs.flash") end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function() require("configs.surround") end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = function() require("configs.trouble") end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    config = function() require("configs.ufo") end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    config = function() require("configs.toggleterm") end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- =============================================================
  -- mini.nvim：精選模組（Tier 3）
  -- =============================================================
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      return { n_lines = 500 }
    end,
  },
  -- mini.move 預設用 <M-h/j/k/l>；Mac 終端 Option 不送 Meta，且 Visual mode 已有 J/K
  -- 等價搬動選取，所以略過。若日後啟用，需自訂 opts.mappings 避開 Alt
  {
    "echasnovski/mini.bracketed",
    event = "BufReadPost",
    opts = {},
  },

  -- =============================================================
  -- Navigation
  -- =============================================================
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp",
      "TmuxNavigateRight", "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>",     desc = "Navigate Left" },
      { "<C-j>",  "<cmd><C-U>TmuxNavigateDown<cr>",     desc = "Navigate Down" },
      { "<C-k>",  "<cmd><C-U>TmuxNavigateUp<cr>",       desc = "Navigate Up" },
      { "<C-l>",  "<cmd><C-U>TmuxNavigateRight<cr>",    desc = "Navigate Right" },
      { "<C-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Navigate Previous" },
    },
  },
}
