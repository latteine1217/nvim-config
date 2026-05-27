# 插件清單

本檔列出此配置的所有插件，依用途分類；每項給出**用途**、**config 檔**、**主要快捷鍵**。

完整 spec 在 `lua/plugins/init.lua`，各 plugin config 在 `lua/configs/<name>.lua`。

---

## 🎨 UI / Theme

### catppuccin/nvim — 主題

- **用途**：取代原 NvChad base46，提供 catppuccin mocha flavour
- **config**：`configs/catppuccin.lua`
- **整合**：blink_cmp / gitsigns / nvim-tree / telescope / bufferline / mini / mason / which_key / flash / snacks

### nvim-lualine/lualine.nvim — Statusline

- **用途**：復刻 NvChad default 樣式：圓潤 mode/location 塊、平整中段
- **config**：`configs/lualine.lua`
- **顯示**：mode → branch → filename/diff/diagnostics → recording / lazy updates / LSP server / encoding / cwd / filetype → progress → location
- **半圓塊**：用 `string.char` 構造 UTF-8 位元組避開 PUA 過濾

### akinsho/bufferline.nvim — Buffer tabs

- **用途**：頂端 buffer 分頁條
- **config**：`configs/bufferline.lua`
- **快捷鍵**：`<S-h>`/`<S-l>` 切換、`<leader>x` 關閉、`<leader>bp` pin、`<leader>bo` close others

### folke/snacks.nvim — QoL 集合

- **用途**：folke 的多功能 QoL 套件
- **config**：`configs/snacks.lua`
- **啟用模組**：
  - `bigfile`（大檔自動關昂貴功能）
  - `quickfile`（加速大檔開啟）
  - `scope`（智慧縮排區塊偵測）
  - `scratch`（草稿 buffer）
  - `gitbrowse`（用瀏覽器打開 GitHub 連結）
  - `dashboard`（取代 NvChad nvdash，沿用原 ASCII header）
- **快捷鍵**：`<leader>.` scratch、`<leader>S` select scratch、`<leader>gB` git browse
- **不啟用**：notifier（noice 接管）、indent（indent-blankline 接管）、lazygit（toggleterm 接管）、picker/explorer（telescope/nvim-tree 接管）

### folke/which-key.nvim — Leader 浮窗

- **用途**：按 `<leader>` 後顯示分群選單
- **config**：`configs/which-key.lua`
- **分群**：a=CodeCompanion / A=Avante / b=Buffer / c=Code / f=Find / g=Git / r=Rename / s=Split / t=Terminal-or-Toggle

### folke/noice.nvim — 現代化命令列 UI

- **用途**：取代 default cmdline、訊息提示、search popup
- **依賴**：nui.nvim、nvim-notify
- **opts**：`bottom_search`、`command_palette`、`long_message_to_split`

### stevearc/dressing.nvim — vim.ui 美化

- **用途**：`vim.ui.select` / `vim.ui.input` 改用 telescope dropdown 與漂亮輸入框
- **config**：`configs/dressing.lua`

### folke/todo-comments.nvim — TODO 高亮

- **用途**：自動高亮 `TODO`、`FIXME`、`NOTE`、`PERF` 等關鍵字
- **config**：`configs/todo-comments.lua`
- **指令**：`:TodoTelescope` 列出所有

### lukas-reineke/indent-blankline.nvim — 縮排線

- **用途**：顯示縮排垂直線
- **opts**：`indent.char = "│"`、`scope.enabled = false`

### j-hui/fidget.nvim — LSP 進度提示

- **用途**：右下角顯示 LSP loading spinner
- **event**：`LspAttach` 時載入

### nvim-treesitter/nvim-treesitter-context — Sticky function header

- **用途**：長函式內捲動時頂端顯示 sticky context
- **快捷鍵**：`<leader>tc` toggle
- **opts**：max_lines 3、mode cursor

### onsails/lspkind.nvim — 補全 kind icons

- **用途**：供 blink.cmp menu 顯示 function / variable / method 等圖示

---

## ⚡ Completion / Snippets

### saghen/blink.cmp — 補全引擎

- **用途**：取代 nvim-cmp，0.5–4ms / keystroke
- **config**：`configs/blink.lua`
- **sources**：lsp、snippets、path、buffer（內建）
- **snippet 後端**：LuaSnip
- **keymap preset**：`default`（`<C-Space>` 觸發、`<C-n>`/`<C-p>` 上下、`<CR>` 接受）
- **額外**：`<Tab>` snippet jump、`<C-d>`/`<C-u>` 捲文件
- **整合**：menu 用 lspkind icon、cmdline 也啟用補全
- **被關閉的舊套件**（spec 內 `enabled = false`）：`nvim-cmp` / `cmp-nvim-lsp` / `cmp-nvim-lua` / `cmp-buffer` / `cmp_luasnip` / `cmp-async-path`

