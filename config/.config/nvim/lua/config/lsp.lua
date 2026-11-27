local M = {}

local function setup_cmp()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  require("luasnip.loaders.from_vscode").lazy_load()

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
    }, {
      { name = "buffer" },
      { name = "path" },
    }),
  })

  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })

  vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    end
  end, { silent = true, desc = "LuaSnip next" })

  vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    end
  end, { silent = true, desc = "LuaSnip previous" })
end

-- [Security] Some servers execute code from the project itself (ruby_lsp
-- evaluates the Gemfile, ts_ls loads node_modules/typescript, gopls runs the
-- go toolchain). Only start them inside trusted directories; use :LspTrust to
-- trust the current project.
local trust_file = vim.fn.stdpath("state") .. "/lsp_trusted_dirs"
local default_trusted = { "~/dotfiles", "~/src/github.com/threetreeslight" }

local function normalize(path)
  return vim.fs.normalize(vim.fn.resolve(vim.fn.expand(path)))
end

local function is_trusted(path)
  local dirs = vim.deepcopy(default_trusted)
  if vim.uv.fs_stat(trust_file) then
    vim.list_extend(dirs, vim.fn.readfile(trust_file))
  end
  path = normalize(path)
  for _, dir in ipairs(dirs) do
    if dir ~= "" then
      dir = normalize(dir)
      if path == dir or vim.startswith(path, dir .. "/") then
        return true
      end
    end
  end
  return false
end

local function setup_workspace_trust(server_names)
  for _, name in ipairs(server_names) do
    local default = vim.lsp.config[name] or {}
    vim.lsp.config(name, {
      root_dir = function(bufnr, on_dir)
        local function on_trusted_dir(root)
          if root and is_trusted(root) then
            on_dir(root)
          end
        end
        if type(default.root_dir) == "function" then
          default.root_dir(bufnr, on_trusted_dir)
        elseif type(default.root_dir) == "string" then
          on_trusted_dir(default.root_dir)
        else
          on_trusted_dir(vim.fs.root(bufnr, default.root_markers or { ".git" }))
        end
      end,
    })
  end

  vim.api.nvim_create_user_command("LspTrust", function()
    local root = vim.fs.root(0, { ".git" }) or vim.fn.getcwd()
    vim.fn.mkdir(vim.fn.fnamemodify(trust_file, ":h"), "p")
    vim.fn.writefile({ root }, trust_file, "a")
    vim.notify("[lsp] trusted: " .. root)
    vim.api.nvim_exec_autocmds("FileType", { buffer = 0 })
  end, { desc = "Trust the current project for LSP servers that run project code" })
end

local function setup_lsp()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  local function on_attach(_, bufnr)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end

    map("n", "gD", vim.lsp.buf.declaration, "LSP declaration")
    map("n", "gd", vim.lsp.buf.definition, "LSP definition")
    map("n", "K", vim.lsp.buf.hover, "LSP hover")
    map("n", "gi", vim.lsp.buf.implementation, "LSP implementation")
    map("n", "<C-k>", vim.lsp.buf.signature_help, "LSP signature")
    map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
    map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
    map("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List workspace folders")
    map("n", "<space>D", vim.lsp.buf.type_definition, "Type definition")
    map("n", "<space>rn", vim.lsp.buf.rename, "Rename symbol")
    map("n", "<space>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "gr", vim.lsp.buf.references, "LSP references")
    map("n", "<space>e", vim.diagnostic.open_float, "Line diagnostics")
    map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
    map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
    map("n", "<space>q", vim.diagnostic.setloclist, "Diagnostics to loclist")
  end

  local servers = {
    "pyright",
    "ts_ls",
    "ruby_lsp",
    "gopls",
    "terraformls",
    "html",
    "cssls",
    "jsonls",
  }

  -- Install language servers via mason (:Mason to manage them)
  require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_enable = false, -- enabled explicitly below
  })

  -- Nvim 0.11+: server definitions come from nvim-lspconfig's `lsp/` directory
  vim.lsp.config("*", {
    capabilities = capabilities,
    on_attach = on_attach,
  })
  setup_workspace_trust({ "ruby_lsp", "ts_ls", "gopls" })
  vim.lsp.enable(servers)
end

function M.setup()
  setup_cmp()
  setup_lsp()
end

return M
