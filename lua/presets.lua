local sizeWidth = 4
local isNumberSet = true

local setSwCommand = function()
    vim.bo.shiftwidth = sizeWidth
end
local setNumberCommand = function()
    vim.wo.number = isNumberSet
end

local presets = {
    sizeWidth = sizeWidth,
    isNumberSet = isNumberSet,
    setSwCommand = setSwCommand,
    setNumberCommand = setNumberCommand
}

return presets

