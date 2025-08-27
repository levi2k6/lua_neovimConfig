local cmp = require("cmp")
local luasnip = require("luasnip")

-- Load VSCode-style snippets (from friendly-snippets or your own)
require("luasnip.loaders.from_vscode").lazy_load()

-- Setup nvim-cmp
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
    { name = "nvim_lsp" }, -- LSP completions (all your language servers)
    { name = "luasnip" },  -- Snippets
  }, {
    { name = "buffer" },   -- Buffer words
    { name = "path" },     -- File paths
  }),
  formatting = {
    format = function(entry, vim_item)
      -- Show source in menu (LSP, Snip, Path, etc.)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip  = "[Snip]",
        buffer   = "[Buf]",
        path     = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
})

-- Enable completion in command-line mode
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    { name = "cmdline" }
  })
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  }
})

-- Update LSP client capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Export capabilities so your lspconfig can reuse it
return {
  capabilities = capabilities
}
