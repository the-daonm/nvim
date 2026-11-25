require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!
o.relativenumber = true
o.number = true
o.swapfile = false
o.shell = "fish"
o.timeoutlen = 1000
o.conceallevel = 2

o.scrolloff = 8
o.sidescrolloff = 8
o.inccommand = "split" -- live preview of :s substitutions
o.confirm = true -- ask to save instead of failing on :q with unsaved changes

-- Treesitter folding, all folds open by default (zc/zo/za to fold, zR/zM all)
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevelstart = 99
o.foldtext = ""

-- Helm chart templates -> `helm` filetype so helm_ls attaches (instead of yamlls
-- reporting bogus errors on {{ }} template syntax)
vim.filetype.add {
  pattern = {
    -- compose files -> docker_language_server attaches alongside yamlls
    [".*/docker%-compose[^/]*%.ya?ml"] = "yaml.docker-compose",
    [".*/compose[^/]*%.ya?ml"] = "yaml.docker-compose",
    [".*/templates/.*%.ya?ml"] = function(path)
      if vim.fs.root(path, "Chart.yaml") then
        return "helm"
      end
    end,
    [".*/templates/.*%.tpl"] = "helm",
    -- chart values -> helm_ls offers .Values completion in templates (yamlls still attaches)
    [".*/values.*%.ya?ml"] = function(path)
      local dir = vim.fs.dirname(path)
      if vim.uv.fs_stat(dir .. "/Chart.yaml") then
        return "yaml.helm-values"
      end
    end,
  },
}
