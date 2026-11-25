require("nvchad.configs.lspconfig").defaults()

-- Must come after defaults(): NvChad sets its own diagnostic config there
vim.diagnostic.config {
  severity_sort = true,
  virtual_text = { prefix = "", source = "if_many", spacing = 2 },
  float = { border = "rounded", source = true },
}

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
  "markdown_oxide",
}

-- Python: pyright does types, ruff does lint/imports. Turn off the pyright
-- checks ruff already reports so problems don't show up twice.
vim.lsp.config("pyright", {
  settings = {
    pyright = { disableOrganizeImports = true },
    python = {
      analysis = {
        typeCheckingMode = "standard",
        diagnosticSeverityOverrides = {
          reportUndefinedVariable = "none", -- ruff F821
          reportUnusedExpression = "none", -- ruff B018
          reportUnusedImport = "none", -- ruff F401
          reportUnusedVariable = "none", -- ruff F841
        },
      },
    },
  },
})

vim.lsp.config("ruff", {
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false -- leave hover to pyright
  end,
})

vim.lsp.config("gopls", {
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      usePlaceholders = true,
      completeUnimported = true,
      analyses = { unusedparams = true, unusedwrite = true, nilness = true, shadow = true },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})

-- C/C++: needs compile_commands.json (cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON,
-- or `bear -- make`) or a compile_flags.txt in real projects
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--function-arg-placeholders=true",
    "--header-insertion=iwyu",
  },
})

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      check = { command = "clippy" }, -- clippy lints on save
      cargo = { allFeatures = true },
      procMacro = { enable = true },
    },
  },
})

vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      validate = true,
      hover = true,
      completion = true,
      format = { enable = true },
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemas = {
        -- Kubernetes (yamlls has special handling for this keyword)
        kubernetes = {
          "k8s**.yaml",
          "kube*/*.yaml",
          "k8s*/*.yaml",
          "manifests/*.yaml",
        },

        -- Helm / Kustomize / ArgoCD
        ["https://json.schemastore.org/chart.json"] = "Chart.yaml",
        ["https://json.schemastore.org/helmfile.json"] = "helmfile.{yml,yaml}",
        ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
        ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"] = "argocd-application.yaml",
        ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/applicationset_v1alpha1.json"] = "*applicationset*.yaml",

        -- GitHub
        ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
        ["https://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
        ["https://json.schemastore.org/dependabot-2.0.json"] = ".github/dependabot.{yml,yaml}",
        ["https://json.schemastore.org/funding.json"] = ".github/FUNDING.{yml,yaml}",
        ["https://json.schemastore.org/github-issue-forms.json"] = ".github/ISSUE_TEMPLATE/*.{yml,yaml}",

        -- Other CI/CD
        ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
        ["https://json.schemastore.org/circleciconfig.json"] = ".circleci/config.yml",
        ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "azure-pipelines.{yml,yaml}",
        ["https://json.schemastore.org/drone.json"] = ".drone.{yml,yaml}",
        ["https://json.schemastore.org/bitbucket-pipelines.json"] = "bitbucket-pipelines.{yml,yaml}",
        ["https://json.schemastore.org/woodpecker.json"] = ".woodpecker.{yml,yaml}",

        -- Docker
        ["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] = "docker-compose*.{yml,yaml}",

        -- Ansible
        ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/playbook.json"] = "*playbook*.{yml,yaml}",
        ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/tasks.json"] = "**/{tasks,handlers}/*.{yml,yaml}",

        -- Misc dev tooling
        ["https://json.schemastore.org/pre-commit-config.json"] = ".pre-commit-config.{yml,yaml}",
        ["https://json.schemastore.org/mkdocs.json"] = "mkdocs.{yml,yaml}",
        ["https://json.schemastore.org/serverless.json"] = "serverless.{yml,yaml}",
        ["https://taskfile.dev/schema.json"] = "{T,t}askfile.{yml,yaml}",
        ["https://json.schemastore.org/cloudbuild.json"] = "cloudbuild.{yml,yaml}",

        -- API specs
        ["https://json.schemastore.org/swagger-2.0.json"] = "swagger.{yml,yaml}",
        ["https://json.schemastore.org/openapi.json"] = "openapi.{yml,yaml}",
      },
    },
  },
})

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
