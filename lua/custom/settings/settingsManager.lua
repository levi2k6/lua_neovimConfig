local settingsDir = vim.fn.stdpath("data") .. "/my_settings"
vim.fn.mkdir(settingsDir, "p")
local settingsPath = settingsDir .. "/state.lua"

-- save
local function saveSettings(tbl)
    local lines = { "return {" }
    for k, v in pairs(tbl) do
        local val = type(v) == "string" and string.format("%q", v) or tostring(v)
        table.insert(lines, "  " .. k .. " = " .. val .. ",")
    end
    table.insert(lines, "}")
    vim.fn.writefile(lines, settingsPath)
end

-- load
local function loadSettings()
    local ok, loaded = pcall(dofile, settingsPath)
    if ok and loaded then return loaded end
    return nil
end

-- apply
local function applySettings(tbl)
	-- local str = vim.inspect(tbl, { newline = "", indent = "" })
	-- print(str)  -- goes straight to :messages

    if tbl.isNumberSet ~= nil then
        vim.wo.number = tbl.isNumberSet
    end
    if tbl.isNumberRelative ~= nil then
        vim.wo.relativenumber = tbl.isNumberRelative
    end
    if tbl.sizeWidth ~= nil then
        vim.o.shiftwidth = tbl.sizeWidth
        vim.o.tabstop = tbl.sizeWidth
    end
end

local function setupCommands(settings)
    vim.api.nvim_create_user_command("SetRelative", function(opts)
        local val = opts.args:lower()
        if val == "true" then
            settings.isNumberRelative = true
        elseif val == "false" then
            settings.isNumberRelative = false
        else
            print("Use true or false")
            return
        end
		-- saveSettings(settings)
        applySettings(settings)
    end, { nargs = 1 })

    vim.api.nvim_create_user_command("SetNumber", function(opts)
        local val = opts.args:lower()
        if val == "true" then
            settings.isNumberSet = true
        elseif val == "false" then
            settings.isNumberSet = false
        else
            print("Use true or false")
            return
        end
		-- saveSettings(settings)
        applySettings(settings)
    end, { nargs = 1 })

    vim.api.nvim_create_user_command("SetWidth", function(opts)
        local num = tonumber(opts.args)
        if num then
            settings.sizeWidth = num
			-- saveSettings(settings)
            applySettings(settings)
        else
            print("Invalid number")
        end
    end, { nargs = 1 })

    vim.api.nvim_create_user_command("Test", function()
        print(vim.inspect(settings))
    end, { nargs = 0 })

end


return {
    save = saveSettings,
    load = loadSettings,
    apply = applySettings,
    setupCommands = setupCommands,
    path = settingsPath
}

