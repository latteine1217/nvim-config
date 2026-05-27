--[[
Module: ufo
Purpose: 現代化代碼折疊（LSP + Treesitter）
Dependencies: nvim-ufo, promise-async
Usage: 由 plugins/init.lua 自動載入
--]]

local ok, ufo = pcall(require, "ufo")
if not ok then
  vim.notify("nvim-ufo 載入失敗", vim.log.levels.ERROR)
  return
end

-- Vim 折疊選項
vim.o.foldcolumn = "1" -- 顯示折疊欄位（'0' 隱藏）
vim.o.foldlevel = 99 -- 預設展開所有折疊
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- 折疊欄位字元（每個欄位都需恰好 1 個字元；0.12+ 嚴格檢查）
-- 使用常見 Unicode 三角形（U+25BE / U+25B8），確保跨字型一致顯示
vim.opt.fillchars:append({
  eob       = " ",
  fold      = " ",
  foldsep   = " ",
  foldopen  = "▾",
  foldclose = "▸",
})

ufo.setup({
  -- 折疊提供者優先順序
  provider_selector = function(bufnr, filetype, buftype)
    return { "treesitter", "indent" }
  end,

  -- 折疊虛擬文字（顯示折疊內容預覽）
  fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ("  %d "):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0

    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, { chunkText, hlGroup })
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end

    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
  end,

  -- 預覽配置
  preview = {
    win_config = {
      border = { "", "─", "", "", "", "─", "", "" },
      winhighlight = "Normal:Folded",
      winblend = 0,
    },
    mappings = {
      scrollU = "<C-u>",
      scrollD = "<C-d>",
      jumpTop = "[",
      jumpBot = "]",
    },
  },

  -- 關閉折疊時的行為
  close_fold_kinds_for_ft = {
    default = { "imports", "comment" },
  },

  -- 啟用折疊的檔案類型
  enable_get_fold_virt_text = true,
})

-- 快捷鍵
local map = vim.keymap.set

-- 使用 ufo 的折疊指令
map("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
map("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
map("n", "zr", ufo.openFoldsExceptKinds, { desc = "Fold less" })
map("n", "zm", ufo.closeFoldsWith, { desc = "Fold more" })
map("n", "zp", function()
  local winid = ufo.peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = "Peek fold or hover" })
