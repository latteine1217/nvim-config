# Modern Neovim Configuration

獨立的現代 Neovim 配置（已脫離 NvChad 框架），基於 lazy.nvim、blink.cmp 與 Neovim 0.11+ native LSP，整合三層 AI 補完（Copilot ghost text、CodeCompanion、Avante）。

---

## ✨ 特色

- **Native LSP**：使用 0.11+ 的 `vim.lsp.config` / `vim.lsp.enable` API，capabilities 來自 blink.cmp
- **高效能補全**：`blink.cmp` 取代 nvim-cmp，每按鍵 0.5–4ms 開銷，內建 fuzzy matcher
- **三層 AI 並存**：copilot.lua（ghost text）、CodeCompanion（chat）、avante.nvim（sidebar diff），皆走 Copilot 認證
- **NvChad-style statusline**：lualine 復刻 NvChad default 樣式（圓潤 mode/location 塊）
- **完整 QoL 套件**：snacks.nvim（bigfile / scope / scratch / gitbrowse / dashboard）、oil.nvim（buffer 編輯目錄）、ufo（智慧折疊）、treesitter-context、fidget（LSP progress）
- **Mac 友善**：所有快捷鍵避開 `<M-*>`，Option 鍵不送 Meta 也能完整操作
- **錯誤可恢復**：所有 config 用 `pcall` 包，single plugin 失敗不影響整體啟動

---

## 📦 前置需求

- **Neovim ≥ 0.11**（使用 `vim.lsp.config`、`vim.o.winborder`；推薦 0.12+ 取得 inlay hints 自動啟用）
- **Git ≥ 2.19**
- **Node.js ≥ 18**（TypeScript LSP、Copilot）
- **Python ≥ 3.8**（pyright、black）
- **Rust toolchain**（avante.nvim 需編譯原生綁定）
- **Nerd Font**（圖示與 statusline 半圓塊顯示）
- **macOS / Linux**

---

## 🚀 安裝

```bash
# 1. 備份既有配置
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.backup 2>/dev/null

# 2. clone
git clone https://github.com/latteine1217/nvim-config.git ~/.config/nvim

# 3. 首次啟動（lazy.nvim 會自動安裝所有插件、avante 跑 make 編譯）
nvim
```

啟動後執行：

```vim
:Lazy sync               " 同步並 build
:MasonToolsInstall       " 安裝所有 LSP / formatter
:Copilot auth            " 登入 GitHub Copilot
:checkhealth             " 全面健康檢查
```

---

## 🏗️ 架構

### 目錄結構

```
~/.config/nvim/
├── init.lua                       # 入口（bootstrap lazy + 載入順序）
├── lazy-lock.json                 # 插件版本鎖定
├── lua/
│   ├── options.lua                # 全域選項
│   ├── mappings.lua               # leader 按鍵
│   ├── autocmds.lua               # autocommands（yank highlight 等）
│   ├── plugins/
│   │   └── init.lua               # lazy.nvim 唯一 spec 檔
│   └── configs/                   # 每個插件一個 config
│       ├── lazy.lua               # lazy.nvim 行為設定
│       ├── catppuccin.lua         # 主題
│       ├── lualine.lua            # statusline（NvChad-style）
│       ├── bufferline.lua         # buffer tabs
│       ├── which-key.lua          # leader 分群
│       ├── blink.lua              # 補全引擎
│       ├── snacks.lua             # folke QoL 套件
│       ├── lspconfig.lua          # 自有 on_attach + blink capabilities
│       ├── treesitter.lua
│       ├── telescope.lua
│       ├── nvim-tree.lua
│       ├── gitsigns.lua
│       ├── mason-tool-installer.lua
│       ├── conform.lua            # formatter
│       ├── copilot.lua            # AI ghost text
│       ├── codecompanion.lua      # AI chat
│       ├── avante.lua             # AI sidebar diff
│       ├── oil.lua                # 目錄編輯
│       ├── flash.lua              # 跳轉
│       ├── todo-comments.lua
│       ├── surround.lua
│       ├── trouble.lua
│       ├── toggleterm.lua
│       ├── ufo.lua                # 折疊
│       └── dressing.lua           # vim.ui 美化
└── README.md / PLUGINS.md
```

