require("lsp")
local presets = require("presets")

vim.g.mapleader = " "

vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
    pattern="*",
    callback = function()
	vim.bo.shiftwidth = presets.sizeWidth;
	vim.wo.number = presets.isNumberSet;
    end
})

vim.keymap.set("n", "<Tab>", "<cmd>e#<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><Tab>", "<cmd>Ex<CR>", { noremap = true, silent = true})
vim.keymap.set("n", '"J', '"+', { noremap = true, silent = true })
vim.keymap.set("v", '"J', '"+', { noremap = true, silent = true })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

require("telescope").setup{}

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader><leader>", builtin.buffers, {}) 
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {}) 

