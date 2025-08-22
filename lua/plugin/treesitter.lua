require("nvim-treesitter.configs").setup {
  ensure_installed = { "c", "cpp", "lua", "python", "go", "java" },
  highlight = { enable = true },
  indent = { enable = true },
}
