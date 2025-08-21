-- ~/.config/nvim/lua/lsp.lua

-- Configure diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
})

-- LSP keybindings function
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, silent = true }
  
  -- Navigation
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
  
  -- Documentation
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  
  -- Actions
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
end

-- Setup capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Get lspconfig
local lspconfig = require("lspconfig")

-- Setup mason-lspconfig with handlers
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "ts_ls", "clangd" },
  automatic_installation = true,
  handlers = {
    -- Default handler for all servers
    function(server_name)
      lspconfig[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
    
    -- Custom setup for Lua
    ["lua_ls"] = function()
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
    end,
    
    -- Custom setup for Python
    ["pyright"] = function()
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })
    end,
    -- Custom setup for C/C++
    ["clangd"] = function()
      lspconfig.clangd.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      })
    end,
    
    -- TypeScript/JavaScript is already handled by ts_ls above
  }
})
