-- show network name in menu bar
wifiWatcher = nil
function ssidChanged()
    local wifiName = hs.wifi.currentNetwork()
    if wifiName then
        wifiMenu:setTitle(wifiName)
    else
        wifiMenu:setTitle("No Wi-Fi")
    end
end

wifiMenu = hs.menubar.new()
ssidChanged()
wifiWatcher = hs.wifi.watcher.new(ssidChanged):start()

-- hotkeys
hs.hotkey.bind({"ctrl"}, "T", function()
    hs.application.launchOrFocus("Terminal")
end)

hs.hotkey.bind({"alt"}, "C", function()
    hs.application.launchOrFocus("Brave Browser")
end)

hs.hotkey.bind({"alt"}, "V", function()
    hs.application.launchOrFocus("Visual Studio Code")
end)

hs.hotkey.bind({"alt"}, "S", function()
    hs.application.launchOrFocus("Slack")
end)
