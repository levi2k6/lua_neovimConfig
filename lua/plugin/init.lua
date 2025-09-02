return{
    {
	"nvim-treesitter/nvim-treesitter", build = ":tsupdate",
	config = function()
	    require("plugin.treesitter")
	end
    },
	--    {
	-- "ellisonleao/gruvbox.nvim",
	-- priority = 1000,
	-- config = function()
	--     vim.cmd("colorscheme gruvbox")
	-- end
	--    },
    {
      "nonetallt/vim-neon-dark",
      lazy = false,
      priority = 1000, -- load it early
      config = function()
	vim.cmd("colorscheme neon-dark")
      end,
    },
    { "nvim-lualine/lualine.nvim", config = true},
    {"williamboman/mason.nvim", config = true},
    {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    event = { "bufreadpre", "bufnewfile"},
    config = function()
      require("plugin.lsp")  -- now loads after plugins are ready
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
    {
	"mfussenegger/nvim-jdtls",
	ft = { "java" },
	dependencies = {
	  "neovim/nvim-lspconfig",
	},
    },
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"rafamadriz/friendly-snippets",
      },
      config = function()
	require("plugin.completion")
      end,
    },
    {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons"},
	config = function()
	    require("oil").setup()
	end
    },
    {
	"ThePrimeagen/harpoon",
	dependencies = {"nvim-lua/plenary.nvim"},
	config = function()
	require("plugin.harpoon")
	end
    }
}
