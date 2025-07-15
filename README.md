# Optimized NvChad Configuration

這是一個經過優化的 Neovim 配置，基於 NvChad 框架，提供更好的代碼可讀性和組織結構。

## 特色功能

- **LSP 支援**: TypeScript、Python、HTML、CSS、Lua 等
- **代碼格式化**: 自動格式化保存
- **GitHub Copilot**: AI 代碼補全
- **Tmux 導航**: 無縫窗口切換
- **優化的按鍵映射**: 直觀的編輯體驗

## 安裝

1. 備份現有配置：
```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

2. 克隆此配置：
```bash
git clone <your-repo-url> ~/.config/nvim
```

3. 啟動 Neovim 並等待插件安裝完成

## 主要配置文件

- `init.lua` - 主入口文件
- `lua/options.lua` - 編輯器選項
- `lua/mappings.lua` - 按鍵映射
- `lua/chadrc.lua` - NvChad 主題配置
- `lua/plugins/init.lua` - 插件配置
- `lua/configs/lspconfig.lua` - LSP 配置
- `lua/configs/conform.lua` - 格式化配置

## 依賴要求

- Neovim >= 0.9.0
- Git
- Node.js (用於 Copilot 和 TypeScript LSP)
- 推薦使用 Nerd Font

---

🤖 此配置由 [opencode](https://opencode.ai) + GitHub Copilot 開發優化