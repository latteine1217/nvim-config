--[[
Module: which-key
Purpose: leader namespace 分群展示
Dependencies: which-key.nvim (v3)
--]]

local ok, wk = pcall(require, "which-key")
if not ok then
  vim.notify("which-key 載入失敗", vim.log.levels.ERROR)
  return
end

wk.setup({
  preset = "modern",
  win = { border = "rounded" },
  icons = {
    breadcrumb = "»",
    separator  = "➜",
    group      = "+",
    mappings   = true,
    rules      = false,
  },
  delay = function(ctx) return ctx.plugin and 0 or 200 end,
})

wk.add({
  -- 第一層分群
  { "<leader>a",  group = "AI: CodeCompanion" },
  { "<leader>A",  group = "AI: Avante"        },
  { "<leader>b",  group = "Buffer"            },
  { "<leader>c",  group = "Code"              },
  { "<leader>f",  group = "Find / Telescope"  },
  { "<leader>g",  group = "Git"               },
  { "<leader>r",  group = "Rename / Refactor" },
  { "<leader>s",  group = "Split"             },
  { "<leader>t",  group = "Terminal / Toggle" },
  { "<leader>x",  group = "Buffer close"      },

  -- 常用單鍵描述（明確標示，避免 "WhichKey: no mapping" 提示）
  { "<leader>w",  desc = "Save file"        },
  { "<leader>q",  desc = "Quit"             },
  { "<leader>n",  desc = "New file"         },
  { "<leader>e",  desc = "File tree"        },
  { "<leader>E",  desc = "Reveal in tree"   },
  { "<leader>L",  desc = "Lazy"             },
  { "<leader>M",  desc = "Mason"            },
  { "<leader>.",  desc = "Scratch buffer"   },
  { "<leader>S",  desc = "Select scratch"   },

  -- Code 子節點預先掛描述（不會擋你之後 LSP on_attach 設定）
  { "<leader>ca", desc = "Code action"      },
  { "<leader>cd", desc = "Diagnostic float" },

  -- Toggle 群（之後 inlay hints 等加在這）
  { "<leader>ti", desc = "Toggle inlay hints" },
  { "<leader>tc", desc = "Toggle TS context"  },
  { "<leader>tb", desc = "Toggle git blame line" },
})
