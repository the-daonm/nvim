local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format", "ruff" },
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
    fish = { "fish_indent" },
    markdown = { "prettier" },
    sql = { "sql_formatter" },
    kdl = { "kdlfmt" },
  },

  formatters = {
    sql_formatter = {
      args = { "--config", '{"language":"postgresql"}' },
    },
    kdlfmt = {
      args = { "format", "--config", vim.fn.stdpath("config") .. "/kdlfmt.kdl", "-" },
    },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    -- lsp_fallback = true,
    lsp_format = "fallback",
  },
}

return options
