# 推薦插件指南

本文檔列出所有推薦的 Neovim 增強插件，遵循**簡潔哲學**與**務實主義**原則。

---

## 📦 已安裝插件（預設）

### 核心功能（NvChad 內建）

| 插件 | 用途 | 狀態 |
|------|------|------|
| `nvim-cmp` | 自動補全引擎 | ✅ 已安裝 |
| `nvim-lspconfig` | LSP 配置 | ✅ 已安裝 |
| `mason.nvim` | LSP/Formatter 管理 | ✅ 已安裝 |
| `nvim-treesitter` | 語法高亮 | ✅ 已安裝 |
| `telescope.nvim` | 模糊搜尋 | ✅ 已安裝 |
| `gitsigns.nvim` | Git 裝飾 | ✅ 已安裝 |
| `Comment.nvim` | 快速註解 | ✅ 已安裝 |
| `nvim-autopairs` | 自動配對 | ✅ 已安裝 |
| `which-key.nvim` | 按鍵提示 | ✅ 已安裝 |
| `nvim-tree.lua` | 檔案樹 | ✅ 已安裝 |
| `nvim-colorizer.lua` | 顏色預覽 | ✅ 已安裝 |
| `indent-blankline.nvim` | 縮排線 | ✅ 已安裝 |

### 自訂安裝

| 插件 | 用途 | 狀態 |
|------|------|------|
| `conform.nvim` | 代碼格式化 | ✅ 已安裝 |
| `noice.nvim` | 現代化 UI | ✅ 已安裝 |
| `copilot.lua` | AI 補全 | ✅ 已安裝 |
| `vim-tmux-navigator` | Tmux 整合 | ✅ 已安裝 |

---

## ⭐ 推薦插件（強烈建議安裝）

### 1. flash.nvim - 超快速跳轉

**為何推薦**:
- 比傳統 `f/t/search` 快 10 倍
- 視覺回饋清晰，零學習成本
- 取代 hop.nvim / leap.nvim

**使用方式**:
```vim
s{char}      " 跳轉到任意字元
S            " Treesitter 節點跳轉
/pattern     " 搜尋時自動顯示跳轉標籤
```

**配置檔案**: `lua/configs/flash.lua`
**狀態**: ✅ 已配置

---

### 2. todo-comments.nvim - TODO 高亮

**為何推薦**:
- 自動高亮 `TODO`, `FIXME`, `NOTE` 等關鍵字
- 可用 Telescope 快速搜尋所有 TODO
- 符合你的文檔化紀律原則

**效果**:
```lua
-- TODO: 這會顯示為藍色高亮
-- FIXME: 這會顯示為紅色警告
-- PERF: 效能優化提醒
```

**快捷鍵**:
- `<leader>ft` - 使用 Telescope 搜尋所有 TODO

**配置檔案**: `lua/configs/todo-comments.lua`
**狀態**: ✅ 已配置

---

### 3. nvim-surround - 括號操作

**為何推薦**:
- 快速新增/修改/刪除括號、引號、標籤
- 減少重複編輯動作
- 符合 Good Taste 原則（簡潔優雅）

**使用方式**:
```vim
ysiw"        " 為當前詞加上雙引號: hello → "hello"
cs"'         " 替換引號: "hello" → 'hello'
ds"          " 刪除引號: "hello" → hello
yss)         " 為整行加括號
```

**常用操作**:
- `ysiwb` - 加圓括號 `()`
- `ysiwB` - 加大括號 `{}`
- `ysiwr` - 加方括號 `[]`
- `cst<div>` - 替換 HTML 標籤

**配置檔案**: `lua/configs/surround.lua`
**狀態**: ✅ 已配置

---

### 4. trouble.nvim - 診斷面板

**為何推薦**:
- 集中顯示所有 LSP 錯誤/警告
- 取代內建的 quickfix
- 符合可觀測性原則

**快捷鍵**:
- `<leader>xx` - 切換 Trouble 面板
- `<leader>xw` - 工作區診斷
- `<leader>xd` - 當前檔案診斷
- `gR` - LSP 引用列表

**配置檔案**: `lua/configs/trouble.lua`
**狀態**: ✅ 已配置

---

