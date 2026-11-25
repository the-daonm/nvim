-- Attach a Kubernetes schema to YAML buffers based on their *content*
-- (apiVersion + kind), not their file name. Built-in resources use yamlls's
-- `kubernetes` schema; CRDs use the datreeio CRDs-catalog.
local M = {}

local core_groups = {
  ["admissionregistration.k8s.io"] = true,
  ["apiextensions.k8s.io"] = true,
  ["apiregistration.k8s.io"] = true,
  ["authentication.k8s.io"] = true,
  ["authorization.k8s.io"] = true,
  ["certificates.k8s.io"] = true,
  ["coordination.k8s.io"] = true,
  ["discovery.k8s.io"] = true,
  ["events.k8s.io"] = true,
  ["flowcontrol.apiserver.k8s.io"] = true,
  ["internal.apiserver.k8s.io"] = true,
  ["networking.k8s.io"] = true,
  ["node.k8s.io"] = true,
  ["rbac.authorization.k8s.io"] = true,
  ["resource.k8s.io"] = true,
  ["scheduling.k8s.io"] = true,
  ["storage.k8s.io"] = true,
  ["storagemigration.k8s.io"] = true,
}

local function unquote(s)
  return (s:gsub("^[\"']", ""):gsub("[\"']$", ""))
end

--- Returns the schema key for a buffer, or nil if it isn't a k8s manifest.
local function detect(buf)
  local api_version, kind
  for _, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, 200, false)) do
    api_version = api_version or line:match "^apiVersion:%s*(%S+)"
    kind = kind or line:match "^kind:%s*(%S+)"
    if api_version and kind then
      break
    end
  end
  if not (api_version and kind) then
    return nil
  end
  api_version, kind = unquote(api_version), unquote(kind)

  local group, version = api_version:match "^(.+)/(.+)$"
  if not group or not group:find "%." or core_groups[group] then
    return "kubernetes"
  end
  return ("https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/%s/%s_%s.json"):format(
    group,
    kind:lower(),
    version
  )
end

local function apply(client, buf)
  local path = vim.api.nvim_buf_get_name(buf)
  if path == "" then
    return
  end
  local schemas = client.settings.yaml.schemas

  -- drop any previous association for this file (kind may have changed)
  for key, globs in pairs(schemas) do
    if type(globs) == "table" then
      for i = #globs, 1, -1 do
        if globs[i] == path then
          table.remove(globs, i)
        end
      end
    elseif globs == path then
      schemas[key] = nil
    end
  end

  local key = detect(buf)
  if key then
    local globs = schemas[key]
    if type(globs) == "string" then
      globs = { globs }
    end
    globs = globs or {}
    table.insert(globs, path)
    schemas[key] = globs
  end
  client:notify("workspace/didChangeConfiguration", { settings = client.settings })
end

function M.setup()
  local group = vim.api.nvim_create_augroup("user_yaml_k8s_schema", { clear = true })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client.name == "yamlls" then
        apply(client, args.buf)
      end
    end,
  })

  -- re-detect after saving (e.g. a new file where you just typed apiVersion/kind)
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = { "*.yaml", "*.yml" },
    callback = function(args)
      for _, client in ipairs(vim.lsp.get_clients { bufnr = args.buf, name = "yamlls" }) do
        apply(client, args.buf)
      end
    end,
  })
end

return M
