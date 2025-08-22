local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local conf = require("harpoon").get_mark_config()

-- Keymaps
vim.keymap.set("n", ";;", function() ui.toggle_quick_menu() end, { desc = "Harpoon: Quick Menu" })
vim.keymap.set("n", ";d", function() mark.rm_file() end, { desc = "Harpoon: Add file" })

local function set_slot(n)
  local file = vim.fn.expand("%:p") -- full path
  conf.marks[n] = { filename = file }
end

vim.keymap.set("n", ";j1", function() set_slot(1) end, { desc = "Harpoon: Set file in slot 1" })
vim.keymap.set("n", ";j2", function() set_slot(2) end, { desc = "Harpoon: Set file in slot 2" })
vim.keymap.set("n", ";j3", function() set_slot(3) end, { desc = "Harpoon: Set file in slot 3" })
vim.keymap.set("n", ";j4", function() set_slot(4) end, { desc = "Harpoon: Set file in slot 4" })
vim.keymap.set("n", ";j5", function() set_slot(5) end, { desc = "Harpoon: Set file in slot 4" })

vim.keymap.set("n", ";1", function() ui.nav_file(1) end, { desc = "Harpoon: Go to file 1" })
vim.keymap.set("n", ";2", function() ui.nav_file(2) end, { desc = "Harpoon: Go to file 2" })
vim.keymap.set("n", ";3", function() ui.nav_file(3) end, { desc = "Harpoon: Go to file 3" })
vim.keymap.set("n", ";4", function() ui.nav_file(4) end, { desc = "Harpoon: Go to file 4" })
vim.keymap.set("n", ";5", function() ui.nav_file(5) end, { desc = "Harpoon: Go to file 5" })

