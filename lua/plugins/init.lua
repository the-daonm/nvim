return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "folke/which-key.nvim",
    lazy = false,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- nvim-treesitter is on the `main` branch (rewrite): `ensure_installed` and the
  -- old `highlight`/`indent` modules no longer exist, so install parsers and
  -- start highlighting ourselves. The main branch does not support lazy-loading.
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    event = false,
    cmd = false,
    build = ":TSUpdate",
    config = function()
      -- stylua: ignore
      require("nvim-treesitter").install {
        -- languages
        "bash", "c", "cpp", "go", "gomod", "gosum", "gowork", "lua", "luadoc", "python", "rust", "fish",
        -- web
        "html", "css", "javascript", "typescript", "json",
        -- infra / config
        "yaml", "helm", "toml", "dockerfile", "make", "terraform", "hcl", "kdl", "sql", "ini",
        -- docs / git
        "markdown", "markdown_inline", "diff", "git_config", "gitcommit", "gitignore", "regex",
        "vim", "vimdoc", "query", "printf",
      }

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang or not vim.treesitter.language.add(lang) then
            return
          end
          -- treesitter indent is unreliable for YAML; keep the built-in one there
          if pcall(vim.treesitter.start, args.buf, lang) and lang ~= "yaml" and lang ~= "helm" then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
