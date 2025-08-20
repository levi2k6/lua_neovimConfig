
local config = require("custom.config")

vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
    pattern="*",
    callback = function()
	vim.bo.shiftwidth = config.sizeWidth;
	vim.wo.number = config.isNumberSet;
    end
})
