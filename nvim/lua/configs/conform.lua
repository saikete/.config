local options = {
  formatters_by_ft = {
    lua = { "stylua" },

    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    vue = { "prettier" },
    ["javascript.jsx"] = { "prettier" },
    ["typescript.tsx"] = { "prettier" },
    ["javascript.jest"] = { "prettier" },
    ["typescript.jest"] = { "prettier" },
    markdown = { "prettier" },
    ["markdown.mdx"] = { "prettier" },
    mdx = { "prettier" },
    css = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    scss = { "prettier" },
    less = { "prettier" },
    xml = { "prettier" },
    yaml = { "prettier" },
    graphql = { "prettier" },
    html = { "prettier" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
