return{
    {
	"nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
	config = function()
	    require("plugin.treesitter")
	end
    },
    {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
	    vim.cmd("colorscheme gruvbox")
	end
    },
    { "nvim-lualine/lualine.nvim", config = true},
    {"williamboman/mason.nvim", config = true},
    {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    event = { "BufReadPre", "BufNewFile"},
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
