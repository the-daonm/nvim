return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      legacy_commands = false,
      workspaces = {
        {
          name = "Notes",
          path = "~/Documents/Notes",
        },
      },
      callbacks = {
        enter_note = function(_)
          -- Overrides the 'gf' mapping to work on markdown/obsidian links within the vault
          vim.keymap.set("n", "gf", function()
            return require("obsidian").util.gf_passthrough()
          end, { noremap = false, expr = true, buffer = true, desc = "Follow Link" })

          -- Toggle check-boxes
          vim.keymap.set("n", "<leader>oc", function()
            return require("obsidian").util.toggle_checkbox()
          end, { buffer = true, desc = "Toggle Checkbox" })

          -- Smart action (follow link, toggle checkbox, etc.)
          vim.keymap.set("n", "<cr>", function()
            local line = vim.api.nvim_get_current_line()
            local start_idx, end_idx = line:find("%b[]")
            if start_idx and start_idx <= 20 then
              local prefix = line:sub(1, start_idx - 1)
              if prefix:match("^%s*[%-*+]%s*$") or prefix:match("^%s*%d+%.%s*$") then
                local char = line:sub(start_idx + 1, end_idx - 1)
                local new_char = (char == "x" or char == "X") and " " or "x"
                local new_line = line:sub(1, start_idx) .. new_char .. line:sub(end_idx)
                vim.schedule(function()
                  vim.api.nvim_set_current_line(new_line)
                end)
                return ""
              end
            end
            return require("obsidian").util.smart_action()
          end, { expr = true, buffer = true, desc = "Smart Action" })
        end,
      },
    },
  },
}