### 5. toggleterm.nvim - 終端管理

**為何推薦**:
- 浮動終端，不破壞佈局
- 支援多終端、Lazygit 整合
- 符合 CLI Tools First 原則

**快捷鍵**:
- `Ctrl+\` - 切換浮動終端
- `<leader>tf` - 浮動終端
- `<leader>th` - 水平分割終端
- `<leader>tv` - 垂直分割終端
- `<leader>gg` - 開啟 Lazygit
- `<leader>tp` - Python REPL
- `<leader>tn` - Node REPL

**終端內按鍵**:
- `Esc` 或 `jk` - 退出終端模式
- `Ctrl+h/j/k/l` - 切換窗口

**配置檔案**: `lua/configs/toggleterm.lua`
**狀態**: ✅ 已配置

---

## 🎯 可選插件（視需求安裝）

以下插件已建立配置檔案，但預設**註解停用**。若需要，取消 `plugins/init.lua` 中對應插件的註解即可啟用。

### 6. dressing.nvim - 美化 UI

**用途**: 使用 Telescope 取代 `vim.ui.select` 和 `vim.ui.input`

**效果**:
- 重新命名變數時顯示漂亮的輸入框
- 選擇 Code Action 時使用 Telescope

**啟用方式**:
```lua
-- 在 plugins/init.lua 中取消註解
{
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  config = function()
    require("configs.dressing")
  end,
},
```

**配置檔案**: `lua/configs/dressing.lua`
**狀態**: ⏸️ 已配置但未啟用

---

### 7. vim-illuminate - 高亮相同詞

**用途**: 自動高亮游標下的所有相同詞彙（包括變數、函式名）

**效果**:
- 游標移至 `foo` → 所有 `foo` 自動高亮
- 支援 LSP（識別語義，而非純字串匹配）

**快捷鍵**:
- `]]` - 跳至下一個高亮處
- `[[` - 跳至上一個高亮處

**啟用方式**:
```lua
{
  "RRethy/vim-illuminate",
  event = "BufReadPost",
  config = function()
    require("configs.illuminate")
  end,
},
```

**配置檔案**: `lua/configs/illuminate.lua`
**狀態**: ⏸️ 已配置但未啟用

---

### 8. nvim-ufo - 現代化折疊

**用途**: 美化的代碼折疊，支援 LSP、Treesitter

**效果**:
- 折疊時顯示預覽（不需展開即可查看內容）
- 智慧折疊（依據語法結構）

**快捷鍵**:
- `zR` - 展開所有折疊
- `zM` - 收合所有折疊
- `zp` - 預覽折疊內容

**前置需求**:
```bash
# 需要額外依賴
{
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
}
```

**啟用方式**:
```lua
{
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = "BufReadPost",
  config = function()
    require("configs.ufo")
  end,
},
```

**配置檔案**: `lua/configs/ufo.lua`
**狀態**: ⏸️ 已配置但未啟用

---

## 🚀 進階插件（特殊用途）

以下插件**未建立配置**，但值得考慮：

### 9. nvim-spectre - 全局搜尋替換

**用途**: 視覺化的全局搜尋與替換（類似 VSCode 的 Search & Replace）

**安裝**:
```lua
{
  "nvim-pack/nvim-spectre",
  cmd = "Spectre",
  keys = {
    { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
  },
  opts = { open_cmd = "noswapfile vnew" },
}
```

**快捷鍵**:
- `<leader>sr` - 開啟 Spectre

---

### 10. dial.nvim - 增強 Ctrl+a/Ctrl+x

**用途**: 增強數字遞增/遞減（支援日期、布林值、顏色等）

**效果**:
```lua
true  → Ctrl+a → false
#ff0000 → Ctrl+a → #ff0001
2024-01-01 → Ctrl+a → 2024-01-02
```

**安裝**:
```lua
{
  "monaqa/dial.nvim",
  keys = { "<C-a>", { "<C-x>", mode = "n" } },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.alias.bool,
      },
    })
  end,
}
```

---

### 11. mini.move - 移動行/區塊

**用途**: 使用 Alt+hjkl 快速移動行或選取區塊

**效果**:
```
Alt+j → 向下移動當前行
Alt+k → 向上移動當前行
Visual 模式 + Alt+j → 向下移動選取區塊
```

**安裝**:
```lua
{
  "echasnovski/mini.move",
  version = "*",
  config = function()
    require("mini.move").setup({
      mappings = {
        left = "<M-h>",
        right = "<M-l>",
        down = "<M-j>",
        up = "<M-k>",
        line_left = "<M-h>",
        line_right = "<M-l>",
        line_down = "<M-j>",
        line_up = "<M-k>",
      },
    })
  end,
}
```

---

## 📊 插件選擇指南

### 按使用頻率

| 頻率 | 插件 | 建議 |
|------|------|------|
| 極高 | flash.nvim, nvim-surround | ✅ 必裝 |
| 高 | todo-comments, trouble.nvim | ✅ 推薦 |
| 中 | toggleterm, dressing.nvim | ⚠️ 視需求 |
| 低 | illuminate, nvim-ufo | ⏸️ 可選 |

### 按功能類別

| 類別 | 插件 |
|------|------|
| **導航跳轉** | flash.nvim, illuminate |
| **編輯增強** | nvim-surround, dial.nvim, mini.move |
| **視覺體驗** | todo-comments, dressing.nvim, nvim-ufo |
| **診斷除錯** | trouble.nvim |
| **終端整合** | toggleterm.nvim |
| **搜尋替換** | nvim-spectre |

---

## 🔧 安裝與啟用

### 必裝插件（已啟用）

無需額外操作，重啟 Neovim 即可：

```bash
nvim
# Lazy.nvim 會自動安裝新插件
```

### 可選插件（需手動啟用）

1. 編輯 `lua/plugins/init.lua`
2. 找到對應插件的註解區塊
3. 取消註解（刪除 `--`）
4. 重啟 Neovim 或執行 `:Lazy sync`

**範例**:
```lua
-- 啟用前（註解狀態）
-- {
--   "stevearc/dressing.nvim",
--   event = "VeryLazy",
--   config = function()
--     require("configs.dressing")
--   end,
-- },

