return{
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-lualine/lualine.nvim", config = true},
  {"williamboman/mason.nvim", config = true},
  { 
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("plugin.lsp")  -- Now loads AFTER plugins are ready
    end
  },
  { "neovim/nvim-lspconfig" },
  { 
    "nvim-telescope/telescope.nvim", 
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugin.telescope")
    end
  },
}
