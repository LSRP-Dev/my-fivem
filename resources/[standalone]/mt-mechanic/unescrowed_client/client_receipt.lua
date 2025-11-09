local QBCore = exports[Config.QBCoreName]:GetCoreObject()

RegisterNetEvent('mt-mechanic:client:OpenModsReceiptMenu', function(info, slot)
    local text = ''
    for k, v in pairs(Config.Colours) do
        for a, u in pairs(Config.Colours[k]) do
            if u.Number == info.PColor then info.PColor = u.Label end
            if u.Number == info.SColor then info.SColor = u.Label end
            if u.Number == info.WHColor then info.WHColor = u.Label end
            if u.Number == info.PRColor then info.PRColor = u.Label end
            if u.Number == info.DSHColor then info.DSHColor = u.Label end
            if u.Number == info.INTColor then info.INTColor = u.Label end
        end
    end
    if info.Wheels ~= "NoChanges" then text = text..tostring('\n Wheels: '..info.Wheels) end
    if info.Roof ~= "NoChanges" then text = text..tostring('\n Roof: '..info.Roof) end
    if info.Livery ~= "NoChanges" then text = text..tostring('\n Livery: '..info.Livery) end
    if info.Exhaust ~= "NoChanges" then text = text..tostring('\n Exhaust: '..info.Exhaust) end
    if info.FBumper ~= "NoChanges" then text = text..tostring('\n Front Bumper: '..info.FBumper) end
    if info.RBumper ~= "NoChanges" then text = text..tostring('\n Rear Bumper: '..info.RBumper) end
    if info.Spoiler ~= "NoChanges" then text = text..tostring('\n Spoiler: '..info.Spoiler) end
    if info.Skirt ~= "NoChanges" then text = text..tostring('\n Skirt: '..info.Skirt) end
    if info.Bonnet ~= "NoChanges" then text = text..tostring('\n Bonnet: '..info.Bonnet) end
    if info.Grill ~= "NoChanges" then text = text..tostring('\n Grill: '..info.Grill) end
    if info.Horn ~= "NoChanges" then text = text..tostring('\n Horn: '..info.Horn) end
    if info.PColor ~= "NoChanges" then text = text..tostring('\n Primary Color: '..info.PColor) end
    if info.SColor ~= "NoChanges" then text = text..tostring('\n Secondary Color: '..info.SColor) end
    if info.INTColor ~= "NoChanges" then text = text..tostring('\n Interior Color: '..info.INTColor) end
    if info.DSHColor ~= "NoChanges" then text = text..tostring('\n Dashboard Color: '..info.DSHColor) end
    if info.WHColor ~= "NoChanges" then text = text..tostring('\n Wheels Color: '..info.WHColor) end
    if info.PRColor ~= "NoChanges" then text = text..tostring('\n Pearcelent Color: '..info.PRColor) end
    if info.RGBPColor ~= "NoChanges" then text = text..tostring('\n Primary RGB Color: '..info.RGBPColor) end
    if info.RGBSColor ~= "NoChanges" then text = text..tostring('\n Secondary RGB Color: '..info.RGBSColor) end
    if info.Interior1 ~= "NoChanges" then text = text..tostring('\n Interior 1: '..info.Interior1) end
    if info.Interior2 ~= "NoChanges" then text = text..tostring('\n Interior 2: '..info.Interior2) end
    if info.Interior3 ~= "NoChanges" then text = text..tostring('\n Interior 3: '..info.Interior3) end
    if info.Interior4 ~= "NoChanges" then text = text..tostring('\n Interior 4: '..info.Interior4) end
    if info.Interior5 ~= "NoChanges" then text = text..tostring('\n Interior 5: '..info.Interior5) end
    if info.Interior6 ~= "NoChanges" then text = text..tostring('\n Seats: '..info.Interior6) end
    if info.Interior7 ~= "NoChanges" then text = text..tostring('\n Steering: '..info.Interior7) end
    if info.Trunk ~= "NoChanges" then text = text..tostring('\n Trunk: '..info.Trunk) end
    if info.Hydro ~= "NoChanges" then text = text..tostring('\n Hydro: '..info.Hydro) end
    if info.EngineBay1 ~= "NoChanges" then text = text..tostring('\n Engine Bay 1: '..info.EngineBay1) end
    if info.EngineBay2 ~= "NoChanges" then text = text..tostring('\n Engine Bay 2: '..info.EngineBay2) end
    if info.EngineBay3 ~= "NoChanges" then text = text..tostring('\n Engine Bay 3: '..info.EngineBay3) end
    if info.Chassi1 ~= "NoChanges" then text = text..tostring('\n Chassis 1: '..info.Chassi1) end
    if info.Chassi2 ~= "NoChanges" then text = text..tostring('\n Chassis 2: '..info.Chassi2) end
    if info.Chassi3 ~= "NoChanges" then text = text..tostring('\n Chassis 3: '..info.Chassi3) end
    if info.Chassi4 ~= "NoChanges" then text = text..tostring('\n Chassis 4: '..info.Chassi4) end
    if info.Chassi5 ~= "NoChanges" then text = text..tostring('\n Chassis 5: '..info.Chassi5) end
    if info.LeftFender ~= "NoChanges" then text = text..tostring('\n Left Fender: '..info.LeftFender) end
    if info.RightFender ~= "NoChanges" then text = text..tostring('\n Right Fender: '..info.RightFender) end
    if info.Livery2 ~= "NoChanges" then text = text..tostring('\n Livery: '..info.Livery2) end
    lib.registerContext({
        id = 'receipt_menu',
        title = Lang.ReceiptMenuHeader,
        options = {
            { title = info.plate..tostring(text), disabled = true },
            { title = Lang.DestroyReceipt, icon = 'dumpster', event = 'mt-mechanic:client:DestroyReceipt', args = { slt = slot } },
        }
    })
    lib.showContext('receipt_menu')
end)

RegisterNetEvent('mt-mechanic:client:DestroyReceipt', function(data)
    TriggerServerEvent('mt-mechanic:server:RemoveItem', 'mechanic_mods_receipt', 1, data.slt)
end)