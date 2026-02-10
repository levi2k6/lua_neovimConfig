-- Configure diagnostics
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
})

-- LSP keybindings
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true, noremap = true }

    -- Navigation
    vim.keymap.set("n", "<leader>ee", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>ew", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>ei", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>ed", vim.lsp.buf.type_definition, opts)

    -- Documentation
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

    -- Actions
    vim.keymap.set("n", "<leader>e>", function() vim.lsp.buf.format({ async = true }) end, opts)
end

-- LSP capabilities for nvim-cmp
local capabilities = require("plugin.completion").capabilities

-- Get lspconfig
local lspconfig = require("lspconfig")

-- Lua
lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
})

-- Python
lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    before_init = function(_, config)
	local cwd = vim.fn.getcwd()

	local venvPaths = {"venv/bin/python", ".venv/bin/python"}
	for _, path in ipairs(venvPaths) do 
	   local fullPath = cwd .. "/" .. path
	   if vim.fn.filereadable(fullPath) == 1 then
		config.settings.python.pythonPath = fullPath
		return
	   end
	end

	config.settings.python.pythonPath = vim.fn.exepath("python3")
    end
})

-- Add this after your LSP setup
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.py",
    callback = function()
        -- Check if this is a newly created file
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        for _, client in ipairs(clients) do
            if client.name == "pyright" then
                -- Notify the server about the workspace change
                client.notify("workspace/didChangeWatchedFiles", {
                    changes = {
                        {
                            uri = vim.uri_from_bufnr(0),
                            type = 1 -- Created
                        }
                    }
                })
            end
        end
    end,
})

-- TypeScript / JavaScript
lspconfig.ts_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    settings = {
        typescript = { inlayHints = { includeInlayParameterNameHints = "all" } },
        javascript = { inlayHints = { includeInlayParameterNameHints = "all" } },
    },
})

-- C/C++
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

-- Go
lspconfig.gopls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        gopls = {
            analyses = { unusedparams = true, unreachable = true, fieldalignment = true },
            staticcheck = true,
            gofumpt = true,
            completeUnimported = true,
            usePlaceholders = true,
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


