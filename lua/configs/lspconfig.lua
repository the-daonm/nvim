require("nvchad.configs.lspconfig").defaults()

local servers = {
  "lua_ls",
  "clangd",
  "pyright",
  "ruff",
  "gopls",
  "rust_analyzer",
  "bashls",
  "fish_lsp",
  "yamlls",
  "gh_actions_ls",
  "docker_language_server",
  "helm_ls",
  "markdown_oxide"
}

vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      validate = true,
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemas = {
        kubernetes = { "k8s**.yaml", "kube*/*.yaml", "k8s*/*.yaml", "manifests/*.yaml" },
        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
        ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
        ["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] = "docker-compose*.{yml,yaml}",
        ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"] = "argocd-application.yaml",
      },
    },
  },
})

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