### 載入流程

```
init.lua
  │
  ├─ set leader
  ├─ require("options")          ← 編輯器選項（含 winborder = "rounded"）
  ├─ require("autocmds")         ← yank highlight / mkdir / 恢復游標
  ├─ bootstrap lazy.nvim
  ├─ lazy.setup({ import = "plugins" })
  │     │
  │     └─ plugins/init.lua → 每個 plugin spec → require("configs.<name>")
  │
  └─ vim.schedule(require("mappings"))   ← 延遲到指令存在後
```

### 設計取捨

1. **單一 plugin spec 檔**：所有插件統一在 `plugins/init.lua`，依用途分區註解
2. **每插件一個 config**：`configs/<plugin>.lua` 一一對應，避免 god-file
3. **無 framework**：不再依賴任何 starter（NvChad / LazyVim / kickstart），完全自管
4. **0.11+ native LSP**：用 `vim.lsp.config(server, {...})` + `vim.lsp.enable(server)`
5. **blink 提供 LSP capabilities**：替代 cmp-nvim-lsp 的角色

---

## ⌨️ 主要按鍵

`<leader>` = Space。完整列表開啟 nvim 後按 `<Space>` 等 which-key 浮窗。

### Leader 分群

| 前綴 | 分類 |
|---|---|
| `<leader>a` | **AI: CodeCompanion**（chat / actions）|
| `<leader>A` | **AI: Avante**（sidebar diff）|
| `<leader>b` | Buffer 操作 |
| `<leader>c` | Code（action / diagnostic / Copilot panel）|
| `<leader>f` | Find / Telescope |
| `<leader>g` | Git |
| `<leader>r` | Rename / Refactor |
| `<leader>s` | Split |
| `<leader>t` | Terminal / Toggle |

### 基本

| 鍵 | 功能 |
|---|---|
| `;` | 進入命令模式（取代 `:`） |
| `jk` | 退出 insert 模式 |
| `<Esc>` | 清除搜尋高亮 |
| `<leader>w` / `<leader>q` | 存檔 / 退出 |

### Find / Telescope

| 鍵 | 功能 |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fw` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fo` | Recent files |
| `<leader>fh` / `<leader>fk` / `<leader>fm` / `<leader>fr` | Help / Keymaps / Marks / Resume |

### File explorer

| 鍵 | 功能 |
|---|---|
| `<leader>e` / `<leader>E` | nvim-tree toggle / reveal |
| `-` | 用 oil 編輯父目錄 |
| `<leader>fo` | oil 浮動視窗 |

### Buffer / Window

| 鍵 | 功能 |
|---|---|
| `<S-h>` / `<S-l>` | 上/下一個 buffer |
| `<leader>x` | 關閉當前 buffer |
| `<leader>sv` / `<leader>sh` / `<leader>sx` | Vertical / Horizontal split / close |
| `<C-h/j/k/l>` | tmux-aware window 導航 |

### LSP（buffer-local，attach 後生效）

| 鍵 | 功能 |
|---|---|
| `gd` / `gD` / `gi` / `gr` / `gy` | Go to definition / declaration / implementation / references / type def |
| `K` | Hover docs |
| `<C-k>` | Signature help |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |
| `<leader>cd` | Diagnostic float |
| `[d` / `]d` | 上 / 下一個 diagnostic |
| `<leader>ti` | Toggle inlay hints |

### Git（gitsigns）

| 鍵 | 功能 |
|---|---|
| `]c` / `[c` | 下 / 上一個 hunk |
| `<leader>gs` / `<leader>gr` | Stage / reset hunk |
| `<leader>gS` / `<leader>gR` | Stage / reset buffer |
| `<leader>gp` | Preview hunk |
| `<leader>gd` / `<leader>gD` | Diff this / against HEAD~ |
| `<leader>gb` | Blame line (full) |
| `<leader>tb` | Toggle inline blame |
| `<leader>gB` | Open in browser（snacks.gitbrowse）|
| `ih` (v/o) | Hunk textobject |

### AI