### L3MON4D3/LuaSnip — Snippet 引擎

- **依賴**：friendly-snippets
- **build**：`make install_jsregexp`

### rafamadriz/friendly-snippets — Snippet 集

- **用途**：社群維護的多語言 snippet 庫

---

## 🤖 AI 三層

### zbirenbaum/copilot.lua — Ghost text 補完

- **用途**：打字時自動跳出灰字提示
- **config**：`configs/copilot.lua`
- **快捷鍵（Mac 友善）**：
  - `<C-y>` 接受整段
  - `<C-Right>` 接受 word
  - `<C-]>` 關閉建議
  - `<C-CR>` 開啟 panel
  - `<leader>cp` 開啟 panel（normal mode）
- **互動**：`hide_during_completion = true`，blink 選單開時隱藏 ghost
- **不啟用 filetype**：yaml、markdown、help、gitcommit、gitrebase

### olimorris/codecompanion.nvim — AI Chat

- **用途**：對話、refactor、slash commands
- **config**：`configs/codecompanion.lua`
- **adapter**：copilot（沿用既有認證）、model=claude-sonnet-4
- **快捷鍵**：`<leader>ac` chat / `<leader>aa` actions / `<leader>ae` 加選取進 chat / `<leader>ai` inline

### yetone/avante.nvim — Cursor 風格 sidebar

- **用途**：sidebar diff workflow，select code → ask → diff → apply
- **config**：`configs/avante.lua`
- **adapter**：copilot、model=claude-sonnet-4
- **build**：`make`（編譯 4 個 Rust dylib）
- **快捷鍵**：`<leader>Aa` ask / `<leader>Ae` edit / `<leader>At` toggle sidebar / `<leader>Ar` refresh / `<leader>Am` 切模型
- **diff conflicts**：`co/ct/ca/cb/cc`、`]x/[x`

---

## 🔧 LSP / Mason / Formatter

### neovim/nvim-lspconfig

- **config**：`configs/lspconfig.lua`
- **API**：0.11+ `vim.lsp.config()` / `vim.lsp.enable()`
- **on_attach**：buffer-local LSP 快捷鍵 + inlay hints 自動啟用
- **capabilities**：來自 `blink.cmp.get_lsp_capabilities()`
- **已配置 server**：`html` / `cssls` / `pyright` / `clangd` / `ts_ls` / `lua_ls`
- **快捷鍵**：`gd/gD/gi/gr/gy/K/<C-k>/<leader>rn/<leader>ca/<leader>cd/[d/]d/<leader>ti`

### williamboman/mason.nvim — LSP/工具包管理器

- **opts**：rounded border、自訂 icons

### WhoIsSethDaniel/mason-tool-installer.nvim — 自動安裝

- **config**：`configs/mason-tool-installer.lua`
- **ensure_installed**：`lua-language-server` / `stylua` / `css-lsp` / `html-lsp` / `typescript-language-server` / `prettier` / `eslint-lsp` / `clangd` / `clang-format` / `pyright` / `black` / `mypy` / `debugpy`
- **指令**：`:MasonToolsInstall` / `:MasonToolsUpdate`

### stevearc/conform.nvim — Formatter

- **config**：`configs/conform.lua`
- **trigger**：BufWritePre 保存時自動格式化
- **fallback**：無專用 formatter 時用 LSP

---

## 🌳 Treesitter

### nvim-treesitter/nvim-treesitter

- **config**：`configs/treesitter.lua`
- **ensure_installed**：vim/vimdoc/lua/luadoc/c/cpp/python/javascript/typescript/tsx/html/css/json/yaml/toml/markdown/markdown_inline/bash/regex/query
- **incremental selection**：`grn` (init/expand) / `grm` (shrink) / `grs` (scope)
  - 避免與 blink.cmp 的 `<C-Space>` 觸發鍵衝突

---

## 🔍 Picker / Explorer / Git

### nvim-telescope/telescope.nvim

- **config**：`configs/telescope.lua`
- **依賴**：plenary、telescope-fzf-native（make build）
- **快捷鍵**：`<leader>ff/fw/fb/fh/fo/fm/fk/fr`

### nvim-tree/nvim-tree.lua — 側邊欄檔案樹

- **config**：`configs/nvim-tree.lua`
- **快捷鍵**：`<leader>e` toggle / `<leader>E` reveal

### stevearc/oil.nvim — buffer-style 目錄編輯

- **config**：`configs/oil.lua`
- **與 nvim-tree 共存**：default_file_explorer = false
- **快捷鍵**：`-` 開父目錄、`<leader>fo` 浮動視窗
- **safer**：delete_to_trash = true

### lewis6991/gitsigns.nvim — Git 邊欄

