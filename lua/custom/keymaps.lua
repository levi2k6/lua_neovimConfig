local config = require("custom.config")

vim.keymap.set("n", "<leader><Tab>", "<cmd>Oil<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Tab>", "<cmd>e#<CR>", { noremap = true, silent = true })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

vim.keymap.set(
    "n", 
    "<leader>n<Tab>",
    function()
	if config.isNumberRelative then
	    config.isNumberRelative = false
	    vim.wo.relativenumber = false
	else
	    config.isNumberRelative = true
	    vim.wo.relativenumber = true
	end
    end,
    { noremap = true, silent = true }
)

