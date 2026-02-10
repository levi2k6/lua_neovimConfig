local settings = require("custom.settings.settings")
local manager = require("custom.settings.settingsManager")

-- settings = manager.load() or settings
local loaded = manager.load()
if loaded then
    for k, v in pairs(loaded) do
        settings[k] = v
    end
end

manager.setupCommands(settings)
manager.apply(settings)
