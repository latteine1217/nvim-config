# Neovim Configuration (LazyVim-based)

基於 [LazyVim](https://www.lazyvim.org/) 的 Neovim 配置：以 LazyVim 為主幹取得現代化預設（snacks 生態、blink.cmp、tokyonight、native LSP），透過 **extras** 一鍵啟用語言/工具模組，僅以少量 override 保留個人偏好（avante AI sidebar、oil、tmux 導航與個人鍵位）。

> 設計原則：**能交給 LazyVim 的就交給它**，本地只維護 delta。升級跟著上游走，維護成本最低。

---

## 📦 前置需求

- **Neovim ≥ 0.11**（本配置以 0.12 驗證；`winborder` 需 0.11+）
- **Git ≥ 2.19**、**Nerd Font**、**make / C 編譯器**（avante、blink、treesitter 需編譯）
- **Node.js ≥ 18**（Copilot、TS LSP）、**Python ≥ 3.8**（uv / ruff / pyright）
- **ripgrep**、**fd**（snacks.picker grep / find）

## 🚀 安裝

```bash
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.backup 2>/dev/null
git clone <this-repo> ~/.config/nvim
nvim                       # 首次啟動自動安裝、編譯
```

啟動後：`:Lazy sync` → `:Copilot auth`（登入）→ `:checkhealth`。

---

## 🏗️ 架構

```
~/.config/nvim/
├── init.lua                 # 僅 require("config.lazy")
├── lazyvim.json             # 啟用的 extras 清單（:LazyExtras 管理）
├── lazy-lock.json           # 版本鎖定
├── lua/
│   ├── config/              # LazyVim 自動載入（在其預設之後）
│   │   ├── lazy.lua         #   bootstrap + LazyVim import + extras import + plugins import
│   │   ├── options.lua      #   個人 option delta（winborder / timeoutlen）
│   │   ├── keymaps.lua      #   個人 keymap delta（;→: · jk→Esc · 可視模式 J/K 搬移）
│   │   └── autocmds.lua     #   空（yank 高亮等已由 LazyVim 內建）
│   └── plugins/             # 本地 override / 新增插件
│       ├── ai.lua           #   avante opts override（provider=copilot / selector=snacks）
│       └── extras.lua       #   oil.nvim + vim-tmux-navigator（純新增）
```

**載入流程**：`init.lua` → `config.lazy` → 匯入 `LazyVim/LazyVim`（主幹預設）→ 匯入 extras → 匯入本地 `plugins/`（override 深層合併在最後）。

### 核心元件（皆為 LazyVim 現行原生預設）

| 功能 | 採用 |
|---|---|
| 主題 | tokyonight（moon） |
| 檔案總管 | snacks.explorer（`<leader>e`） |
| Picker | snacks.picker（`<leader>ff` / `<leader>sg` …） |
| 補全 | blink.cmp |
| Statusline / 終端 / git / which-key / 跳轉 / 環繞 / autopairs / treesitter-context | LazyVim 預設 |

### 啟用的 Extras（`lazyvim.json`）

`lang.python`(ruff/debugpy) · `lang.markdown` · `lang.json` · `lang.yaml` · `lang.toml` · `lang.docker` · `lang.typescript` · `ai.copilot` · `ai.copilot-chat` · `ai.avante` · `dap.core` · `test.core` · `editor.refactoring`

> 用 `:LazyExtras` 互動式增減；新增後 `:Lazy sync`。

### 本地保留的插件

| 插件 | 用途 | 鍵位 |
|---|---|---|
| **avante.nvim** | Cursor 風格 AI sidebar（diff-first，走 Copilot 認證） | `<leader>A*`（Ask/Edit/Toggle/Refresh/Models） |
| **oil.nvim** | buffer 式目錄編輯 | `-` 進父目錄、`<leader>fo` 浮動 |
| **vim-tmux-navigator** | nvim split ↔ tmux pane 無縫切換 | `<C-h/j/k/l>` |

---

## ⌨️ 按鍵

`<leader>` = Space。多數鍵位採 **LazyVim 標準**，按 `<Space>` 由 which-key 浮窗瀏覽，或 `<leader>sk` 搜尋 keymaps。

**個人 delta（覆寫預設）**

| 鍵 | 功能 |
|---|---|
| `;` | 進入命令模式 |
| `jk` | 退出 insert 模式 |
| `J` / `K`（visual） | 搬移選取並保持選取 |

**AI**：`<leader>aa` Copilot Chat 群組（LazyVim）；`<leader>A*` Avante 群組（本地）；Insert 模式 blink 選單內含 Copilot 補全。

---

## 🛠️ 自訂

- **新增語言/工具**：`:LazyExtras` 勾選 → `:Lazy sync`（自動帶 LSP + formatter + treesitter + DAP）。
- **覆寫某插件**：在 `lua/plugins/` 新增檔案回傳 spec，`opts` 會與 LazyVim 預設深層合併。
- **換主題**：在 `lua/plugins/` override `LazyVim` 的 `colorscheme`，或啟用對應 colorscheme extra。
- **Python LSP**：預設 pyright；如需 basedpyright，在 `options.lua` 設 `vim.g.lazyvim_python_lsp = "basedpyright"`。

## 🐛 除錯

```vim
:Lazy            " 插件狀態 / sync / profile
:LazyExtras      " 管理 extras
:LazyHealth      " LazyVim 健康檢查
:checkhealth     " 整體
:Mason           " LSP / formatter / DAP 安裝
:Copilot status  " Copilot 認證狀態
```

`lazy-lock.json` 鎖定版本。本 repo 目前於 `.gitignore` 排除它（不追蹤）；若要跨機可重現，移除該行並 commit 即可。

## 📄 授權

MIT
