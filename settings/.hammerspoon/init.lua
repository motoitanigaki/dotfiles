wifiWatcher = nil
http_async_get = hs.http.asyncGet

function getPublicIP(callback)
    local url = "https://api.ipify.org?format=json"
    http_async_get(url, nil, function(status, body, headers)
        if status < 0 then
            hs.notify.show("Error", "Unable to fetch public IP", "")
            return
        end

        local result = hs.json.decode(body)
        callback(result.ip)
    end)
end

function ssidChanged()
    local wifiName = hs.wifi.currentNetwork()
    if wifiName then
        getPublicIP(function(ip)
            wifiMenu:setTitle(wifiName .. " " .. ip)
        end)
    else
        wifiMenu:setTitle("Wifi OFF")
    end
end

wifiMenu = hs.menubar.newWithPriority(2147483645)
ssidChanged()

wifiWatcher = hs.wifi.watcher.new(ssidChanged):start()