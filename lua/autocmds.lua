require "nvchad.autocmds"

-- YAML/Helm: predictable indentation. Use the built-in YAML indent, but don't
-- re-indent the line when typing ":" or "-", and don't auto-continue comments.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user_yaml", { clear = true }),
  pattern = { "yaml", "helm" },
  callback = function(args)
    local bo = vim.bo[args.buf]
    if bo.indentexpr == "" then
      vim.cmd.runtime "indent/yaml.vim"
      bo.indentexpr = "GetYAMLIndent(v:lnum)"
    end
    bo.indentkeys = "!^F,o,O,0},0]"
    bo.formatoptions = bo.formatoptions:gsub("[ro]", "")
  end,
})
