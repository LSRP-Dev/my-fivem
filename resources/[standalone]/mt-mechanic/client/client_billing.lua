local QBCore = exports[Config.QBCoreName]:GetCoreObject()

RegisterNetEvent('mt-mechanic:client:Charge', function(data)
    local p = promise.new() lib.callback('mt-mechanic:MakePlayerList', source, function(cb) p:resolve(cb) end) 
    local onlineList = Citizen.Await(p) local nearbyList = {}
    for _, v in pairs(QBCore.Functions.GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), Config.PaymentRadius)) do
        local dist = #(GetEntityCoords(GetPlayerPed(v)) - GetEntityCoords(PlayerPedId()))
        for i = 1, #onlineList do
            if onlineList[i].value == GetPlayerServerId(v) then
                if v ~= PlayerId() then
                    nearbyList[#nearbyList+1] = { value = onlineList[i].value, label = tostring(onlineList[i].text..' ('..math.floor(dist+0.05)..'m)') }
                end
            end
        end
    end
    if not nearbyList[1] then QBCore.Functions.Notify(Lang.NoNearby, "error", 5000) return end
    local dialog = lib.inputDialog(Lang.CashRegister, {
        { type = "select", icon = 'user', required = true, label = " ", options = nearbyList },
        { type = 'select', icon = 'credit-card', required = true, label = Lang.PaymentType, options = { { value = "cash", label = Lang.Cash }, { value = "bank", label = Lang.Bank } } },
        { type = 'number', icon = 'dollar-sign', required = true, label = Lang.AmountMoney },
    })
    if dialog then
        if not dialog[1] or not dialog[3] then return end
        TriggerServerEvent('mt-mechanic:server:Charge', dialog[1], tonumber(dialog[3]), dialog[2])
    end
end)

RegisterNetEvent("mt-mechanic:client:PayPopup", function(amount, biller, billtype)
	lib.registerContext({
        id = 'mechanic_paypopup_menu',
        title = Lang.AceptPayment,
        options = {
            { title = tostring(billtype:gsub("^%l", string.upper)..Lang.PaymentAmount..amount), disabled = true },
            { icon = "circle-check", title = Lang.Yes, serverEvent = "mt-mechanic:server:PayPopup", args = { accept = true, amount = amount, biller = biller, billtype = billtype, gang = gang, outside = outside }  },
            { icon = "circle-xmark", title = Lang.No, serverEvent = "mt-mechanic:server:PayPopup", args = { accept = false, amount = amount, biller = biller, billtype = billtype, outside = outside }  }, 
        }
    })
    lib.showContext('mechanic_paypopup_menu')
end)