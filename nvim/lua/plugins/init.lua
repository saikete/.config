-- return {
--   {
--     "stevearc/conform.nvim",
--     -- event = 'BufWritePre', -- uncomment for format on save
--     opts = require "configs.conform",
--   },
--
--   -- These are some examples, uncomment them if you want to see them work!
--   {
--     "neovim/nvim-lspconfig",
--     config = function()
--       require "configs.lspconfig"
--     end,
--   },
--
--   -- {
--   -- 	"nvim-treesitter/nvim-treesitter",
--   -- 	opts = {
--   -- 		ensure_installed = {
--   -- 			"vim", "lua", "vimdoc",
--   --      "html", "css"
--   -- 		},
--   -- 	},
--   -- },
-- }

return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  --
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
      },
    },
  },
  --
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "json",
        "html",
        "css",
        "vim",
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "scss",
        "regex",
        "vue",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      -- 启用增量选择模块
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<BS>",
          scope_incremental = "<TAB>",
        },
      },
      -- 启用代码缩进模块 (=)
      indent = {
        enable = true,
      },
      -- 添加折叠配置
      fold = {
        enable = true,         -- 启用折叠
        fold_virt_text = true, -- 使用虚拟文本
      },
    },
  },
  -- {
  --   "mhartington/formatter.nvim",
  --   dependencies = { "neovim/nvim-lspconfig" },
  --   event = "VeryLazy",
  --   config = function()
  --     require "configs.formatter"
  --   end,
  -- },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        mappings = {
          t = { j = { false } },     --lazygit navigation fix
          v = { j = { k = false } }, -- visual select fix
        },
      }
    end,
  },
  -- S键冲突
  -- {
  --   "tpope/vim-repeat",
  --   event = "VeryLazy",
  -- },
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.leap"
    end,
  },
  {
    "ggandor/leap-spooky.nvim",
    event = "VeryLazy",
    config = function()
      -- default config
      require("leap-spooky").setup {
        affixes = {
          -- Mappings will be generated corresponding to all native text objects,
          -- like: (ir|ar|iR|aR|im|am|iM|aM){obj}.

          -- Special line objects will also be added, by repeating the affixes.
          -- E.g. `yrr<leap>` and `ymm<leap>` will yank a line in the current
          -- window.

          -- The cursor moves to the targeted object, and stays there.
          magnetic = {
            window = "m",
            cross_window = "M",
          },
          -- The operation is executed seemingly remotely (the cursor boomerangs
          -- back afterwards).
          remote = {
            window = "r",
            cross_window = "R",
          },
        },
        -- If this option is set to true, the yanked text will automatically be pasted
        -- at the cursor position if the unnamed register is in use.
        paste_on_remote_yank = false,
      }
    end,
  },
  {
    "ggandor/flit.nvim",
    event = "VeryLazy",
    config = function()
      -- default config
      require("flit").setup {
        keys = {
          f = "f",
          F = "F",
          t = "t",
          T = "T",
        },
        -- A string like "nv", "nvo", "o", etc.
        labeled_modes = "v",
        multiline = true,
        -- Like `leap`s similar argument (call-specific overrides).
        -- E.g.: opts = { equivalence_classes = {} }
        opts = {},
      }
    end,
  },
  {
    "github/copilot.vim",
    event = "VeryLazy",
  },
  -- 这个插件有格式化问题，暂时不用,回头解决
  -- {
  --   "ray-x/navigator.lua",
  --   event = "VeryLazy",
  --   dev = (plugin_folder() ~= ""),
  --   -- '~/github/ray-x/navigator.lua',
  --   dependencies = {
  --     "ray-x/guihua.lua",
  --     build = "cd lua/fzy && make",
  --     "neovim/nvim-lspconfig",
  --   },
  --   config = function()
  --     require "custom.configs.navigator"
  -- },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    config = function() end,
  },
  -- 更新会报错
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   build = "cd app && yarn install",
  --   init = function()
  --     vim.g.mkdp_filetypes = { "markdown" }
  --   end,
  --   ft = { "markdown" },
  -- },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    config = function()
      require("nvim-ts-autotag").setup {
        opts = {
          -- Defaults
          enable_close = true,           -- Auto close tags
          enable_rename = true,          -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {
          ["html"] = {
            enable_close = false,
          },
        },
      }
    end,
  },
  {
    "nat-418/boole.nvim",
    event = "VeryLazy",
    config = function()
      require("boole").setup {
        mappings = {
          increment = "<C-a>",
          decrement = "<C-x>",
        },
        -- User defined loops
        additions = {
          {
            "Foo",
            "Bar",
          },
          {
            "tic",
            "tac",
            "toe",
          },
        },
        allow_caps_additions = {
          {
            "enable",
            "disable",
          },
          -- enable → disable
          -- Enable → Disable
          -- ENABLE → DISABLE
        },
      }
    end,
  },
  {
    "rhysd/accelerated-jk",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "j", "<Plug>(accelerated_jk_gj)")
      vim.keymap.set("n", "k", "<Plug>(accelerated_jk_gk)")
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup()
      vim.keymap.set("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]])
      vim.keymap.set("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true})<cr>]])
      vim.keymap.set("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]])
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = {
      enable_check_bracket_line = false,
    },
  },
  {
    "ethanholz/nvim-lastplace",
    event = "VeryLazy",
    config = true,
  },
  {
    "terryma/vim-expand-region",
    event = "VeryLazy",
  },
  -- text objects
  {
    "wellle/targets.vim",
    event = "VeryLazy",
  },
  -- TODO plugin
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    -- text around
    --     surr*ound_words             ysiw)           (surround_words)
    --     *make strings               ys$"            "make strings"
    --     [delete ar*ound me!]        ds]             delete around me!
    --     remove <b>HTML t*ags</b>    dst             remove HTML tags
    --     'change quot*es'            cs'"            "change quotes"
    --     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    --     delete(functi*on calls)     dsf             function calls
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "XXiaoA/ns-textobject.nvim",
    dependencies = "nvim-surround",
    config = function()
      require("ns-textobject").setup {
        -- your configuration here
        -- or just left empty to use defaluts
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "anuvyklack/fold-preview.nvim",
    dependencies = "anuvyklack/keymap-amend.nvim",
    config = true,
  },
  {
    "chrishrb/gx.nvim",
    event = {
      "BufEnter",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true, -- default settings
    -- you can specify also another config if you want
    -- config = function()
    --   require("gx").setup {
    --     open_browser_app = "os_specific", -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
    --     open_browser_args = { "--background" }, -- specify any arguments, such as --background for macOS' "open".
    --     handlers = {
    --       plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
    --       github = true, -- open github issues
    --       brewfile = true, -- open Homebrew formulaes and casks
    --       package_json = true, -- open dependencies from package.json
    --       search = true, -- search the web/selection on the web if nothing else is found
    --     },
    --     handler_options = {
    --       search_engine = "google", -- you can select between google, bing and duckduckgo
    --     },
    --   }
    -- end,
  },
  {
    "harrisoncramer/jump-tag",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    event = "VeryLazy",
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>55", ':lua require("jump-tag").jumpParent()<CR>', {
        noremap = true,
        silent = true,
      })
      vim.api.nvim_set_keymap("n", "<leader>5n", ':lua require("jump-tag").jumpNextSibling()<CR>', {
        noremap = true,
        silent = true,
      })
      vim.api.nvim_set_keymap("n", "<leader>5p", ':lua require("jump-tag").jumpPrevSibling()<CR>', {
        noremap = true,
        silent = true,
      })
      vim.api.nvim_set_keymap("n", "<leader>5c", ':lua require("jump-tag").jumpChild()<CR>', {
        noremap = true,
        silent = true,
      })
    end,
  },
  -- {
  --   "m4xshen/hardtime.nvim",
  --   event = "VeryLazy",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   opts = {},
  -- },
  -- WARN 替换插件,等待研究
  {
    "gbprod/substitute.nvim",
    event = "VeryLazy",
    config = function()
      require("substitute").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },
  -- 位置插件
  {
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("aerial").setup({
        -- 添加高亮配置
        highlight_on_hover = true, -- 鼠标悬停时高亮
        highlight_on_jump = 300,   -- 跳转时高亮持续时间（毫秒）

        -- 设置当前位置指示器
        show_guides = true, -- 显示指引线
        -- 在打开大文件时自动关闭
        disable_max_lines = 10000,
        -- 在打开大文件时自动关闭
        disable_max_size = 2000000,     -- 2MB
        -- 可选值: "split_width", "full_width", "last", "none"
        highlight_mode = "split_width", -- 整行高亮
        -- Vue 文件特定设置
        backends = {
          ["_"] = { "treesitter", "lsp", "markdown", "man" },
          vue = { "lsp" }, -- Vue 文件只使用 LSP
        },

        -- 降低更新频率
        update_events = "TextChanged,InsertLeave",
        -- 过滤显示的符号
        filter_kind = {
          "Class",
          "Constructor",
          "Enum",
          "Function",
          "Interface",
          "Module",
          "Method",
          "Struct",
        },
        -- 图标设置
        icons = {
          Class = "󰠱 ",
          Color = "󰏘 ",
          Constant = "󰏿 ",
          Constructor = " ",
          Enum = " ",
          EnumMember = " ",
          Event = " ",
          Field = " ",
          File = "󰈙 ",
          Function = "󰊕 ",
          Interface = " ",
          Key = "󰌋 ",
          Method = "󰆧 ",
          Module = " ",
          Namespace = "󰌗 ",
          Null = "󰟢 ",
          Number = "󰎠 ",
          Object = "󰅩 ",
          Package = " ",
          Property = "󰆧 ",
          String = "󰀬 ",
          Struct = "󰌗 ",
          TypeParameter = "󰊄 ",
          Variable = "󰆧 ",
          Array = "󰅪 ",
          Boolean = "◩ ",
          Operator = "󰆕 ",
        },
        -- 设置快捷键
        keymaps = {
          ["?"] = "actions.show_help",
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.jump",
          ["<2-LeftMouse>"] = "actions.jump",
          ["<C-v>"] = "actions.jump_vsplit",
          ["<C-s>"] = "actions.jump_split",
          ["p"] = "actions.scroll",
          ["<C-j>"] = "actions.down_and_scroll",
          ["<C-k>"] = "actions.up_and_scroll",
          ["{"] = "actions.prev",
          ["}"] = "actions.next",
          ["[["] = "actions.prev_up",
          ["]]"] = "actions.next_up",
          ["q"] = "actions.close",
          ["o"] = "actions.tree_toggle",
          ["za"] = "actions.tree_toggle",
          ["O"] = "actions.tree_toggle_recursive",
          ["zA"] = "actions.tree_toggle_recursive",
          ["l"] = "actions.tree_open",
          ["zo"] = "actions.tree_open",
          ["L"] = "actions.tree_open_recursive",
          ["zO"] = "actions.tree_open_recursive",
          ["h"] = "actions.tree_close",
          ["zc"] = "actions.tree_close",
          ["H"] = "actions.tree_close_recursive",
          ["zC"] = "actions.tree_close_recursive",
          ["zr"] = "actions.tree_increase_fold_level",
          ["zR"] = "actions.tree_open_all",
          ["zm"] = "actions.tree_decrease_fold_level",
          ["zM"] = "actions.tree_close_all",
          ["zx"] = "actions.tree_sync_folds",
          ["zX"] = "actions.tree_sync_folds",
        },
        -- 导航选项
      })

      -- 设置快捷键
      vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "打开代码大纲" })
    end
  },
  -- 折叠插件
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   dependencies = {
  --     "kevinhwang91/promise-async",
  --     {
  --       "folke/persistence.nvim",
  --       event = "BufReadPre",
  --       opts = {
  --         options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" },
  --       },
  --     },
  --   },
  --   event = "VeryLazy",
  --   config = function()
  --     -- ufo 基础设置
  --     vim.o.foldlevel = 99
  --     vim.o.foldlevelstart = 99
  --     vim.o.foldenable = true
  --
  --     require("ufo").setup({
  --       provider_selector = function()
  --         return { "treesitter", "indent" }
  --       end,
  --       open_fold_hl_timeout = 0,
  --       fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
  --         local newVirtText = {}
  --         local suffix = ("  %d "):format(endLnum - lnum)
  --         local sufWidth = vim.fn.strdisplaywidth(suffix)
  --         local targetWidth = width - sufWidth
  --         local curWidth = 0
  --         for _, chunk in ipairs(virtText) do
  --           local chunkText = chunk[1]
  --           local chunkWidth = vim.fn.strdisplaywidth(chunkText)
  --           if targetWidth > curWidth + chunkWidth then
  --             table.insert(newVirtText, chunk)
  --           else
  --             chunkText = truncate(chunkText, targetWidth - curWidth)
  --             local hlGroup = chunk[2]
  --             table.insert(newVirtText, { chunkText, hlGroup })
  --             chunkWidth = vim.fn.strdisplaywidth(chunkText)
  --             if curWidth + chunkWidth < targetWidth then
  --               suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
  --             end
  --             break
  --           end
  --           curWidth = curWidth + chunkWidth
  --         end
  --         table.insert(newVirtText, { suffix, "MoreMsg" })
  --         return newVirtText
  --       end,
  --     })
  --
  --     -- 设置快捷键
  --     local map = vim.keymap.set
  --     map("n", "zR", require("ufo").openAllFolds)
  --     map("n", "zM", require("ufo").closeAllFolds)
  --     map("n", "zr", require("ufo").openFoldsExceptKinds)
  --     map("n", "zm", require("ufo").closeFoldsWith)
  --     -- 快速设置折叠级别
  --     map("n", "z1", function() require("ufo").closeFoldsWith(1) end)
  --     map("n", "z2", function() require("ufo").closeFoldsWith(2) end)
  --     map("n", "z3", function() require("ufo").closeFoldsWith(3) end)
  --     -- 会话管理快捷键
  --     map("n", "<leader>qs", require("persistence").load, { desc = "恢复上次会话" })
  --     map("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "恢复最后会话" })
  --     map("n", "<leader>qd", require("persistence").stop, { desc = "不保存当前会话" })
  --   end,
  -- },
  {
    "m4xshen/autoclose.nvim",
    event = "VeryLazy",
    config = function()
      require("autoclose").setup {
        keys = {
          ["("] = { escape = false, close = true, pair = "()" },
          ["["] = { escape = false, close = true, pair = "[]" },
          ["{"] = { escape = false, close = true, pair = "{}" },

          [">"] = { escape = true, close = false, pair = "<>" },
          [")"] = { escape = true, close = false, pair = "()" },
          ["]"] = { escape = true, close = false, pair = "[]" },
          ["}"] = { escape = true, close = false, pair = "{}" },

          ['"'] = { escape = true, close = true, pair = '""' },
          ["'"] = { escape = true, close = true, pair = "''" },
          ["`"] = { escape = true, close = true, pair = "``" },
        },
        options = {
          disabled_filetypes = { "text" },
          disable_when_touch = false,
          touch_regex = "[%w(%[{]",
          pair_spaces = false,
          auto_indent = true,
          disable_command_mode = false,
        },
      }
    end,
  },
  {
    "jubnzv/virtual-types.nvim",
    event = "VeryLazy",
  },
  {
    "chrisgrieser/nvim-spider",
    event = "VeryLazy",
    config = function()
      vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
      vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
      vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
      vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
    end,
  },
  -- 页面标记
  {
    "LeonHeidelbach/trailblazer.nvim",
    event = "VeryLazy",
    config = function()
      require("trailblazer").setup {
        -- your custom config goes here
      }
    end,
  },
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      "smoka7/hydra.nvim",
    },
    opts = {},
    cmd = { " MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        mode = { "v", "n" },
        "<Leader>m",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for selected text or word under the cursor",
      },
    },
  },
  {
    "gbprod/stay-in-place.nvim",
    event = "VeryLazy",
    config = function()
      require("stay-in-place").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },
  {
    "princejoogie/tailwind-highlight.nvim",
    event = "VeryLazy",
  },
  -- 已停止更新
  -- {
  --   "ecthelionvi/NeoSwap.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     vim.keymap.set("n", "<leader>wn", "<cmd>NeoSwapNext<cr>", { noremap = true, silent = true })
  --     vim.keymap.set("n", "<leader>wp", "<cmd>NeoSwapPrev<cr>", { noremap = true, silent = true })
  --   end,
  -- },
  -- 目录插件
  {

    -- Normal mode	Insert mode	Action
    -- f	<c-f>	find_project_files 查找项目文件
    -- b	<c-b>	browse_project_files 浏览项目文件
    -- d	<c-d>	delete_project 删除项目文件
    -- s	<c-s>	search_in_project_files 在项目文件中搜索
    -- r	<c-r>	recent_project_files 最近的项目文件
    -- w	<c-w>	change_working_directory 更改工作目录
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "nvim-tree/nvim-tree.lua",
      },
    },
    config = function()
      require("nvim-tree").setup {
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
      }
      -- lua
      require("project_nvim").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },
  {
    "winston0410/range-highlight.nvim",
    dependencies = { "winston0410/cmd-parser.nvim" },
    event = "VeryLazy",
    config = function()
      require("range-highlight").setup {}
    end,
  },
  {
    "Mr-LLLLL/interestingwords.nvim",
    event = "VeryLazy",
    config = function()
      require("range-highlight").setup {}
    end,
  },
  {
    "yamatsum/nvim-cursorline",
    event = "VeryLazy",
    config = function()
      require("nvim-cursorline").setup {
        cursorline = {
          enable = true,
          timeout = 1000,
          number = false,
        },
        cursorword = {
          enable = true,
          min_length = 3,
          hl = { underline = true },
        },
      }
    end,
  },
  -- 首页启动
  {
    "goolord/alpha-nvim",
    -- event = "VeryLazy",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      -- require("alpha").setup(require("alpha.themes.startify").config)
      -- vim.cmd "Alpha"
      -- 修改自动启动逻辑
      vim.api.nvim_create_autocmd("VimEnter", {
        desc = "Start Alpha when vim is opened with no arguments",
        group = vim.api.nvim_create_augroup("AlphaStart", { clear = true }),
        callback = function()
          -- 只在完全空启动时显示
          if vim.fn.argc() == 0 and vim.fn.line2byte("$") == -1 and vim.bo.filetype == "" then
            alpha.start(true)
          end
        end,
      })

      alpha.setup(require("alpha.themes.startify").config)
    end,
  },
  {
    "vuki656/package-info.nvim",
    event = "VeryLazy",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("package-info").setup()
      -- Show dependency versions
      vim.keymap.set({ "n" }, "<LEADER>ss", require("package-info").show, { silent = true, noremap = true })
      -- Hide dependency versions
      vim.keymap.set({ "n" }, "<LEADER>sc", require("package-info").hide, { silent = true, noremap = true })
      -- Toggle dependency versions
      vim.keymap.set({ "n" }, "<LEADER>st", require("package-info").toggle, { silent = true, noremap = true })
      -- Update dependency on the line
      vim.keymap.set({ "n" }, "<LEADER>su", require("package-info").update, { silent = true, noremap = true })
      -- Delete dependency on the line
      vim.keymap.set({ "n" }, "<LEADER>sd", require("package-info").delete, { silent = true, noremap = true })
      -- Install a new dependency
      vim.keymap.set({ "n" }, "<LEADER>si", require("package-info").install, { silent = true, noremap = true })
      -- Install a different dependency version
      vim.keymap.set({ "n" }, "<LEADER>sp", require("package-info").change_version, { silent = true, noremap = true })
    end,
  },
  -- 快速浏览标记
  {
    "LeonHeidelbach/trailblazer.nvim",
    event = "VeryLazy",
    config = function()
      require("trailblazer").setup {
        -- your custom config goes here
      }
    end,
  },
  {
    "askfiy/neovim-easy-less",
    ft = { "less" },
    config = function()
      require("easy-less").setup {
        -- Is an error message displayed? Default false
        show_error_message = true,
        -- The file suffix generated by default
        generate_suffix = "css",
      }
    end,
  },
  -- {
  --   "barrett-ruth/live-server.nvim",
  --   event = "VeryLazy",
  --   build = "yarn global add live-server",
  --   config = true,
  -- },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },
  {
    "bennypowers/nvim-regexplainer",
    event = "VeryLazy",
    config = function()
      -- defaults
      require("regexplainer").setup {
        -- 'narrative'
        mode = "narrative", -- TODO: 'ascii', 'graphical'

        -- automatically show the explainer when the cursor enters a regexp
        auto = false,

        -- filetypes (i.e. extensions) in which to run the autocommand
        filetypes = {
          "html",
          "js",
          "cjs",
          "mjs",
          "ts",
          "jsx",
          "tsx",
          "cjsx",
          "mjsx",
        },

        -- Whether to log debug messages
        debug = false,

        -- 'split', 'popup'
        display = "popup",

        mappings = {
          toggle = "gR",
          -- examples, not defaults:
          -- show = 'gS',
          -- hide = 'gH',
          -- show_split = 'gP',
          -- show_popup = 'gU',
        },

        narrative = {
          indendation_string = "> ", -- default '  '
        },
      }
    end,
  },
  -- 粘滞滚动
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    config = function()
      require 'treesitter-context'.setup()
      vim.keymap.set("n", "[c", function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end, { silent = true })
      -- Go to previous context
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    cmd = "Telescope",
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-c>"] = actions.close,
              ["<C-u>"] = false,
              ["<C-d>"] = false,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
          file_ignore_patterns = {
            "node_modules",
            "%.git/",
            "%.DS_Store",
            "dist",
            "build",
          },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
          },
        },
        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        },
      })

      -- 加载 fzf 扩展
      telescope.load_extension('fzf')

      -- 设置快捷键
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "查找文件" })
      vim.keymap.set("n", "<leader>fa", builtin.live_grep, { desc = "全局搜索" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "查找缓冲区" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "查找帮助" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "最近文件" })
      vim.keymap.set("n", "<leader>fw", function()
        builtin.live_grep({
          prompt_title = "搜索单词",
          -- 可选：添加默认搜索选项
          additional_args = function()
            return { "--hidden" } -- 包含隐藏文件
          end,
        })
      end, { desc = "搜索单词" })
      -- vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "查找标记" })
      vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "查找符号" })
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "查找诊断" })
      vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "查找引用" })
      vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "转到定义" })
    end,
  },
  -- 差异比较视图
  {
    'sindrets/diffview.nvim',
    event = "VeryLazy",
    config = function()
      require("diffview").setup {
        diff_binaries = false, -- Show diffs for binaries
        file_panel = {
          width = 35,
          use_icons = true -- Requires Nerd-Font
        }
      }
    end
  }
}
