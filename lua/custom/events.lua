local settings = require("custom.settings.settings")
local manager = require("custom.settings.settingsManager")

print("events is on")

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    callback = function()
        manager.apply(settings)
    end
})

-- onQuit
vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        manager.save(settings)
    end
})
