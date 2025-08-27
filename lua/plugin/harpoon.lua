local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local conf = require("harpoon").get_mark_config()

-- Keymaps
vim.keymap.set("n", "<leader>hh", function() ui.toggle_quick_menu() end, { desc = "Harpoon: Quick Menu" })
vim.keymap.set("n", "<leader>hd", function() mark.clear_all() end, { desc = "Harpoon: Add file" })

local function set_slot(n)
  local file = vim.fn.expand("%:p") -- full path
  conf.marks[n] = { filename = file }
end

vim.keymap.set("n", "<leader>h1", function() set_slot(1) end, { desc = "Harpoon: Set file in slot 1" })
vim.keymap.set("n", "<leader>h2", function() set_slot(2) end, { desc = "Harpoon: Set file in slot 2" })
vim.keymap.set("n", "<leader>h3", function() set_slot(3) end, { desc = "Harpoon: Set file in slot 3" })
vim.keymap.set("n", "<leader>h4", function() set_slot(4) end, { desc = "Harpoon: Set file in slot 4" })
vim.keymap.set("n", "<leader>h5", function() set_slot(5) end, { desc = "Harpoon: Set file in slot 4" })

vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, { desc = "Harpoon: Go to file 1" })
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, { desc = "Harpoon: Go to file 2" })
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, { desc = "Harpoon: Go to file 3" })
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, { desc = "Harpoon: Go to file 4" })
vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) end, { desc = "Harpoon: Go to file 5" })

