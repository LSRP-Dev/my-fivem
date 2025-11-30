CreateThread(function()
    while true do
        if not IsRadarHidden() then
            DisplayRadar(true)
        end
        Wait(500)
    end
end)