**Copilot ghost text**（Insert mode，Mac 友善鍵）

| 鍵 | 功能 |
|---|---|
| `<C-y>` | 接受整段建議 |
| `<C-Right>` | 接受下一個 word |
| `<C-]>` | 關閉建議 |
| `<C-CR>` | 開啟 panel |
| `<leader>cp` | 開啟 panel（normal mode）|

**CodeCompanion**

| 鍵 | 功能 |
|---|---|
| `<leader>ac` | Toggle chat |
| `<leader>aa` | Actions |
| `<leader>ae`（v）| 將選取加入 chat |
| `<leader>ai` | Inline prompt |

**Avante**

| 鍵 | 功能 |
|---|---|
| `<leader>Aa` / `<leader>Ae` / `<leader>At` | Ask / Edit / Toggle sidebar |
| `<leader>Ar` / `<leader>Am` | Refresh / Switch model |

### Snacks / Toggle

| 鍵 | 功能 |
|---|---|
| `<leader>.` | Scratch buffer toggle |
| `<leader>S` | Select scratch |
| `<leader>tc` | Toggle treesitter context（sticky function header）|
| `<leader>ti` | Toggle inlay hints |
| `<leader>tb` | Toggle git blame line |

### Lazy / Mason

| 鍵 | 功能 |
|---|---|
| `<leader>L` | Lazy plugin manager |
| `<leader>M` | Mason package manager |

---

## 🛠️ 自訂

### 新增 LSP server

1. 在 `lua/configs/mason-tool-installer.lua` 的 `ensure_installed` 加入工具名（e.g. `"rust-analyzer"`）
2. 在 `lua/configs/lspconfig.lua` 呼叫 `setup_lsp("rust_analyzer", {...})`

範例：

```lua
-- mason-tool-installer.lua
ensure_installed = {
  ...
  "rust-analyzer",
}

-- lspconfig.lua
setup_lsp("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = { cargo = { allFeatures = true } },
  },
})
```

### 新增 formatter

1. mason-tool-installer 加 `"rustfmt"`
2. 在 `lua/configs/conform.lua` 加 `formatters_by_ft = { rust = { "rustfmt" } }`

### 換主題

`lua/configs/catppuccin.lua` 改 `flavour`：`latte` / `frappe` / `macchiato` / `mocha`。或改 plugin spec 換成其他主題（tokyonight / kanagawa / rose-pine 等），記得移除 catppuccin spec、把 lualine theme 改為對應。

### 啟用 vim-illuminate（已備好但停用）

`lua/plugins/init.lua` 最末段把註解塊取消即可。snacks.words 也能達到類似效果，二擇一。

---

## 🐛 除錯

| 症狀 | 排查 |
|---|---|
| 插件載入失敗 | `:Lazy`、`:Lazy sync`、`:messages` |
| LSP 沒啟動 | `:LspInfo`、`:Mason`、`:MasonToolsInstall`、`:checkhealth lsp` |
| 補全沒出現 | `:lua print(require("blink.cmp"))`、檢查 filetype 是否有 LSP |
| Copilot 沒 ghost text | `:Copilot status`、`:Copilot auth`，確認 filetype 不在 copilot.lua 排除清單 |
| 圖示亂碼 | 終端機字型改用 Nerd Font（推薦 JetBrainsMono Nerd Font） |
| statusline 半圓塊變方形 | 同上，需 Nerd Font |
| Tmux 跨窗導航失效 | 檢查 `~/.tmux.conf` 是否有 vim-tmux-navigator bindings |

```vim
:checkhealth                " 整體健康
:checkhealth lazy           " lazy.nvim
:checkhealth nvim-treesitter
:checkhealth blink.cmp
:Lazy profile               " 啟動時間分析
```

---

## 🔄 維護

```vim
:Lazy update                " 更新所有插件
:Lazy clean                 " 清掉已 disable / 移除 spec 的舊插件
:MasonUpdate                " 更新 LSP / formatter
:TSUpdate                   " 更新 treesitter parser
```

`lazy-lock.json` 鎖定版本，建議每次 `:Lazy update` 後 commit。

---

## 📄 授權

MIT
