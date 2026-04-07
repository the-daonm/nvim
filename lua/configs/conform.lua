local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    json = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    rust = { "rustfmt" },
    go = { "gofumpt" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    bash = { "shfmt" },
    markdown = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
