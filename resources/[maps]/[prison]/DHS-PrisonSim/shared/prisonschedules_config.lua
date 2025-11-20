PrisonSchedulesConfig = {}

PrisonSchedulesConfig.Schedules = {
    ["min"] = {
        { time = "00:00", State = "Lights-Out" },
        { time = "01:00", State = "Lights-Out" },
        { time = "02:00", State = "Lights-Out" },
        { time = "03:00", State = "Lights-Out" },
        { time = "04:00", State = "Lights-Out" },
        { time = "05:00", State = "Lights-Out" },
        { time = "06:00", State = "Rollcall" },
        { time = "07:00", State = "Breakfast" },
        { time = "08:00", State = "Breakfast" },
        { time = "09:00", State = "Work" },
        { time = "10:00", State = "Work" },
        { time = "11:00", State = "Lunch" },
        { time = "12:00", State = "Lunch" },
        { time = "13:00", State = "Free-Time" },
        { time = "14:00", State = "Work" },
        { time = "15:00", State = "Work" },
        { time = "16:00", State = "Yard" },
        { time = "17:00", State = "Yard" },
        { time = "18:00", State = "Dinner" },
        { time = "19:00", State = "Dinner" },
        { time = "20:00", State = "Free-Time" },
        { time = "21:00", State = "Free-Time" },
        { time = "22:00", State = "Shower" },
        { time = "23:00", State = "Lights-Out" },
    },
    ["med"] = {
        { time = "00:00", State = "Lights-Out" },
        { time = "01:00", State = "Lights-Out" },
        { time = "02:00", State = "Lights-Out" },
        { time = "03:00", State = "Lights-Out" },
        { time = "04:00", State = "Lights-Out" },
        { time = "05:00", State = "Lights-Out" },
        { time = "06:00", State = "Rollcall" },
        { time = "07:00", State = "Breakfast" },
        { time = "08:00", State = "Work" },
        { time = "09:00", State = "Work" },
        { time = "10:00", State = "Work" },
        { time = "11:00", State = "Lunch" },
        { time = "12:00", State = "Lights-Out" },--Nap Time
        { time = "13:00", State = "Work" },
        { time = "14:00", State = "Work" },
        { time = "15:00", State = "Work" },
        { time = "16:00", State = "Yard" },
        { time = "17:00", State = "Yard" },
        { time = "18:00", State = "Work" },
        { time = "19:00", State = "Dinner" },
        { time = "20:00", State = "Work" },
        { time = "21:00", State = "Yard" },
        { time = "22:00", State = "Shower" },
        { time = "23:00", State = "Lights-Out" },
    },
    ["max"] = {
        { time = "00:00", State = "Lights-Out" },
        { time = "01:00", State = "Lights-Out" },
        { time = "02:00", State = "Lights-Out" },
        { time = "03:00", State = "Lights-Out" },
        { time = "04:00", State = "Lights-Out" },
        { time = "05:00", State = "Lights-Out" },
        { time = "06:00", State = "Rollcall" },
        { time = "07:00", State = "Breakfast" },
        { time = "08:00", State = "Lights-Out" },
        { time = "09:00", State = "Work" },
        { time = "10:00", State = "Work" },
        { time = "11:00", State = "Lunch" },
        { time = "12:00", State = "Work" },
        { time = "13:00", State = "Work" },
        { time = "14:00", State = "Work" },
        { time = "15:00", State = "Work" },
        { time = "16:00", State = "Work" },
        { time = "17:00", State = "Work" },
        { time = "18:00", State = "Work" },
        { time = "19:00", State = "Dinner" },
        { time = "20:00", State = "Work" },
        { time = "21:00", State = "Work" },
        { time = "22:00", State = "Shower" },
        { time = "23:00", State = "Lights-Out" },
    }
}

PrisonSchedulesConfig.NotifyTimes = 10000  --MS

PrisonSchedulesConfig.Zones = { -- DO NOT ADD ANY NEW ZONES, ONLY EDIT THE EXISTING ONES COORDS AND SIZE DONT CHANGE THE NAME
    {
        coords = vector4(1612.63, 2476.03, 45.65, 139.22),
        size = { x = 55.0, y = 30.0, z = 10.0 },
        name = "Min Cell Block" -- Prisoners Should Be Here If they are in Min Security, and if its Lights Out or Rollcall this is mandatory
    },
    {
        coords = vector4(1612.02, 2497.21, 45.65, 321.21),
        size = { x = 3.0, y = 2.0, z = 4.0 },
        name = "Min Shower" -- Prisoners Should Be Here If they are in Min Security, and if its Lights Out or Rollcall this is mandatory
    },
    {
        coords = vector4(1692.43, 2448.71, 45.65, 179.48),
        size = { x = 55.0, y = 30.0, z = 10.0 },
        name = "Med Cell Block" -- Prisoners Should Be Here If they are in Med Security, and if its Lights Out or Rollcall this is mandatory
    },
    {
        coords = vector4(1678.0, 2466.0, 46.0, 0.00),
        size = { x = 3.0, y = 2.0, z = 4.0 },
        name = "Med Shower" -- Prisoners Should Be Here If they are in Med Security, and if its Lights Out or Rollcall this is mandatory
    },
    {
        coords = vector4(1764.3, 2483.68, 45.65, 209.41),
        size = { x = 55.0, y = 30.0, z = 10.0 },
        name = "Max Cell Block" -- Prisoners Should Be Here If they are in Max Security, and if its Lights Out or Rollcall this is mandatory
    },
    {
        coords = vector4(1743.49, 2491.3, 45.65, 29.27),
        size = { x = 3.0, y = 2.0, z = 4.0 },
        name = "Max Shower" -- Prisoners Should Be Here If they are in Med Security, and if its Lights Out or Rollcall this is mandatory
    },
    {
        coords = vec4(1736.7, 2576.5, 45.0, 0.0),
        size = vec3(24.85, 22.0, 14.05),
        name = "Cafeteria" --Prisoners Should Be Here If its Breakfast, Lunch or Dinner Time
    },
    {
        coords = vec4(1582.0, 2549.0, 45.0, 90.0),
        size = vec3(32, 30.0, 8.0),
        name = "Work" --Prisoners Should Be Here If its Work Time
    },
    {
        coords = vector4(1691.39, 2524.78, 45.56, 0.0),
        size = vec3(180, 80, 10),
        name = "Yard" --Prisoners Should Be Here If its Work Time
    },
}
