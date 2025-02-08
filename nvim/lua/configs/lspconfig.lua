-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = {
  "html",
  "cssls",

  "ts_ls",
  "clangd",
  "volar",
  -- "vuels",
  "cssmodules_ls",
  "marksman",
  "jsonls",
  "tailwindcss",
  "unocss",
  "css_variables",
  "gopls",
  -- "prettier",

  "angularls",
  "gopls",
  "flow",
  "bashls",
  "dockerls",
  "eslint",
  -- "ocamllsp",
  -- "stylua",
}

local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
--
-- lspconfig.ocamllsp.setup { on_attach = require("virtualtypes").on_attach }

-- local tw_highlight = require "tailwind-highlight"
-- lspconfig.tailwindcss.setup {
--   on_attach = function(client, bufnr)
--     -- rest of you config
--     tw_highlight.setup(client, bufnr, {
--       single_column = false,
--       mode = "background",
--       debounce = 200,
--     })
--   end,
-- }

-- lspconfig.volar.setup {
--   init_options = {
--     typescript = {
--       tsdk = "/path/to/.npm/lib/node_modules/typescript/lib",
--       -- Alternative location if installed as root:
--       -- tsdk = '/usr/local/lib/node_modules/typescript/lib'
--     },
--   },
-- }

local util = require "lspconfig.util"
local function get_typescript_server_path(root_dir)
  -- local global_ts = "/Users/alan/.volta/tools/image/packages/typescript/lib/node_modules/typescript/lib"
  local global_ts = "/Users/alan/.volta/tools/image/packages/typescript/lib/node_modules/typescript/lib/"
  -- Alternative location if installed as root:
  -- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
  local found_ts = ""
  local function check_dir(path)
    found_ts = util.path.join(path, "node_modules", "typescript", "lib")
    if util.path.exists(found_ts) then
      return path
    end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

lspconfig.volar.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
  init_options = {
    typescript = {
      tsdk = '/Users/alan/.volta/tools/image/packages/typescript/lib/node_modules/typescript/lib'
      -- Alternative location if installed as root:
      -- tsdk = '/usr/local/lib/node_modules/typescript/lib'
    }
  },
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end,
}


lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        -- location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
        -- location = "/opt/homebrew/lib/node_modules/@vue/typescript-plugin",
        location = "/Users/alan/.volta/tools/image/packages/@vue/typescript-plugin/lib/node_modules/@vue/typescript-plugin",
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "vue",
  },
}
