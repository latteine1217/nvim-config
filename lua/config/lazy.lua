--[[
Module: config.lazy
Purpose: lazy.nvim bootstrap + 載入 LazyVim 主幹、extras 與本地 override
Note: lua/config 下的 options/keymaps/autocmds 由 LazyVim 自動載入，不需手動 require
--]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- LazyVim 主幹與預設插件（neo-tree / snacks.picker / tokyonight / blink.cmp 等）
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- extras 由 lazyvim.json 管理；以下匯入該檔啟用的模組
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.lang.toml" },
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.ai.copilot" },
    { import = "lazyvim.plugins.extras.ai.copilot-chat" },
    { import = "lazyvim.plugins.extras.ai.avante" },
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.test.core" },
    { import = "lazyvim.plugins.extras.editor.refactoring" },

    -- 本地 override / 新增插件
    { import = "plugins" },
  },
  defaults = {
    -- 本地 spec 預設 lazy；LazyVim 已對自身插件做好 lazy 標記
    lazy = false,
    version = false, -- 始終使用最新 commit（依 lazy-lock.json 鎖定）
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- 背景檢查更新
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
