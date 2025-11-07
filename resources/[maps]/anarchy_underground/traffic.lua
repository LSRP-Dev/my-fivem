



CreateThread(function()

	while true do 
		local ped = PlayerPedId()

		local time = 5000
		local coords = GetEntityCoords(ped)

		if #(coords - vec(-961.29, -797.2, 15.2)) <= 150.0 then 
			time = 0
			ClearAreaOfPeds(-961.29, -797.2, 15.2, 150.0, 1)
		end 
	--	ClearAreaOfVehicles(154.59, -882.51, 30.95, 250.0, false, false, false, false, false) -- 
		Wait(time)
	end 
end)
