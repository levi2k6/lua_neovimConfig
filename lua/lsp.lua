require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "pyright", "tsserver" }, -- pick your servers
}

local lspconfig = require("lspconfig")

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set("n", "<leader>e", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end


local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- lua lsp
lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the LSP which Lua version you use (LuaJIT for Neovim)
                version = 'LuaJIT',
                -- Path to your lua interpreter (optional)
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Stop warnings about 'vim' being undefined
                globals = {'vim'},
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
}

-- python
lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
      python = {
	  pythonPath = vim.fn.expand("~/myenv/bin/python3") 
      }
  }
}


