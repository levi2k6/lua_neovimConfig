
local config = require("custom.config")

vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
    pattern="*",
    callback = function()
	vim.bo.shiftwidth = config.sizeWidth;
	vim.wo.number = config.isNumberSet;
	if config.isNumberRelative then
	    vim.wo.relativenumber = config.isNumberRelative
	elseif not config.isNumberRelative  then
	    vim.wo.relativenumber = config.isNumberRelative 
	end
    end
})
