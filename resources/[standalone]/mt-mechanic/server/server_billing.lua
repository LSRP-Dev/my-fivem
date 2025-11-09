local QBCore = exports[Config.QBCoreName]:GetCoreObject()

lib.callback.register('mt-mechanic:MakePlayerList', function(source)
	local onlineList = {}
	for _, v in pairs(QBCore.Functions.GetPlayers()) do
		local P = QBCore.Functions.GetPlayer(v)
		onlineList[#onlineList+1] = { value = tonumber(v), text = "["..v.."] - "..P.PlayerData.charinfo.firstname..' '..P.PlayerData.charinfo.lastname  }
	end
	return onlineList
end)

RegisterServerEvent("mt-mechanic:server:Charge", function(citizen, price, billtype)
	local src = source local biller = QBCore.Functions.GetPlayer(src) local billed = QBCore.Functions.GetPlayer(tonumber(citizen)) local amount = tonumber(price) local balance = billed.Functions.GetMoney(billtype)
	if amount and amount > 0 then
		if balance < amount then
			TriggerClientEvent('QBCore:Notify', source, Lang.CusNoCash, "error") TriggerClientEvent('QBCore:Notify', tonumber(citizen), Lang.YouNoCash, "error") return
		else
			local label = biller.PlayerData.job.label
			TriggerClientEvent("mt-mechanic:client:PayPopup", billed.PlayerData.source, amount, src, billtype) TriggerClientEvent('QBCore:Notify', source, Lang.InvoiceSuccess, "success") TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, Lang.InvoiceRecieved, "success")
		end
	else TriggerClientEvent('QBCore:Notify', source, Lang.ChargeZero, "error") return end
end)

RegisterServerEvent("mt-mechanic:server:PayPopup", function(data)
	local src = source local billed = QBCore.Functions.GetPlayer(src) local biller = QBCore.Functions.GetPlayer(tonumber(data.biller)) local newdata = { senderCitizenId = biller.PlayerData.citizenid, society = biller.PlayerData.job.name, amount = data.amount }
	if data.accept == true then
		billed.Functions.RemoveMoney(tostring(data.billtype), data.amount)
		exports[Config.QBManagementName]:AddMoney(biller.PlayerData.job.name, data.amount)
		biller.Functions.AddMoney('bank', math.floor(data.amount*Config.ComissionBill/100))
        TriggerClientEvent('QBCore:Notify', data.biller, billed.PlayerData.charinfo.firstname..Lang.AceptedPayment..data.amount, "success")
	elseif data.accept == false then
        TriggerClientEvent('QBCore:Notify', source, Lang.Declined, "success") TriggerClientEvent('QBCore:Notify', data.biller, billed.PlayerData.charinfo.firstname..Lang.DeclinePayment..data.amount..Lang.Payment, "error")
	end
end)