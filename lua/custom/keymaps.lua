
vim.keymap.set("n", "<Tab>", "<cmd>e#<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><Tab>", "<cmd>Ex<CR>", { noremap = true, silent = true})
vim.keymap.set("n", '"J', '"+', { noremap = true, silent = true })
vim.keymap.set("v", '"J', '"+', { noremap = true, silent = true })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
