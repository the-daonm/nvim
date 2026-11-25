-- Render markdown in the buffer (headings, tables, code blocks, checkboxes,
-- callouts). obsidian.nvim detects this plugin and disables its own UI.
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      file_types = { "markdown" },
      completions = { lsp = { enabled = true } },
      -- show raw text on the cursor line in insert mode only, so normal mode stays rendered
      render_modes = { "n", "c", "t" },
      anti_conceal = { enabled = true },
      latex = { enabled = false },
      heading = { sign = false, width = "block", left_pad = 1, right_pad = 2 },
      code = { sign = false, width = "block", left_pad = 1, right_pad = 2, border = "thin" },
      pipe_table = { preset = "round" },
      checkbox = { checked = { scope_highlight = "@markup.strikethrough" } },
    },
    keys = {
      { "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown", desc = "Markdown: Toggle in-buffer render" },
    },
  },
}
