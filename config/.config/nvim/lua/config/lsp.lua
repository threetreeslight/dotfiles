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

local function setup_lsp()
  local configs = require("lspconfig.configs")
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
    map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
    map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
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

  local function setup_server(server)
    local ok, _ = pcall(require, "lspconfig.configs." .. server)
    if not ok or not configs[server] then
      vim.notify(string.format("[lsp] server '%s' is not available", server), vim.log.levels.WARN)
      return
    end

    configs[server].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end

  for _, server in ipairs(servers) do
    setup_server(server)
  end
end

function M.setup()
  setup_cmp()
  setup_lsp()
end

return M