- **config**：`configs/gitsigns.lua`
- **顯示**：邊欄 hunk 符號、preview / blame
- **快捷鍵**：
  - `]c` / `[c` 上下 hunk
  - `<leader>gs/gr` stage/reset hunk
  - `<leader>gS/gR` stage/reset buffer
  - `<leader>gp` preview
  - `<leader>gd/gD` diff this / diff HEAD~
  - `<leader>gb` full blame
  - `<leader>tb` toggle inline blame
  - `ih` (v/o) hunk textobject

---

## ⌨️ Editor 增強

### folke/flash.nvim — 跳轉

- **config**：`configs/flash.lua`
- **快捷鍵**：`s` jump、`S` treesitter、`r` (o) remote、`R` (o/x) treesitter search、`<C-s>` (c) toggle search

### kylechui/nvim-surround — 括號操作

- **config**：`configs/surround.lua`
- **版本**：v4（已移除 setup keymaps 寫法，沿用插件預設）
- **預設按鍵**（無需設定）：`ys{motion}{char}` / `ds{char}` / `cs{old}{new}` / Visual `S{char}`

### echasnovski/mini.ai — 智慧 textobject

- **opts**：`n_lines = 500`
- **效果**：`a)` / `i)` 等更聰明（支援多行、跨檔結構）

### echasnovski/mini.bracketed — `]x/[x` 跳轉

- **效果**：`]b/[b` buffer、`]d/[d` diagnostic、`]q/[q` quickfix、`]l/[l` location list、`]t/[t` treesitter node 等

### folke/trouble.nvim — 診斷面板

- **config**：`configs/trouble.lua`
- **指令**：`:Trouble`、`:TroubleToggle`

### kevinhwang91/nvim-ufo — 智慧折疊

- **config**：`configs/ufo.lua`
- **依賴**：promise-async
- **快捷鍵**：`zR` 全開 / `zM` 全合 / `zr` fold less / `zm` fold more / `zp` peek
- **fillchars**：foldopen `▾` / foldclose `▸`（用 Unicode 三角形以避開 NerdFont PUA 字元被剝光）

### akinsho/toggleterm.nvim — 浮動終端

- **config**：`configs/toggleterm.lua`
- **快捷鍵**：`<C-\>` toggle / `<leader>tf/th/tv` float/horizontal/vertical / `<leader>gg` lazygit / `<leader>tp` Python REPL / `<leader>tn` Node REPL

### windwp/nvim-autopairs — 自動配對

- **event**：InsertEnter
- **opts**：預設

---

## 🧭 Navigation

### christoomey/vim-tmux-navigator

- **快捷鍵**：`<C-h/j/k/l>` 跨 nvim 與 tmux pane 導航、`<C-\>` 上一個 pane

---

## ⛔ 已停用 / 預留

### vim-illuminate — 高亮相同詞

- **狀態**：spec 已註解、config 仍在
- **替代**：snacks.words 可達類似效果
- **啟用**：取消 `plugins/init.lua` 末段註解

### mini.move — Alt+hjkl 移動行/塊

- **狀態**：移除（Mac 終端 Option 不送 Meta，且 Visual J/K 已等價）

---

## 📦 完整依賴樹

```
plenary.nvim ── telescope / codecompanion / avante / gitsigns / todo-comments
nui.nvim     ── noice / avante / codecompanion / dressing
nvim-web-devicons ── lualine / bufferline / nvim-tree / oil / avante / telescope
nvim-notify  ── noice
promise-async ── nvim-ufo
friendly-snippets ── LuaSnip ── blink.cmp
copilot.lua  ── codecompanion / avante（共用 Copilot 認證）
```

---

## 📊 速查：按類別

| 類別 | 插件 |
|---|---|
| **主題 / UI** | catppuccin、lualine、bufferline、snacks、which-key、noice、dressing、indent-blankline、todo-comments、fidget、treesitter-context、lspkind |
| **補全 / Snippet** | blink.cmp、LuaSnip、friendly-snippets |
| **AI** | copilot.lua、CodeCompanion、avante.nvim |
| **LSP / Mason** | nvim-lspconfig、mason.nvim、mason-tool-installer、conform |
| **Treesitter** | nvim-treesitter、nvim-treesitter-context |
| **Picker / Explorer / Git** | telescope（+ fzf-native）、nvim-tree、oil、gitsigns |
| **Editor 增強** | flash、surround、mini.ai、mini.bracketed、trouble、ufo、toggleterm、autopairs |
| **Navigation** | vim-tmux-navigator |

---

## 🔄 維護指令

```vim
:Lazy                       " 插件管理 UI
:Lazy update                " 更新全部
:Lazy clean                 " 清除已 disable / 移除的
:MasonToolsInstall          " 安裝 mason-tool-installer 清單
:MasonToolsUpdate           " 更新
:TSUpdate                   " 更新 treesitter parser
:checkhealth                " 全面健康檢查
```

---

最後更新：2026-05-27
