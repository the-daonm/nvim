-- Linters that aren't language servers.
-- hadolint: Dockerfile linting that works without a running Docker daemon
-- (docker_language_server only gets build checks from the daemon).
return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = {
        dockerfile = { "hadolint" },
      }
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("user_lint", { clear = true }),
        callback = function()
          lint.try_lint(nil, { ignore_errors = true })
        end,
      })
      -- the event that loaded us already fired; wait until filetype is set
      vim.schedule(function()
        lint.try_lint(nil, { ignore_errors = true })
      end)
    end,
  },
}