-- 啟用後（取消註解）
{
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  config = function()
    require("configs.dressing")
  end,
},
```

### 進階插件（需手動配置）

1. 將安裝代碼加入 `lua/plugins/init.lua`
2. 重啟 Neovim
3. 執行 `:Lazy sync`

---

## 🐛 疑難排解

### 插件載入失敗

```vim
" 1. 檢查 Lazy 狀態
:Lazy

" 2. 同步插件
:Lazy sync

" 3. 清除並重新安裝
:Lazy clean
:Lazy install
```

### 配置錯誤

```vim
" 檢查錯誤訊息
:messages

" 檢查健康狀態
:checkhealth lazy
```

### 按鍵衝突

若發現按鍵衝突，檢查：

```vim
" 查看所有映射
:map s       " 檢查 's' 鍵
:verbose map s  " 檢查映射來源
```

---

## 📚 參考資源

### 官方文檔

- [flash.nvim](https://github.com/folke/flash.nvim)
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
- [nvim-surround](https://github.com/kylechui/nvim-surround)
- [trouble.nvim](https://github.com/folke/trouble.nvim)
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)

### 相關技能

- `:help flash.nvim`
- `:help todo-comments`
- `:help nvim-surround.usage`
- `:TodoTelescope` - 搜尋所有 TODO
- `:TroubleToggle` - 切換診斷面板

---

## 🎯 總結

### 必裝清單（5 個）

1. ✅ flash.nvim - 超快速跳轉
2. ✅ todo-comments.nvim - TODO 高亮
3. ✅ nvim-surround - 括號操作
4. ✅ trouble.nvim - 診斷面板
5. ✅ toggleterm.nvim - 終端管理

**預期效果**: 編輯效率提升 30-50%，視覺體驗大幅改善

### 推薦搭配

**Python 開發者**:
- 必裝 5 個 + toggleterm (Python REPL)

**Web 開發者**:
- 必裝 5 個 + dressing.nvim

**大型專案維護者**:
- 必裝 5 個 + nvim-spectre + illuminate

---

**維護建議**: 每月執行一次 `:Lazy update` 更新所有插件。

最後更新: 2026-01-31
